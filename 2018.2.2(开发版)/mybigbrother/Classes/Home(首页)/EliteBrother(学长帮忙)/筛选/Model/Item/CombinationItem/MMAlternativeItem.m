//
//  MMAlternativeItem.m
//  MMComboBoxDemo
//
//  WY
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MMAlternativeItem.h"

@implementation MMAlternativeItem
+ (instancetype)itemWithTitle:(NSString *)title isSelected:(BOOL)isSelected {
    MMAlternativeItem *item = [[[self class] alloc] init];
    item.title = title;
    item.isSelected = isSelected;
    return item;
}
@end
