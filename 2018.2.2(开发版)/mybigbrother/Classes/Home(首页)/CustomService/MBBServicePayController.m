//
//  MBBServicePayController.m
//  mybigbrother
//
//  Created by mac on 2017/11/6.
//  Copyright © 2017年 飞凡创客联盟. All rights reserved.
//

#import "MBBServicePayController.h"
#import "CustomServiceDetailBottomView.h"
#import "MBBChoosePayMethodView.h"
#import "MBBUseCouponsController.h"


#import "MBBPayManager.h"


#import "MBBHomeViewController.h"
#import "MBBServiceViewController.h"
#import "MyOrderController.h"
#import "MBBAboutUsController.h"
@interface MBBServicePayController ()<CustomServiceDetailBottomViewDelegate,MBBChoosePayMethodViewDelegate>

@end

@implementation MBBServicePayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收银台";
    self.view.backgroundColor = [UIColor whiteColor];
    
    MBBChoosePayMethodView * payChooseView = [[MBBChoosePayMethodView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 132)];
    payChooseView.delegate = self;
    [self.view addSubview:payChooseView];
    
    
    UILabel * explain = [[UILabel alloc]init];
    explain.text = @"    点击去付款表示你已阅读并同意留学大师兄重要条款>>";
    explain.textColor = FONT_LIGHT;
    explain.font = MBBFONT(10);
    UITapGestureRecognizer * explianDetailTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoPayExplainDetail)];
    explain.userInteractionEnabled = YES;
    [explain addGestureRecognizer:explianDetailTap];
    [self.view addSubview:explain];
    explain.sd_layout.topSpaceToView(payChooseView, 0)
    .leftSpaceToView(self.view, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(40);
    
    
    _payChooseView = payChooseView;
    
    
    CustomServiceDetailBottomView * bottomView = [[CustomServiceDetailBottomView alloc]initWithFrame:CGRectMake(0,
                                                                                                                SCREEN_HEIGHT - 64 - 45,
                                                                                                                SCREEN_WIDTH,
                                                                                                                44)
                                                                                          rightTitle:@"去付款"];
    bottomView.delegate = self;
    bottomView.servicePrice = [NSString stringWithFormat:@"总价: $ %@",self.orderPrice];
    _bottomView = bottomView;
    [self.view addSubview:bottomView];
    /** 设定默认支付方式*/
    _payType = KPayUseAlipay;
    
    /** 设定通知*/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payResult:) name:WECHATPAY_NOTIFA object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payResult:) name:ALIPAY_NOTIFA object:nil];
}
- (void)gotoPayExplainDetail{
    MBBAboutUsController * explainDetail = [[MBBAboutUsController alloc]init];
    explainDetail.loadType = @"4";
    [self.navigationController pushViewController:explainDetail animated:YES];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - delegate
/** 确定付款方式*/
- (void)makeSurePayMethod:(KPayMethodType)type{
    
    _payType = type;
    
}
/** 去付款*/
- (void)rihgtButtonClicked{
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    if (!self.orderId) {
        [MyControl alertShow:@"请返回下单"];
        return;
    }
    paramDic[@"or_id"] =  self.orderId;
    paramDic[@"co_id"] =  self.co_id;
    
    
    
    if (_payType == KPayUseAlipay) {
        
        [MBBPayManager payUseAlipayWithOrderInfo:paramDic callBack:^(NSString *result) {
            if ([result isEqualToString:@"sccess"]) {
                [self paySuccessOperation];
            }
            
        }];
    }
    
    if (_payType == KPayUseWeixin) {
        
        [MBBPayManager payUseWeixinWithOrderInfo:paramDic callBack:^(NSString *result) {
            
        }];
    }
    
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
    
    __weak MBBCollectMoneyController * detailVC=self;
    
    for (UIViewController *controller in detailVC.navigationController.viewControllers) {
        /** 接机 包车 定制服务 (返回首页)*/
        if ([controller isKindOfClass:[MBBHomeViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
        /** 服务 (返回服务一级)*/
        if ([controller isKindOfClass:[MBBServiceViewController class]]){
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
        /** 订单列表 (返回订单列表)*/
        if ([controller isKindOfClass:[MyOrderController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
#pragma mark - 优惠券
- (void)tapCouponView{
    MBBUseCouponsController * couponVC = [[MBBUseCouponsController alloc]init];
    couponVC.serviceId = self.serviceId;
    couponVC.airportId = self.airportId;
    couponVC.carId = self.carId;
    couponVC.couponBackBlock = ^(CouponCellModel *model) {
        _payChooseView.rightDiscount.text = [NSString stringWithFormat:@"%@折优惠",model.co_price];
        self.co_id = model.co_id;
    };
    [self.navigationController pushViewController:couponVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
