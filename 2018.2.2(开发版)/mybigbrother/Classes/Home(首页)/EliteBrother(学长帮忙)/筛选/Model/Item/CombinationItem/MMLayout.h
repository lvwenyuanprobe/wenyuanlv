//
//  MMLayout.h
//  MMComboBoxDemo
//
//  Created by wyy on 2016/12/15.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MMCombinationItem;
#import "MMComboBoxHeader.h"

@interface MMLayout : NSObject
@property (nonatomic, assign) CGFloat headerViewHeight;
@property (nonatomic, assign) CGFloat alternativeTitleHeight;
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) CGFloat totalHeight;

@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, strong) NSMutableArray *cellLayoutTotalHeight;
@property (nonatomic, strong) NSMutableArray *cellLayoutTotalInfo;

+ (instancetype)layoutWithItem:(MMCombinationItem *)item;
@end
