//
//  MBBDatePicker.h
//  mybigbrother
//
//  Created by SN on 2017/4/12.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBBDatePicker;

@protocol MBBDatePickerDelegate <NSObject>
/**  选中的日期*/
- (void)datePickerSureClick:(NSString * )dateStr view:(MBBDatePicker *)picker;

@end

@interface MBBDatePicker : UIView
/** 选中日期*/
@property (nonatomic, strong,readonly) NSString *  selectDateString;
@property (nonatomic, strong) UIDatePicker * datePicker ;
@property (nonatomic, weak) id<MBBDatePickerDelegate>delegate;
@end
