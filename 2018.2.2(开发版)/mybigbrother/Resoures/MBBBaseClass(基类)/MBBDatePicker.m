//
//  MBBDatePicker.m
//  mybigbrother
//
//  Created by SN on 2017/4/12.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBDatePicker.h"
@interface MBBDatePicker ()

@property (nonatomic, strong) UIView *   bgView;
@property (nonatomic, strong) UIView *   dateView;
@property (nonatomic, strong) UIButton *  buttonBack;
@property (nonatomic, strong) UIButton *  buttonSure;

@property (nonatomic, strong,readwrite) NSString *  selectDateString;

@end

@implementation MBBDatePicker

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    /** 灰层*/
    UIView *  bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgView.backgroundColor = MBBCOLOR_ALPHA(1, 1, 1, 0.2);
    [self  addSubview:bgView];
    
    /** 动画*/
    [UIView animateWithDuration:0.4
                     animations:^{
                         bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                     }
                     completion:^(BOOL finished){
                     }];

    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelTapClick:)];
    [bgView addGestureRecognizer:tapGR];
    
    _bgView = bgView;
    
    
    UIView * dateView = [[UIView alloc] init];
    dateView.backgroundColor = [UIColor whiteColor];
    dateView.alpha = 1;
    dateView.frame = CGRectMake(0, SCREEN_HEIGHT - 320, SCREEN_WIDTH, 320);
    [self.bgView addSubview:dateView];
    
    _dateView = dateView;
    
    /** 日期选择器*/
    UIDatePicker * datePicker = [[UIDatePicker alloc] init];
    [datePicker setTimeZone:[NSTimeZone defaultTimeZone]];
    [datePicker setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.minuteInterval = 30;
    [dateView addSubview:datePicker];
    
    _datePicker = datePicker;
    
//    datePicker.date = [[NSDate alloc] init];
//    NSDate *selectedDate = [[NSDate alloc] init];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setLocale:[NSLocale currentLocale]];
//    formatter.dateFormat = @"yyyyMMdd";
//    NSString * dateString = [formatter stringFromDate:selectedDate];
    
    
    [datePicker addTarget:self action:@selector(presentSelectDate:) forControlEvents:UIControlEventValueChanged];
    [dateView addSubview:datePicker];
    
    /** 确定按钮*/
    UIButton *buttonSure = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSure.titleLabel.textAlignment = NSTextAlignmentCenter;
    [buttonSure setBackgroundImage:[UIImage imageWithColor:BASE_YELLOW] forState:UIControlStateHighlighted];
    [buttonSure setBackgroundImage:[UIImage imageWithColor:BASE_YELLOW] forState:UIControlStateNormal];
    [buttonSure addTarget:self action:@selector(datePickerSureClick) forControlEvents:UIControlEventTouchUpInside];
    buttonSure.frame = CGRectMake(SCREEN_WIDTH/ 2,
                                  0,
                                  SCREEN_WIDTH/ 2,
                                  50);
    [buttonSure setTitle:@"确定" forState:UIControlStateNormal];
    [buttonSure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.dateView addSubview:buttonSure];
    
    _buttonSure = buttonSure;
    
    /** 取消按钮*/
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBack.titleLabel.textAlignment = NSTextAlignmentCenter;
    [buttonBack setBackgroundImage:[UIImage imageWithColor:BASE_YELLOW] forState:UIControlStateHighlighted];
    [buttonBack setBackgroundImage:[UIImage imageWithColor:BASE_YELLOW] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(datePickerBackClick) forControlEvents:UIControlEventTouchUpInside];
    buttonBack.frame = CGRectMake(0,
                                  0,
                                  SCREEN_WIDTH/ 2,
                                  50);
    [buttonBack setTitle:@"取消" forState:UIControlStateNormal];
    [buttonBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.dateView addSubview:buttonBack];
    
    _buttonBack = buttonBack;
}

/** 消失*/
- (void)cancelTapClick:(UITapGestureRecognizer *)tap{
    
    [self datePickerBackClick];

}
- (NSString *)selectDateString{
    if (!_selectDateString) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale currentLocale]];
        formatter.dateFormat = @"yyyy-MM-dd HH:00";
        NSDate * nowDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        _selectDateString = [formatter stringFromDate:nowDate];
    }
    return _selectDateString;
}
/** 确定*/
- (void)datePickerSureClick{
    [self datePickerBackClick];
    if ([self.delegate respondsToSelector:@selector(datePickerSureClick: view:)]) {
        [self.delegate datePickerSureClick:self.selectDateString view:self];
    }
}
/** 取消*/
- (void)datePickerBackClick{
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         [self.bgView removeFromSuperview];
                     }
                     completion:^(BOOL finished){
                         
                     }];
    [self removeFromSuperview];
}
/** 选中当前*/
- (void)presentSelectDate:(UIDatePicker *)picker{
    
    NSDate *selectedDate = picker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    formatter.dateFormat = @"yyyy-MM-dd HH:00";
    self.selectDateString = [formatter stringFromDate:selectedDate];
    
}
@end
