//
//  ChooseCarBottomView.h
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCarBottomView : UIView
/** 多少天包车费*/
@property (nonatomic, strong) UILabel * titleLabel ;
/** 价格*/
@property (nonatomic, strong) UILabel * price ;

/** 人均价格*/
@property (nonatomic, strong) UILabel * averagePrice ;


@end
