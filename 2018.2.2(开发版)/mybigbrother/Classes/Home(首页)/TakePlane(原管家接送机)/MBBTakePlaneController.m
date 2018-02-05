//
//  MBBTakePlaneController.m
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBTakePlaneController.h"
#import "TakePlaneInfoView.h"
#import "MBBDatePicker.h"
#import "TakePlaneCellView.h"
#import "MBBChooseAirportController.h"
#import "MBBChooseSchoolController.h"
#import "AirportModel.h"
#import "SchoolsModel.h"
#import "TakePlaneInfoCountView.h"
#import "TakePlaneChooseCarController.h"
#import "CarModel.h"

#import "MBBCollectMoneyController.h"
#import "MBBLoginContoller.h"

typedef NS_ENUM (NSInteger, KDatePickerType){
    KDatePickerSetoutTime = 100,
    KDatePickerArriveTime,
};

@interface MBBTakePlaneController ()<TakePlaneInfoViewDelegate,MBBDatePickerDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * mainScrollView ;
@property (nonatomic, strong) TakePlaneInfoView * infoView  ;
@property (nonatomic, strong) NSMutableDictionary * takePlaneDic;
@property (nonatomic, strong) NSString * carPrice;
@end

@implementation MBBTakePlaneController
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
     self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title  = @"管家服务";
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    SCREEN_WIDTH,
                                                                    SCREEN_HEIGHT+ 70)];
    _mainScrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 1.1);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    _mainScrollView.backgroundColor = BASE_VC_COLOR;
//    _mainScrollView.scrollEnabled = NO;
    
    TakePlaneInfoView * infoView = [[TakePlaneInfoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 276 + 44 + 44 + 44)];
    infoView.delegate = self;
    _infoView = infoView;
    [_mainScrollView addSubview:infoView];
    
    
    
    /**  购买*/
    UIButton * buyBtn = [[UIButton alloc] init];
    [buyBtn setTitle:@"我要购买" forState:UIControlStateNormal];
    [buyBtn setBackgroundImage:[UIImage imageWithColor:BUTTON_COLOR] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyClicked) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:buyBtn];
    
    
    buyBtn.sd_layout
    .topSpaceToView(infoView,40)
    .leftSpaceToView(_mainScrollView,40)
    .widthIs(SCREEN_WIDTH - 80)
    .heightIs(44);
    buyBtn.clipsToBounds = YES;
    buyBtn.layer.cornerRadius = 3;
    
    
    self.takePlaneDic = [NSMutableDictionary dictionary];
}
#pragma mark - TakePlaneInfoViewDelegate 

- (void)TakePlaneInfoViewChooseInfo:(KCellTapType)type{
   
    
    /** 机场*/
    if (type == KCellTapPlane) {
        MBBChooseAirportController * airportsVC = [[MBBChooseAirportController alloc]init];
        airportsVC.airportBlock = ^(AirportModel *model) {
            TakePlaneCellView * cell = [_infoView.cells objectAtIndex:0];
            cell.rightLabel.text = model.a_name;
            self.takePlaneDic[@"j_id"] = model.a_id;
        };
        [self.navigationController pushViewController:airportsVC animated:YES];
        
    }
    /** 学校*/
    if (type == KCellTapSchool) {
        MBBChooseSchoolController * schoolsVC = [[MBBChooseSchoolController alloc]init];
        schoolsVC.schoolBlock = ^(SchoolsModel *model) {
            TakePlaneCellView * cell = [_infoView.cells objectAtIndex:1];
            cell.rightLabel.text = model.s_name;
            self.takePlaneDic[@"a_school"] = model.s_name;
        };
        [self.navigationController pushViewController:schoolsVC animated:YES];
    }
    /** 出发时间*/
    if (type == KCellTapSetoutTime){
        /** 到达时间*/
        MBBDatePicker * picker = [[MBBDatePicker alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        picker.delegate = self;
        picker.tag = KDatePickerSetoutTime;
        picker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        picker.datePicker.maximumDate = [NSDate distantFuture];
        picker.datePicker.minimumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        [self.view addSubview:picker];
        
    }
    /** 到达时间*/
    if (type == KCellTapArriveTime){
        /** 到达时间*/
        MBBDatePicker * picker = [[MBBDatePicker alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        picker.delegate = self;
        picker.tag = KDatePickerArriveTime;
        picker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        picker.datePicker.maximumDate = [NSDate distantFuture];
        picker.datePicker.minimumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        [self.view addSubview:picker];

    }
    if (type == KCellTapCount/** 注意*/) {
        return;
        
    }
    
    if (type == KCellTapFlight/** 注意*/) {
        return;
    }
    if (type == KCellTapChooseCar/** 注意*/) {
        
        TakePlaneChooseCarController * chooseCar = [[TakePlaneChooseCarController alloc]init];
        for ( id countView  in _infoView.subviews) {
            if ([countView isKindOfClass:[TakePlaneInfoCountView class]]) {
                TakePlaneInfoCountView * subView =  countView;
                chooseCar.personNumber = [subView.countLabel.text integerValue];
            }
        }
        chooseCar.carPopBlock = ^(CarModel *popModel) {
            TakePlaneCellView * cell = [_infoView.cells objectAtIndex:KCellTapChooseCar-100];
            cell.rightLabel.text = popModel.car_type;
            self.takePlaneDic[@"type_id"] = @(popModel.car_id);
            self.takePlaneDic[@"or_price"] = @(popModel.car_price);
            self.carPrice = [NSString stringWithFormat:@"%0.2f",popModel.car_price];

        };
        [self.navigationController pushViewController:chooseCar animated:YES];
    }

}
#pragma mark - 拖拽弹回
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - MBBDatePickerDelegate
/** 选中到达时间*/
- (void)datePickerSureClick:(NSString *)dateStr view:(MBBDatePicker *)picker{
    
    
    if (KDatePickerSetoutTime == picker.tag) {
        TakePlaneCellView * cell = [_infoView.cells objectAtIndex:3];
        cell.rightLabel.text = dateStr;
        self.takePlaneDic[@"starttime"] = dateStr;
    }
    if (KDatePickerArriveTime == picker.tag) {
        TakePlaneCellView * cell = [_infoView.cells objectAtIndex:4];
        cell.rightLabel.text = dateStr;
        self.takePlaneDic[@"a_time"] = dateStr;
    }
    
}
- (void)buyClicked{
    
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

    for ( id countView  in _infoView.subviews) {
        /** 取值*/
        if ([countView isKindOfClass:[TakePlaneInfoCountView class]]) {
            TakePlaneInfoCountView * subView =  countView;
            self.takePlaneDic[@"a_number"] = @([subView.countLabel.text integerValue]);
        }
        /** 待修改*/
        if ([countView isKindOfClass:[TakePlaneCellView class]]) {
            TakePlaneCellView * subView =  countView;
            if (subView.tag == KCellTapSchool) {//学校
                self.takePlaneDic[@"a_school"] = subView.rightLabel.text;
            }
            if (subView.tag == KCellTapSetoutTime) {//出发时间
                self.takePlaneDic[@"starttime"] = subView.rightLabel.text;
            }
            if (subView.tag == KCellTapArriveTime) {//到达时间
                self.takePlaneDic[@"a_time"] = subView.rightLabel.text;
            }
            if (subView.tag == KCellTapFlight) {//航班号
                self.takePlaneDic[@"a_flight"] = subView.rightLabel.text;
            }
        }

    }
    
    /** 字段检测*/
    if (!self.takePlaneDic[@"j_id"]) {
        [MyControl alertShow:@"请您选择接机机场"];
        return;
    }
    if (!self.takePlaneDic[@"a_school"]) {
        [MyControl alertShow:@"请您选择目的地学校"];
        return;
    }
    if (!self.takePlaneDic[@"a_number"]) {
        [MyControl alertShow:@"请您选择人数"];
        return;
    }
    if (!self.takePlaneDic[@"starttime"]) {
        [MyControl alertShow:@"请您选择出发时间"];
        return;
    }
    if (!self.takePlaneDic[@"a_time"]) {
        [MyControl alertShow:@"请您选择到达时间"];
        return;
    }
    if (!self.takePlaneDic[@"a_flight"]) {
        [MyControl alertShow:@"请您填写航班号"];
        return;
    }
    if (!self.takePlaneDic[@"type_id"]) {
        [MyControl alertShow:@"请您选择车型"];
        return;
    }


    /** 跳转登陆*/
    [MyControl CheckOutPresentVCLogin:self isLoginToPush:nil];

    /** 停止执行*/
    if(![MyControl MBBisLogionSuccess]){
        return;
    }
    /** 跳转支付*/
    self.takePlaneDic[@"sign"] = @"aircraftaircraft";
    self.takePlaneDic[@"token"] = model.token;

    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userGetTakePlane:self.takePlaneDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功(暂时没有返回订单信息)*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {

            MBBCollectMoneyController * commitVC = [[MBBCollectMoneyController alloc]init];
            /** 优惠券查询条件*/
            commitVC.airportId = self.takePlaneDic[@"j_id"];
            commitVC.carId = self.takePlaneDic[@"type_id"];
            /** 服务id(1.定制服务 2.包车服务 3.接机服务)*/
            commitVC.serviceId = @"3";
            /** 订单id*/
            commitVC.orderId = request.responseJSONObject[@"data"][@"or_id"];
            
            /** */
            commitVC.orderPrice = self.carPrice;
            [self.navigationController pushViewController:commitVC animated:YES];
            
        }else{
            
            [MBProgressHUD showError:@"请求失败" toView:self.view];
        }
        
    }];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
