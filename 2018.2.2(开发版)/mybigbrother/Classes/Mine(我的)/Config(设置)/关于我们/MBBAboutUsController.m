//
//  MBBAboutUsController.m
//  mybigbrother
//
//  Created by SN on 2017/5/19.
//  Copyright © 2017年 思能教育咨询(3333大连)有限公司. All rights reserved.
//

#import "MBBAboutUsController.h"


#import "MBBChoosePayMethodView.h"

#import "MBBPayManager.h"
#import "BAAlert_OC.h"

@interface MBBAboutUsController ()

/** 付款方式*/
@property(nonatomic, assign) KPayMethodType payType;
@property (nonatomic, strong) BAActionSheet  *actionSheet;
@end

@implementation MBBAboutUsController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 设定通知*/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payResult:) name:WECHATPAY_NOTIFA object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payResult:) name:ALIPAY_NOTIFA object:nil];

    NSString * urlStr = [NSString string];
    /** 关于我们*/
    if([self.loadType isEqualToString:@"0"]){
        
        urlStr = MBB_ABOUTUS;
        self.navigationItem.title = @"关于我们";
    }
    
    /** 活动规则*/
    if([self.loadType isEqualToString:@"1"]){
        
        urlStr = MBB_ACTIVITY_RULE;
        self.navigationItem.title = @"活动规则";

    }

    /** 用户协议*/
    if([self.loadType isEqualToString:@"2"]){
        
        urlStr = MBB_USER_AGREEMENT;
        self.navigationItem.title = @"用户协议";
    }
    
    /** 提现说明*/
    if([self.loadType isEqualToString:@"3"]){
        
        urlStr = MBB_GETCASH_RULE;
        self.navigationItem.title = @"提现说明";
    }
    
    /** 提现说明*/
    if([self.loadType isEqualToString:@"4"]){
        
        urlStr = MBB_PAYAGREEMENT;
        self.navigationItem.title = @"支付协议";
    }
    
    /** banner*/
    if([self.loadType isEqualToString:@"5"]){
        if (self.HomeModel) {
            self.navigationItem.title = self.HomeModel.b_title;
            urlStr = self.HomeModel.b_url;
        }
        if (self.ServiceModel) {
            self.navigationItem.title = self.ServiceModel.b_title;
            urlStr = self.ServiceModel.b_url;
        }
        
    }

    UIWebView * webView;
    
    if (kDevice_Is_iPhoneX) {
         webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44)];
    }else{
         webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    }
    webView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    webView.scrollView.bounces = NO;
    webView.delegate = self;
   
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    [self.view addSubview:webView];
    self.webViewDoc = webView;
    /** 监听*/
    
}
-(BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    // 设置javaScriptContext上下文
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"tianbai"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}
- (void)call{
    NSLog(@"call");
    // 之后在回调JavaScript的方法Callback把内容传出去
    JSValue *Callback = self.jsContext[@"share"];
    //传值给web端
    [Callback callWithArguments:@[@"唤起本地OC回调完成"]];
}
- (void)getCall:(NSString *)callString{
    NSLog(@"Get:%@", callString);
    NSArray *array = [callString componentsSeparatedByString:@","];
    NSString * str = array[0];
    NSArray * arr = [str componentsSeparatedByString:@":"];
    NSString * str1 = arr[1];
    
    
    
   str1 = [str1 substringFromIndex:1];
   str1 =  [str1 substringToIndex:str1.length-1];
   
    
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *contentArray = @[@"微信支付", @"支付宝"];
    
    for (NSInteger i = 0; i < contentArray.count; i++)
    {
        BAActionSheetModel *model = [BAActionSheetModel new];
        //        model.imageUrl = imageArray[i];
        model.content = contentArray[i];
        //        model.subContent = subContentArray[i];
        
        [dataArray addObject:model];
    }
    BAKit_WeakSelf
    [BAActionSheet ba_actionSheetShowWithConfiguration:^(BAActionSheet *tempView) {
        
        BAKit_StrongSelf
        //        tempView.title = @"支付方式";
        tempView.dataArray = dataArray;
        tempView.actionSheetType = BAActionSheetTypeCustom;
        //        tempView.isTouchEdgeHide = NO;
        
        self.actionSheet = tempView;
    } actionBlock:^(NSIndexPath *indexPath, BAActionSheetModel *model) {
        
        NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
                 paramDic[@"or_id"] = str1 ;
        if(indexPath.item==0){
            
            [MBBPayManager payUseWeixinWithOrderInfo:paramDic callBack:^(NSString *result) {
                
            }];
        }else {
            [MBBPayManager payUseAlipayWithOrderInfo:paramDic callBack:^(NSString *result) {
                if ([result isEqualToString:@"sccess"]) {
                    [self paySuccessOperation];
                }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
            }];
        }
    }];
}
- (void)payResult:(NSNotification *)notifa{
    
    if([notifa.object isEqualToString:@"1"]){
        /** 支付成功(返回)*/
        [self paySuccessOperation];
        
    }else{
        /** 支付失败(停留此页面)*/
    }
      
}
#pragma mark - 指定支付成功返回不同界面
- (void)paySuccessOperation{
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    NSLog(@"%@",[NSString stringWithFormat:@"http://api.worldbuddy.cn/home/Insurance/defaults?token=%@",model.token]);
    
    [_webViewDoc loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.worldbuddy.cn/home/Insurance/defaults?token=%@",model.token]]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
