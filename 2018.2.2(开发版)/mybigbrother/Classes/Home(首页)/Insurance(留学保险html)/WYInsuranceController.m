//
//  WYInsuranceController.m
//  mybigbrother
//
//  Created by Loren on 2018/1/4.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYInsuranceController.h"

@interface WYInsuranceController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation WYInsuranceController

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
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"留学保险";
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    
    [self setupUI];
}

- (void)setupUI{
    
    
    if (kDevice_Is_iPhoneX) {
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44)];
    }else{
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    }
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.worldbuddy.cn/index.php/Home/Insurance/index"]];
    [self.view addSubview: self.webView];
    // http://api.worldbuddy.cn/index.php/Home/Insurance/index
    _webView.scrollView.bounces = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    [self.webView loadRequest:request];
}

-(BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
