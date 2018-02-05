//
//  CustomServiceDetailBottomView.h
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomServiceDetailBottomViewDelegate <NSObject>
/** 购买 or 付款*/
- (void)rihgtButtonClicked;

@end

@interface CustomServiceDetailBottomView : UIView

@property (nonatomic, weak)id<CustomServiceDetailBottomViewDelegate>delegate;

/** 商品金额: (格式中必须有冒号:字符)*/
@property (nonatomic, strong) NSString * servicePrice;

/** 初始化方法*/
- (instancetype)initWithFrame:(CGRect)frame rightTitle:(NSString *)rightStr;


@end
