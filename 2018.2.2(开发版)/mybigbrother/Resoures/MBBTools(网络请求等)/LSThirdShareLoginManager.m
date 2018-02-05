//
//  LSThirdShareLoginManager.m
//  mybigbrother
//
//  Created by SN on 2017/4/28.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "LSThirdShareLoginManager.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"

@implementation LSThirdShareLoginManager

#pragma mark - 分享


+ (void)shareInfomationToFriends:(LSSDKPlatform )SDKType
                          images:(NSArray *)imageArray
                          urlStr:(NSString *)urlStr
                           title:(NSString *)title
                            text:(NSString *)text{
    
    if (![self checkOutInstalled:SDKType]) {
        return;
    }
    //1、创建分享参数()
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:text
                                     images:imageArray
                                        url:[NSURL URLWithString:urlStr]
                                      title:title
                                       type:SSDKContentTypeAuto];
    
    
    /** 有的平台要客户端分享需要加此方法，例如微博*/
    [shareParams SSDKEnableUseClientShare];
    /**自定制UI 传入分享的平台类型(子平台)*/
    if (SDKType == LSSDKPlatformSubTypeWeixin) {
        [ShareSDK share:SSDKPlatformSubTypeWechatSession
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error)
         {
             // 回调处理....
             [self shareStateShow:state];
         }];
    }
    
    if (SDKType == LSSDKPlatformSubTypeQQ) {
        [ShareSDK share:SSDKPlatformSubTypeQQFriend
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error)
         {
             // 回调处理....
             [self shareStateShow:state];
             
         }];
    }
    if (SDKType == LSSDKPlatformSubTypeWeibo) {
        [ShareSDK share:SSDKPlatformTypeSinaWeibo
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error)
         {
             // 回调处理....
             [self shareStateShow:state];
         }];
    }
}
+ (void)shareStateShow:(SSDKResponseState)state{
    switch (state) {
        case SSDKResponseStateSuccess:
        {
            [MyControl alertShow:@"分享成功"];
            break;
        }
        case SSDKResponseStateFail:
        {
            [MyControl alertShow:@"分享失败"];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 登陆
+ (void)thirdAuthorizeLogin:(LSSDKPlatform)SDKType{
    
    /** ShareSDK 提供两种授权登陆的方法(ShareSDK和SSEThirdPartyLoginHelper)*/
    /** 微信授权*/
    if (SDKType == LSSDKPlatformSubTypeWeixin) {
        
        [ShareSDK getUserInfo:SSDKPlatformTypeWechat
               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
         {
             if (state == SSDKResponseStateSuccess)
             {
                 NSLog(@"uid=%@",user.uid);
                 NSLog(@"%@",user.credential);
                 NSLog(@"token=%@",user.credential.token);
                 NSLog(@"nickname=%@",user.nickname);
                 
                 NSMutableDictionary * infoDic = [NSMutableDictionary dictionary];
                 infoDic[@"third_openid"] = user.uid;
                 infoDic[@"u_nickname"] = user.nickname;
                 infoDic[@"u_img"] = user.icon;
                 /** 1 微信 2 QQ 3 微博*/
                 infoDic[@"type"] = @(1);
                 
                 [self loginByThird:infoDic];
             }
             else
             {
                 NSLog(@"%@",error);
                 
             }
             
         }];
        
    }
    /** QQ授权*/
    if (SDKType == LSSDKPlatformSubTypeQQ) {
        [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ
                                       onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                           //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                           //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                           associateHandler (user.uid, user, user);
                                           NSLog(@"dd%@",user.rawData);
                                           NSLog(@"dd%@",user.credential);
                                           
                                           NSMutableDictionary * infoDic = [NSMutableDictionary dictionary];
                                           infoDic[@"third_openid"] = user.uid;
                                           infoDic[@"u_nickname"] = user.nickname;
                                           infoDic[@"u_img"] = user.icon;
                                           /** 1 微信 2 QQ 3 微博*/
                                           infoDic[@"type"] = @(2);
                                           
                                           [self loginByThird:infoDic];
                                       }
                                    onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                        
                                        if (state == SSDKResponseStateSuccess)
                                        {
                                            
                                        }
                                    }];
    }
    /** 微博授权*/
    if (SDKType == LSSDKPlatformSubTypeWeibo) {
        [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
         {
             if (state == SSDKResponseStateSuccess)
             {
                 NSLog(@"uid=%@",user.uid);
                 NSLog(@"%@",user.credential);
                 NSLog(@"token=%@",user.credential.token);
                 NSLog(@"nickname=%@",user.nickname);
                 
                 NSMutableDictionary * infoDic = [NSMutableDictionary dictionary];
                 infoDic[@"third_openid"] = user.uid;
                 infoDic[@"u_nickname"] = user.nickname;
                 infoDic[@"u_img"] = user.icon;
                 /** 1 微信 2 QQ 3 微博*/
                 infoDic[@"type"] = @(3);
                 
                 [self loginByThird:infoDic];
             }
             else
             {
                 NSLog(@"%@",error);
             }
         }];
        
    }
}

#pragma mark - 授权第三方登陆
+ (void)loginByThird:(NSMutableDictionary *)infoDic{
    [MBProgressHUD showSuccess:@"请稍后..." toView:nil];
    [MBBNetworkManager thirdFastLogin:infoDic responseResult:^(YTKBaseRequest *request) {
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"登陆成功" toView:nil];
            /** 建立映射模型*/
            MBBUserInfoModel * model =  [[MBBUserInfoModel alloc]initWithDictionary:request.responseJSONObject];
            NSDictionary * infoDic = [model toDictionary];
            /** 写入本地(不能有null)*/
            [MBBToolMethod setUserInfo:infoDic];
            ZXLog(@"%@",model.token);
            /** 登陆成功通知*/
            [[NSNotificationCenter defaultCenter]postNotificationName:MBB_LOGIN_IN object:nil];
        }else{
            
            [MBProgressHUD showError:@"请重试..." toView:nil];
        }
    }];
}
#pragma mark - chekoutInstall (授权登陆不做检测)
+ (BOOL)checkOutInstalled:(LSSDKPlatform )SDKType{
    
    if (SDKType == LSSDKPlatformSubTypeWeixin) {
        if (![WXApi isWXAppInstalled]) {
            [MyControl alertShow:@"请安装微信"];
            return NO;
        }else{
            
            return YES;
        }
    }
    if (SDKType == LSSDKPlatformSubTypeQQ) {
        if (![QQApiInterface isQQInstalled]) {
            [MyControl alertShow:@"请安装QQ"];
            return NO;
        }else{
            return YES;
        }
    }
    if (SDKType == LSSDKPlatformSubTypeWeibo) {
        
        if (![WeiboSDK isWeiboAppInstalled]) {
            [MyControl alertShow:@"请安装微博"];
            return NO;
        }else{
            return YES;
        }
    }
    return 0;
}
@end
