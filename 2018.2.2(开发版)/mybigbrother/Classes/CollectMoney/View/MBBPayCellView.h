//
//  MBBPayCellView.h
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBBPayCellView : UIView
/**
* 支付方式选中的按钮
*/
@property (nonatomic, strong) UIButton * chooseBtn;
    
/**
* 创建支付方式视图
* image : 支付方式图片
* name  : 支付方式名称
*/
- (instancetype)initWithFrame:(CGRect)frame methodImage:(NSString *)image methodName:(NSString*)name;

@end
