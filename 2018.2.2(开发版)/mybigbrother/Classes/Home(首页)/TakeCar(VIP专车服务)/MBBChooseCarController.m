//
//  MBBChooseCarController.m
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBChooseCarController.h"
#import "SDCycleScrollView.h"

#import "ChooseCarMiddleView.h"
#import "ChooseCarBottomView.h"
#import "CustomServiceDetailBottomView.h"
#import "MBBCollectMoneyController.h"
#import "ChooseCarTopView.h"
#import "CarModel.h"

@interface MBBChooseCarController ()<CustomServiceDetailBottomViewDelegate>

@property (nonatomic, strong) ChooseCarTopView * cycleViews;
@property (nonatomic, strong) ChooseCarMiddleView * middleView;
@property (nonatomic, strong) ChooseCarBottomView * bottomView;
@property (nonatomic, strong) CustomServiceDetailBottomView * payView;

@property (nonatomic, strong) NSArray * carModels ;
@property (nonatomic, strong) CarModel * currentModel;
@end

@implementation MBBChooseCarController

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
//    self.navigationController.navigationBar.hidden = NO;
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBar.hidden = YES;
//    self.tabBarController.tabBar.hidden = NO;
//
//    [super viewWillDisappear:animated];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择车型";
    // Do any additional setup after loading the view.
    
    ChooseCarTopView * cycleViews = [[ChooseCarTopView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 150)];
//    cycleViews.backgroundColor = [UIColor yellowColor];
    if (kDevice_Is_iPhoneX) {
        
    }
    /** 改变展示信息*/
    cycleViews.presentPageBlock = ^(NSInteger page){
        /** 实时获取页码*/
        ZXLog(@"%ld",(long)page);
        CarModel * model = _carModels[page];
        _currentModel = model;
        _middleView.packageCountLabel.text = [NSString stringWithFormat:@"%ld件",(long)model.car_lugaae];
        _middleView.packageLabel.text      = [NSString stringWithFormat:@"可携带行李数(%ld寸)",(long)model.lugaae_size];
        _middleView.personCountLabel.text  = [NSString stringWithFormat:@"%ld人/%ld人",(long)self.personNumber,(long)model.car_number];

        /** 待处理*/
        _bottomView.price.text = [NSString stringWithFormat:@"$%0.2f",model.car_price * self.chaterCarDays];
        _bottomView.titleLabel.text= [NSString stringWithFormat:@"%ld天包车",(long)self.chaterCarDays];
        _bottomView.averagePrice.text = [NSString stringWithFormat:@"$%0.2f",(model.car_price * self.chaterCarDays)/self.personNumber];
    };
    
    [self.view addSubview:cycleViews];
    
    /** 展示信息*/
    ChooseCarMiddleView * middleView =[[ChooseCarMiddleView alloc]init];
    middleView.frame = CGRectMake(0,CGRectGetMaxY(cycleViews.frame)+ 10, SCREEN_WIDTH, 110) ;
    [self.view addSubview:middleView];
    
    /** 费用*/
    ChooseCarBottomView * bottomView =[[ChooseCarBottomView alloc]init];
    bottomView.frame = CGRectMake(0,CGRectGetMaxY(middleView.frame)+ 10, SCREEN_WIDTH, 88) ;
    [self.view addSubview:bottomView];
    
    /** 支付*/
    CustomServiceDetailBottomView * payView;
    if (kDevice_Is_iPhoneX) {
        payView = [[CustomServiceDetailBottomView alloc]initWithFrame:CGRectMake(0,
                                                                                 SCREEN_HEIGHT - 44,
                                                                                 SCREEN_WIDTH,
                                                                                 44)
                   
                                                           rightTitle:@"去付款"];
    }else{
        payView = [[CustomServiceDetailBottomView alloc]initWithFrame:CGRectMake(0,
                                                                                 SCREEN_HEIGHT- 44,
                                                                                 SCREEN_WIDTH,
                                                                                 44)
                   
                                                           rightTitle:@"去付款"];
    }
    payView.delegate = self;
    [self.view addSubview:payView];
    
    _cycleViews = cycleViews;
    _middleView = middleView;
    _bottomView = bottomView;
    _payView= payView;
    
    [self fetchDataSourceFromServer];

}
-(BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}

- (void)fetchDataSourceFromServer{
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"cartypecartype";
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager carServiceGetCarType:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            NSArray * carModels = [CarModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            _carModels = carModels;
            
            _cycleViews.carModels = carModels;
            
            CarModel * model = _carModels[0];
            _currentModel = model;
            _middleView.packageCountLabel.text = [NSString stringWithFormat:@"%ld件",(long)model.car_lugaae];
            _middleView.packageLabel.text      = [NSString stringWithFormat:@"可携带行李数(%ld寸)",(long)model.lugaae_size];
            _middleView.personCountLabel.text  = [NSString stringWithFormat:@"%ld人/%ld人",(long)self.personNumber,(long)model.car_number];
            /** 待处理*/
            _bottomView.price.text = [NSString stringWithFormat:@"$%0.2f",model.car_price * self.chaterCarDays];
            _bottomView.titleLabel.text= [NSString stringWithFormat:@"%ld天包车",(long)self.chaterCarDays];
            _bottomView.averagePrice.text = [NSString stringWithFormat:@"$%0.2f",(model.car_price * self.chaterCarDays)/self.personNumber];
                        /** 支付*/
            _payView.servicePrice = [NSString stringWithFormat:@"总价:$ %0.2f ",model.car_price * self.chaterCarDays];
        }else{

        
        
        }
        
        
    }];

    
}
- (void)setPersonNumber:(NSInteger)personNumber{
    _personNumber = personNumber;
}
- (void)setChaterCarDays:(NSInteger)chaterCarDays{
    _chaterCarDays = chaterCarDays;
}
#pragma mark - delegate
/** 去付款*/
- (void)rihgtButtonClicked{
    
     MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"carcar";
    paramDic[@"token"] = model.token;
    
    paramDic[@"ch_city"] = _infoDic[@"ch_city"];
    paramDic[@"start_time"] = _infoDic[@"start_time"];
    paramDic[@"ch_arrive"] = _infoDic[@"ch_arrive"];
    paramDic[@"ch_number"] = _infoDic[@"ch_number"];
    paramDic[@"ch_startime"] = _infoDic[@"ch_startime"];
    paramDic[@"ch_endtime"] = _infoDic[@"ch_endtime"];

    paramDic[@"m_id"] = _currentModel.car_type;
    paramDic[@"type_id"] =@(_currentModel.car_id);
    paramDic[@"or_price"] = @(_currentModel.car_price * self.chaterCarDays);
    
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager chaterCarOrder:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功(暂未返回订单信息)*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            MBBCollectMoneyController * collectMoney = [[MBBCollectMoneyController alloc]init];
            /** 优惠券筛选条件*/
            collectMoney.serviceId = @"2";
            collectMoney.carId = [NSString stringWithFormat:@"%ld",(long)_currentModel.car_id];
           
            collectMoney.orderId = request.responseJSONObject[@"data"][@"or_id"];
            
            collectMoney.orderPrice = [NSString stringWithFormat:@"%0.2f",_currentModel.car_price * self.chaterCarDays];
            [self.navigationController pushViewController:collectMoney animated:YES];
            
        }else{
            
        
        }
    }];

    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
