//
//  MBBCustomServiceDetailController.m
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBCustomServiceDetailController.h"
#import "CustomServiceDetailBottomView.h"
#import "MBBCollectMoneyController.h"
#import "MBBLoginContoller.h"

#import "StudentServiceCommitOrderController.h"
#import "ParentsServiceCommitOrderController.h"
#import "SPCommitOrderTopModel.h"


#import "CustomServicePublishDetailView.h"

#import "PublishPartnersTogetherController.h"
#import "BAAlert_OC.h"
#import "MBBPayManager.h"
@interface MBBCustomServiceDetailController ()<CustomServiceDetailBottomViewDelegate,CustomServicePublishDetailViewDelegate>

@property (nonatomic, strong) CustomServiceDetailBottomView *  bottomView;
@property (nonatomic, strong) CustomServicePublishDetailView * SecondBottomView;
@property (nonatomic, strong) NSString * severicePrice;
@property (nonatomic, strong) SPCommitOrderTopModel * model;
@property (nonatomic, strong) BAActionSheet  *actionSheet;
@end


@implementation MBBCustomServiceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /** 设定通知*/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payResult:) name:WECHATPAY_NOTIFA object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payResult:) name:ALIPAY_NOTIFA object:nil];
    /** webView*/
    UIWebView * webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-45)];
    webview.backgroundColor = [UIColor whiteColor];
    webview.scrollView.showsVerticalScrollIndicator = NO;
    webview.scrollView.showsHorizontalScrollIndicator = NO;
    webview.delegate = self;
    _webView= webview;
    [self.view addSubview:webview];
    CustomServicePublishDetailView * SecondBottomView;
    if (kDevice_Is_iPhoneX) {
        SecondBottomView= [[CustomServicePublishDetailView alloc]initWithFrame:CGRectMake(0,
                                                                                           SCREEN_HEIGHT - 64 - 68,
                                                                                           SCREEN_WIDTH,
                                                                                           44)];
    }else{
        
        SecondBottomView= [[CustomServicePublishDetailView alloc]initWithFrame:CGRectMake(0,
                                                                                          SCREEN_HEIGHT - 64 - 45,
                                                                                          SCREEN_WIDTH,
                                                                                          44)];
    }
    
    SecondBottomView.delegate = self;
    SecondBottomView.hidden = YES;
    [self.view addSubview:SecondBottomView];
    _SecondBottomView = SecondBottomView;
    
    CustomServiceDetailBottomView * bottomView;
    if (kDevice_Is_iPhoneX) {
        bottomView = [[CustomServiceDetailBottomView alloc]initWithFrame:CGRectMake(0,
                                                                                    SCREEN_HEIGHT - 64 - 68,
                                                                                    SCREEN_WIDTH,
                                                                                    44)
                                                              rightTitle:@"我要购买"];
    }else{
        bottomView = [[CustomServiceDetailBottomView alloc]initWithFrame:CGRectMake(0,
                                                                                    SCREEN_HEIGHT - 64 - 45,
                                                                                    SCREEN_WIDTH,
                                                                                    44)
                                                              rightTitle:@"我要购买"];
    }
    

    bottomView.delegate = self;
    _bottomView = bottomView;
    [self.view addSubview:bottomView];
    
    [self fetchDataFromServer];
    // Do any additional setup after loading the view.
}

-(BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}

- (void)fetchDataFromServer{
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"f_id"] = self.serviceId;
    paramDic[@"sign"] = @"serveserveinfo";
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager studentAndParentsServicesDetail:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            MBBUserInfoModel * userModel = [MBBToolMethod fetchUserInfo];
            NSLog(@"%@",[NSString stringWithFormat:@"%@?token=%@",request.responseJSONObject[@"data"][@"f_content"],userModel.token]);
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?token=%@",request.responseJSONObject[@"data"][@"f_content"],userModel.token]]]];
            _bottomView.servicePrice = [NSString stringWithFormat:@"总价: $%@",request.responseJSONObject[@"data"][@"f_price"]];
            self.severicePrice = [NSString stringWithFormat:@"%@",request.responseJSONObject[@"data"][@"f_price"]];
            
            SPCommitOrderTopModel * model = [SPCommitOrderTopModel mj_objectWithKeyValues:request.responseJSONObject[@"data"]];
            self.model = model;
            
            if ([request.responseJSONObject[@"data"][@"pay"] isEqualToString:@"PAYABLE"]) {
                _bottomView.hidden = NO;
            }
            if ([request.responseJSONObject[@"data"][@"pay"] isEqualToString:@"NON PAYABLE"]) {
                _bottomView.hidden = YES;
                _webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
            }
            /** D 正常流程 R 去其他操作(约伴同行)*/
            if ([request.responseJSONObject[@"data"][@"mark"] isEqualToString:@"R"]) {
                _bottomView.hidden = YES;
                _SecondBottomView.hidden = NO;
            }
                        
        }else{
            
            
        }
        
    }];

}
#pragma mark - CustomServicePublishDetailViewDelegate

- (void)CustomServicePublishDetailViewClick{
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    if (!model.token) {
        MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
        [self.navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                animated:YES
                                              completion:nil];
        return;
    }
    PublishPartnersTogetherController * publishVC =[[PublishPartnersTogetherController alloc]init];
    [self.navigationController pushViewController:publishVC animated:YES];
}

#pragma mark - CustomServiceDetailBottomViewDelegate
- (void)rihgtButtonClicked{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"serve";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    if (!model.token) {
        MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
        [self.navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                animated:YES
                                              completion:nil];
        return;
    }
    
    if(model.user.type == 3){
        [MBProgressHUD showError:@"您暂时没有此权限..." toView:self.view];
        return;
    }
    /** 跳转提交订单*/
    if([self.serviceType isEqualToString:@"0"] || [self.model.f_type isEqualToString:@"0"]){
        /** 学生*/
        StudentServiceCommitOrderController * studentServiceVC = [[StudentServiceCommitOrderController alloc]init];
        studentServiceVC.hidesBottomBarWhenPushed = YES;
        studentServiceVC.price = self.severicePrice;
        studentServiceVC.ma_id = self.serviceId;
        studentServiceVC.model = self.model;
        [self.navigationController pushViewController:studentServiceVC animated:YES];
        
    }
    if([self.serviceType isEqualToString:@"1"]|| [self.model.f_type isEqualToString:@"1"]){
        /** 家长*/
        ParentsServiceCommitOrderController * parentsServiceVC = [[ParentsServiceCommitOrderController alloc]init];
        parentsServiceVC.hidesBottomBarWhenPushed = YES;
        parentsServiceVC.price = self.severicePrice;
        parentsServiceVC.ma_id = self.serviceId;
        parentsServiceVC.model = self.model;
        [self.navigationController pushViewController:parentsServiceVC animated:YES];
    }
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
   
    if ([request.mainDocumentURL.relativePath isEqualToString:@"/index.php/Home/Insurance/importantnote.html"]) {
     
        
        MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
        if (!model.token) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
            [self.navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                    animated:YES
                                                  completion:nil];
            return  NO;
        }
    }
    
    
    
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
   
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.worldbuddy.cn/home/Insurance/defaults?token=%@",model.token]]]];
    
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
