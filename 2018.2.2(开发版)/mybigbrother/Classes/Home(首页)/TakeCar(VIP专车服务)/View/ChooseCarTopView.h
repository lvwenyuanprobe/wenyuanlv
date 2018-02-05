//
//  ChooseCarTopView.h
//  mybigbrother
//
//  Created by SN on 2017/4/11.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^pageBlock)(NSInteger page);

@interface ChooseCarTopView : UIView
/** 当前页码*/
@property (nonatomic, assign,readonly) NSInteger page;
/** 实时获取页码*/
@property (nonatomic, copy) pageBlock presentPageBlock;
/** 传入car模型数组*/
@property (nonatomic, strong) NSArray  * carModels ;

@end
