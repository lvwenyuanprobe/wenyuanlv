//
//  MMAlternativeItem.h
//  MMComboBoxDemo
//
//  WY
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMAlternativeItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;

+ (instancetype)itemWithTitle:(NSString *)title isSelected:(BOOL)isSelected;
@end
