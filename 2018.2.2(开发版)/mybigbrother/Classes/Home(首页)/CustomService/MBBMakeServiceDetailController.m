//
//  MBBMakeServiceDetailController.m
//  mybigbrother
//
//  Created by SN on 2017/4/17.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBMakeServiceDetailController.h"

#import "CustomServiceDetailBottomView.h"
#import "MBBCommitOrderController.h"
#import "MBBLoginContoller.h"

@interface MBBMakeServiceDetailController ()<CustomServiceDetailBottomViewDelegate>
@property (nonatomic, strong) UIWebView * webview;
@property (nonatomic, strong) CustomServiceDetailBottomView * bottomView;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * ma_id;

/** 二层传递*/
@property (nonatomic, strong) CustomServiceCellModel * model;

@end

@implementation MBBMakeServiceDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"定制服务详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.navTitle;
    /** webView*/
    UIWebView * webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    webview.scrollView.bounces = NO;
    webview.scrollView.showsVerticalScrollIndicator = NO;
    webview.scrollView.showsHorizontalScrollIndicator = NO;
    webview.backgroundColor = [UIColor whiteColor];
    
    _webview = webview;
    [self.view addSubview:webview];
    
    CustomServiceDetailBottomView * bottomView;
    if (kDevice_Is_iPhoneX) {
        bottomView = [[CustomServiceDetailBottomView alloc]initWithFrame:CGRectMake(0,
                                                                                                                    SCREEN_HEIGHT- 64 - 44 - 20,
                                                                                                                    SCREEN_WIDTH,
                                                                                                                    44)
                                                      
                                                                                              rightTitle:@"我要购买"];
    }else{
        bottomView = [[CustomServiceDetailBottomView alloc]initWithFrame:CGRectMake(0,
                                                                                                                    SCREEN_HEIGHT- 64 - 44 ,
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
- (void)fetchDataFromServer{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"ma_id"] = self.serviceId;
    paramDic[@"sign"] = @"mademadeInfo";
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager getCustomServiceDetail:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue] ==200) {
            NSString * str = request.responseJSONObject[@"data"][@"ma_content"];
            [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            
            
            self.price = request.responseObject[@"data"][@"ma_price"];
            self.ma_id = request.responseObject[@"data"][@"ma_id"];
            _bottomView.servicePrice = [NSString stringWithFormat:@"总价:$ %@",self.price];
            CustomServiceCellModel * model = [CustomServiceCellModel mj_objectWithKeyValues:request.responseJSONObject[@"data"]];
            self.model = model;
            
            
        }else{
            
            
        }
        
    }];
    
}


#pragma mark - CustomServiceDetailBottomViewDelegate
- (void)rihgtButtonClicked{
    
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

    MBBCommitOrderController * commitOrderVC = [[MBBCommitOrderController alloc]init];
    commitOrderVC.ma_id = self.ma_id;
    commitOrderVC.price = self.price;
    commitOrderVC.model = self.model;
    [self.navigationController pushViewController:commitOrderVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
