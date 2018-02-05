//
//  HomepageTacticView.h
//  mybigbrother
//
//  Created by SN on 2017/6/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomepageTacticView : UIView
/** 传入一个导航控制器*/
@property (nonatomic,strong)UINavigationController * kNavigationController;
/** 首页控制器*/
@property (nonatomic,strong)UIViewController * presentController;

@end
