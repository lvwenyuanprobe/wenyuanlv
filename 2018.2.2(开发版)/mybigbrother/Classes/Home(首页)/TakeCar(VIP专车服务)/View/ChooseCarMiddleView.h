//
//  ChooseCarMiddleView.h
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCarMiddleView : UIView
/** 人数比*/
@property (nonatomic, strong) UILabel * personCountLabel;

/** 可携带行李件数*/
@property (nonatomic, strong) UILabel * packageCountLabel;

/** 可携带行李尺寸*/
@property (nonatomic, strong) UILabel * packageLabel;

@end
