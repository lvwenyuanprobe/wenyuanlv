//
//  AppDelegate.m
//  mybigbrother
//
//  Created by wang on 2017/3/29.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "AppDelegate.h"

// 版本更新
#import "DFWUpdateView.h"
#import "AYCheckManager.h"

#import "MainBarViewController.h"
#import "WelcomeController.h"

#import <UserNotifications/UserNotifications.h>

#pragma mark - ShareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"

/** 极光推送*/
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


#import "MBBMessagesController.h"
#import "DriverDistanceController.h"
#import "MyOrderController.h"

#define  KWechatAppId @"wx38748659cbb964ca"

#define  KWechatAppId @"wx38748659cbb964ca"
//1一定要先配置自己项目在商店的APPID,配置完最好在真机上运行才能看到完全效果哦
#define STOREAPPID @"1236644117"

@interface AppDelegate ()<UNUserNotificationCenterDelegate,JPUSHRegisterDelegate>
@property (nonatomic,strong) NSString *localVersion;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.backgroundColor = [UIColor whiteColor];
    
//    if (@available(iOS 11.0, *)){
//        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
//    }
    
//    self.window.backgroundColor = [UIColor whiteColor];
    /** 设置Bugtags管理(上线设置BTGInvocationEventNone静默)*/
    BugtagsOptions * options = [[BugtagsOptions alloc]init];
    options.trackingCrashes = YES;    
#if DEBUG
    [Bugtags startWithAppKey:@"15016321e0c4ceb3585e5f44767f4bf1" invocationEvent:BTGInvocationEventShake];
#else
    [Bugtags startWithAppKey:@"15016321e0c4ceb3585e5f44767f4bf1" invocationEvent:BTGInvocationEventNone];
#endif
    
    /** 启动页延时(系统1.5s)*/
    [NSThread sleepForTimeInterval:0.5];
    
    /*** 设置第三方key*/
    [self configThirdKey];
    
    /** 注册APNs*/
    [self registerRemoteNotification];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    /**
     iOS 9.0之后,新的SDK不允许在设置rootViewController之前做过于复杂的操作，
     导致在didFinishLaunchingWithOptions 结束后还没有设置rootViewController
     Xcode7需要所有UIWindow必须立即先设置一个rootViewController
     */
    MainBarViewController * mainVC = [[MainBarViewController alloc] init];
    self.window.rootViewController = mainVC;
    /** 设置根视图*/
    [self.window makeKeyAndVisible];
    
    [self showVC];

    /**引导页结束重置根视图*/
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(createLateralSpreadAction)
                                                name:MBB_RECREATE_ROOT
                                              object:nil];

    
    /** JPush 内容(因为点击推送而启动app的)*/
    NSDictionary * remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    NSLog(@"%@",remoteNotification);
    
#pragma mark - 版本检测更新 -
//    [self VersonUpdate];
    [self setupCheckVersion];
    
    return YES;
}
#pragma mark - 设置第三方key
- (void)configThirdKey{
   
    /** YTK设置*/
    YTKNetworkConfig * config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = Server_Host;

    /** IQKeyBoard*/
    IQKeyboardManager * KeyBoardManager = [IQKeyboardManager sharedManager];
    KeyBoardManager.shouldResignOnTouchOutside = YES;
    
    /** 高德地图(apiKey上线设置修改,注意广告标识符设置IDFA)*/
    [AMapServices sharedServices].apiKey = @"d126cd1a47b2654d975da39448fa89bd";
    
    /** 微信设置*/
    [WXApi registerApp:KWechatAppId];
    
    /** 极光推送*/
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc]init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Required
    
#if DEBUG
    [JPUSHService setupWithOption:nil appKey:@"3efb93672c487226b3dfda7c"
                          channel:@""
                 apsForProduction:NO /** 注意该字段与证书保持一致 0 开发 1 生产*/
            advertisingIdentifier:nil];
#else
    [JPUSHService setupWithOption:nil appKey:@"3efb93672c487226b3dfda7c"
                          channel:@""
                 apsForProduction:YES  /** 注意该字段与证书保持一致 0 开发 1 生产*/
            advertisingIdentifier:nil];
#endif
    /** ShareSDK 设置*/
    [self shareSDKConfing];
  
}
- (void)shareSDKConfing{
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"1cfb2bed4b5a2"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeSinaWeibo),
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"533385079"
                                           appSecret:@"07f5d6fa6038684d54fc337ff19b6a25"
                                         redirectUri:@"http://open.weibo.com/apps/533385079/privilege/oauth"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:KWechatAppId
                                       appSecret:@"8403147b8e27197be0e3fe856c190e64"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106162922"
                                      appKey:@"g8OtxTnXNHM6M21u"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
    
}
#pragma mark  - 展示初始界面
- (void)showVC {
    NSString *key = @"CFBundleShortVersionString";
    //沙盒中取出上次使用的版本号
    NSString *lastVerionCode = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //加载程序中info.plist文件（获取当前软件的版本号）
    NSString *currentVerionCode = [NSBundle mainBundle].infoDictionary[key];

    if ([lastVerionCode isEqualToString:currentVerionCode]) {
        //非第一次使用
        //启动的时候，不可以显示登录界面----原因在myuserdefault里面
        // 非第一次使用，并且当前是WIFI环境时，尝试先加载广告页面
        if (ReachableViaWiFi == [MBBNetworkManager checkCurrentNetWork]) {

            /** 加载广告页完成->加载*/

        } else {
            
            [self createLateralSpreadAction];
        }
        
    } else {
        //保存当前软件版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVerionCode forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        /** 新手引导欢迎页面*/
        WelcomeController *  handLeadVC = [[WelcomeController alloc] init];
        self.window.rootViewController = handLeadVC;
    }
}
    
- (void)createLateralSpreadAction{
    MainBarViewController * mainVC = [[MainBarViewController alloc] init];
    self.window.rootViewController = mainVC;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 推送
// 注册APNs的方法
- (void)registerRemoteNotification {
#if !TARGET_IPHONE_SIMULATOR
    UIApplication *application = [UIApplication sharedApplication];
    /** 注册APNS*/
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
       
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
        
    } else {
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    /** iOS10 注册推送*/
    if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error ){
                
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }
#endif
}
#pragma mark - 推送设置
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"Userinfo = %@",notification.request.content.userInfo);
    //功能：可设置是否在应用内弹出通知
    completionHandler(UNNotificationPresentationOptionAlert);
}
/** iOS10 点击推送消息后回调*/
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    NSLog(@"Userinfo = %@",response.notification.request.content.userInfo);
    /** 设置推送跳转(
     预定字段名称target:
     message  (消息中心)
     distance (我的行程)
     order    (我的订单)
     */
    [JPUSHService handleRemoteNotification:response.notification.request.content.userInfo];
    /** */
    [self goToMessageControllerWith:response.notification.request.content.userInfo];
}
/** iOS9 点击推送消息后回调*/
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"Userinfo = %@",userInfo);
    [JPUSHService handleRemoteNotification:userInfo];
    [self goToMessageControllerWith:userInfo];
}

- (void)goToMessageControllerWith:(NSDictionary *)messageInfo{
    /** 创建下一界面导航栏所需*/
    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@"JPush"forKey:@"JPush"];
    [pushJudge synchronize];
    
    NSString * targetStr = [messageInfo objectForKey:@"target"];
    if ([targetStr isEqualToString:@"message"]) {
        if (self.window.rootViewController.presentedViewController) {
            [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
        }
        MBBMessagesController * VC = [[MBBMessagesController alloc]init];
        MBBNavigationController * Nav = [[MBBNavigationController alloc]initWithRootViewController:VC];
        [self.window.rootViewController presentViewController:Nav animated:YES completion:nil];
    }
    if ([targetStr isEqualToString:@"distance"]) {
        if (self.window.rootViewController.presentedViewController) {
            [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
        }
        DriverDistanceController * VC = [[DriverDistanceController alloc]init];
        MBBNavigationController * Nav = [[MBBNavigationController alloc]initWithRootViewController:VC];
        [self.window.rootViewController presentViewController:Nav animated:YES completion:nil];
    }
    if ([targetStr isEqualToString:@"order"]) {
        if (self.window.rootViewController.presentedViewController) {
            [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
        }
         MyOrderController * VC = [[MyOrderController alloc]init];
        MBBNavigationController * Nav = [[MBBNavigationController alloc]initWithRootViewController:VC];
        [self.window.rootViewController presentViewController:Nav animated:YES completion:nil];
    }
}

/*** 注册deviceToken失败，一般是环境配置或者证书配置有误*/
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.failToRegisterApns",
                                                          Fail to register apns) message:error.description
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - 获取deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /** 极光推送*/
    [JPUSHService registerDeviceToken:deviceToken];
    /** 获取registerID*/
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID){
        NSLog(@"reCode: %d ,registrationID: %@",resCode,registrationID);
        /** 上传*/
        [MBBToolMethod putJPushRegistrationID:registrationID];        
    }];
    //获取device，放在本地
    NSString * token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                                             withString:@""]
                        stringByReplacingOccurrencesOfString:@">"
                        withString:@""]
                       stringByReplacingOccurrencesOfString:@" "
                       withString:@""];
   
    ZXLog(@"token = %@", token);
    [MBBToolMethod putDeviceToken:token];
}

#pragma mark - 支付设置
/** iOS9 之前,设置代理的方法(兼容9之前)*/
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
   
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [WXApi handleOpenURL:url delegate:self];
}
/** iOS9 之后,设置代理的方法*/
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{

#pragma mark - 支付宝设置
    /** 支付宝iOS 9.0 之后*/
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                NSNotification * notification = [NSNotification notificationWithName:ALIPAY_NOTIFA object:@"1" userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }else{
                NSNotification * notification = [NSNotification notificationWithName:ALIPAY_NOTIFA object:@"0" userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
            
        }];
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return [WXApi handleOpenURL:url delegate:self];

}
- (void)onResp:(BaseResp *)resp{
    
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle = nil;
    if ([resp isKindOfClass:[PayResp class]]) {
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode) {
            case WXSuccess: {
                NSNotification * notification = [NSNotification notificationWithName:WECHATPAY_NOTIFA object:@"1" userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            } break;
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败!"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                                message:strMsg
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                [[NSNotificationCenter defaultCenter] postNotificationName:WECHATPAY_NOTIFA object:@"0"];
                break;
        }
    }

}
#pragma mark - JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    completionHandler(UNNotificationPresentationOptionAlert);
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    // 系统要求执行这个方法
    completionHandler();
}
#pragma MARK - 版本更新设置 -

- (void)setupCheckVersion
{
    AYCheckManager *checkManger = [AYCheckManager sharedCheckManager];
    checkManger.countryAbbreviation = @"cn";
    [checkManger checkVersion];
}



@end








