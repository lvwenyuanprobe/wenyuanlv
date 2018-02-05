//
//  HomePageTopView.h
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KHomePageButtonType) {

    KHomeTopCustomMade = 0,/** 定制服务*/
    KHomeTopPlane,         /** 接送机*/
    KHomeTopCar,           /** 包车*/
};

@protocol HomePageTopViewDelegate <NSObject>
/** 点击事件*/
- (void)homepageTopViewButtonClicked:(KHomePageButtonType)type;

@end

@interface HomePageTopView : UIView
@property (nonatomic, strong) SDCycleScrollView *   banner;

@property(nonatomic, weak)id<HomePageTopViewDelegate>delegate;

@property (nonatomic, strong) UINavigationController * KNavgationController;
@end
