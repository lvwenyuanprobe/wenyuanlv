//
//  MBBTakeCarController.m
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBTakeCarController.h"
#import "TakeCarCellView.h"
#import "TakeCarDateView.h"

#import "MBBChooseCarController.h"
#import "MBBDatePicker.h"
#import "ChoosePersonCountPicker.h"

#import "MXContactsTableController.h"
#import "CityModel.h"

typedef NS_ENUM (NSInteger, KTopActionType){
    KTopActionCome = 100,
    KTopActionArrive,
    KTopActionPersonCount,
    KTopActionStartTime,
};

typedef NS_ENUM (NSInteger, KTimePickerType){
    KTimePickerStartTime= 100,
    KTimePickerBegin,
    KTimePickerEnd,

};
@interface MBBTakeCarController ()<TakeCarCellViewDelegate,
TakeCarDateViewDelegate,
MBBDatePickerDelegate,
AMapLocationManagerDelegate>

@property(nonatomic, strong)UIScrollView * mainScrollView;
/** 行程信息*/
@property (nonatomic, strong) NSMutableDictionary *  tripInfoDic;
@property (nonatomic, strong) NSDate * startDate ;
@property (nonatomic, strong) NSDate * endDate ;

@property (nonatomic, strong) TakeCarDateView * date;
@property (nonatomic, strong) TakeCarCellView * city;
@property (nonatomic, strong) TakeCarCellView * arrive;
@property (nonatomic, strong) TakeCarCellView * count;
@property (nonatomic, strong) TakeCarCellView * time;

/** 高德定位*/
@property (nonatomic, strong) AMapLocationManager * locationManager;
@end

@implementation MBBTakeCarController
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
    self.navigationItem.title = @"包车服务";
    
    
    /** 耗时操作*/
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        /** 单次定位操作*/
        self.locationManager = [[AMapLocationManager alloc]init];
        self.locationManager.delegate = self;
        /** 海外地区没有地址描述返回,地址描述只在中国国内返回*/
        self.locationManager.locatingWithReGeocode = YES;
        /** 定位精度*/
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        /** 定位超时*/
        self.locationManager.locationTimeout = 2;
        /** 逆地理定位超时*/
        self.locationManager.reGeocodeTimeout = 2;
        /** 带逆地理信息(返回坐标和地址) NO不返回地址信息*/
        
        [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            if(error){
                if (error.code == AMapLocationErrorLocateFailed) {
                    return ;
                }
            }
            if (regeocode) {
                NSLog(@"%@",regeocode);
                if (regeocode.city) {
                    _city.leftLabel.text  = regeocode.city;
                    [self.tripInfoDic setObject:regeocode.city forKey:@"ch_city"];  
                }
            }
        }];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
       
        });
    });

    self.tripInfoDic = [NSMutableDictionary dictionary];
    
    /** 主滚动视图*/
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    SCREEN_WIDTH,
                                                                    SCREEN_HEIGHT)];
    _mainScrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 1.0);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    _mainScrollView.backgroundColor = BASE_VC_COLOR;
//    _mainScrollView.scrollEnabled = NO;
    
    
    TakeCarCellView * city =[[TakeCarCellView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 57)];
    city.delegate = self;
    city.titleLabel.text = @"出发地";
    city.leftLabel.text = @"请选择包车出发城市";
    city.tag = KTopActionCome;
    _city = city;
    [_mainScrollView addSubview:city];
   
    
    TakeCarCellView * arrive =[[TakeCarCellView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(city.frame)+0.5, SCREEN_WIDTH, 57)];
    arrive.titleLabel.text = @"目的地";
    arrive.leftLabel.text = @"请选择包车到达城市";
    arrive.delegate = self;
    arrive.tag = KTopActionArrive;
    _arrive = arrive;
    [_mainScrollView addSubview:arrive];
    
    TakeCarCellView * count =[[TakeCarCellView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(arrive.frame)+0.5, SCREEN_WIDTH, 57)];
    count.leftLabel.text = @"请选择出发人数";
    count.titleLabel.text = @"出发人数";
    count.delegate = self;
    count.tag = KTopActionPersonCount;
    _count = count;
    [_mainScrollView addSubview:count];
    
    TakeCarCellView * time =[[TakeCarCellView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(count.frame)+0.5, SCREEN_WIDTH, 57)];
    time.titleLabel.text = @"出发时间";
    time.leftLabel.text = @"建议提前2小时出发";
    time.delegate = self;
    _time = time;
    time.tag = KTopActionStartTime;
    [_mainScrollView addSubview:time];
    

    
    TakeCarDateView * date =[[TakeCarDateView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(time.frame)+10, SCREEN_WIDTH, 114)];
    date.delegate = self;
    _date = date;
    [_mainScrollView addSubview:date];
    
    
    /**  确认行程*/
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setTitle:@"确认行程" forState:UIControlStateNormal];
    buyBtn.backgroundColor = [UIColor colorWithHexString:@"#fb6030"];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [buyBtn setTitleColor:[UIColor colorWithHexString:@"#fdfafa"] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(makeSureTripClicked) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:buyBtn];
    
    if (kDevice_Is_iPhoneX) {
        buyBtn.sd_layout
        .bottomSpaceToView(_mainScrollView, 84)
        .leftSpaceToView(_mainScrollView,0)
        .widthIs(SCREEN_WIDTH)
        .heightIs(50);
    }else{
        buyBtn.sd_layout
        .bottomSpaceToView(_mainScrollView, 64)
        .leftSpaceToView(_mainScrollView,0)
        .widthIs(SCREEN_WIDTH)
        .heightIs(50);
    }
    
}
-(BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}
#pragma mark - delegate
- (void)takeCarChooseTap:(NSInteger )tag{
    if (tag == KTopActionCome) {
        /** 选择城市*/
        MXContactsTableController * city = [[MXContactsTableController alloc]init];
        city.cityBlock = ^(CityModel * model) {
            [self.tripInfoDic setObject:model.c_name forKey:@"ch_city"];
            _city.leftLabel.text = model.c_name;

        };
        [self.navigationController pushViewController:city animated:YES];
        
    }
    if (tag == KTopActionArrive) {
        /** 选择目的地*/
        MXContactsTableController * city = [[MXContactsTableController alloc]init];
        city.cityBlock = ^(CityModel * model) {
            [self.tripInfoDic setObject:model.c_name forKey:@"ch_arrive"];
            _arrive.leftLabel.text = model.c_name;
        };
        [self.navigationController pushViewController:city animated:YES];

    }
    if (tag == KTopActionPersonCount) {
        /** 选择人数*/
        
        //初始化选择器
      ChoosePersonCountPicker*  pkv = [[ChoosePersonCountPicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) withData:nil withCancel:^{
            
        } withConfirm:^(NSInteger adult,NSInteger child) {
        
            if (adult == 0) {
                return ;
            }
            [self.tripInfoDic setObject:@(adult + child) forKey:@"ch_number"];
            
            _count.leftLabel.text = [NSString stringWithFormat:@"%ld人",(long)(adult + child)];

        }];
      
        [self.view addSubview:pkv];

    }
    if (tag == KTopActionStartTime) {
        /** 选择出发时间*/
        MBBDatePicker * picker = [[MBBDatePicker alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        picker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        picker.datePicker.minimumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        picker.datePicker.maximumDate = [NSDate distantFuture];
        picker.delegate = self;
        picker.tag = KTimePickerStartTime;
        [self.view addSubview:picker];
        
    }

}
/** 选择开始结束日期*/
- (void)takeCarTimeChoose:(KTakeCarTimeType)type{
    
    MBBDatePicker * picker = [[MBBDatePicker alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    picker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    picker.datePicker.minimumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    picker.datePicker.maximumDate = [NSDate distantFuture];
    picker.delegate = self;
    if (type == KTakeCarTimeBegin) {
        picker.tag = KTimePickerBegin;
    }
    if (type == KTakeCarTimeEnd) {
        picker.tag = KTimePickerEnd;
    }
    [self.view addSubview:picker];
}
/** 选中日期*/
- (void)datePickerSureClick:(NSString * )dateStr view:(MBBDatePicker *)picker{
    if (picker.tag == KTimePickerStartTime) {
        _endDate = picker.datePicker.date;
        [self.tripInfoDic setObject:dateStr forKey:@"start_time"];
        _time.leftLabel.text = dateStr;
    }
    
    if (picker.tag == KTimePickerBegin) {
        _date.beginLabel.text = dateStr;
        
        _startDate = picker.datePicker.date;
        [self.tripInfoDic setObject:dateStr forKey:@"ch_startime"];
        


    }
    if (picker.tag == KTimePickerEnd) {
        _date.endLabel.text = dateStr;
        
        _endDate = picker.datePicker.date;
        [self.tripInfoDic setObject:dateStr forKey:@"ch_endtime"];
    }

}
/** 确认行程*/
- (void)makeSureTripClicked{
    
    if (!self.tripInfoDic[@"ch_city"]) {
        [MyControl alertShow:@"请选择出发地城市"];
        return;

    }
    if (!self.tripInfoDic[@"ch_arrive"]) {
        [MyControl alertShow:@"目的地城市"];
        return;
    }
    if (!self.tripInfoDic[@"ch_number"]) {
        [MyControl alertShow:@"请选择乘车人数"];
        return;
    }
    /** 可选的*/
//    if (!self.tripInfoDic[@"start_time"]) {
//        [MyControl alertShow:@"请选择出发时间"];
//        return;
//    }
    NSInteger days =  [MyControl getDaysFrom:_startDate To:_endDate];
    if (days == - 1) {
        [MyControl alertShow:@"请选择开始或结束日期!"];
        return;
    }
    /** 小于一天*/
    if (days == 0) {
        days = 1;
    }
    
    /** 跳转登陆*/
    [MyControl CheckOutPresentVCLogin:self isLoginToPush:nil];
    
    /** 停止执行*/
    if(![MyControl MBBisLogionSuccess]){
        return;
    }
    
    /** 跳转*/
    MBBChooseCarController * chooseCar = [[MBBChooseCarController alloc]init];
    chooseCar.personNumber = [self.tripInfoDic[@"ch_number"] integerValue];
    chooseCar.chaterCarDays = days;
    chooseCar.infoDic = self.tripInfoDic;
    [self.navigationController pushViewController:chooseCar animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
