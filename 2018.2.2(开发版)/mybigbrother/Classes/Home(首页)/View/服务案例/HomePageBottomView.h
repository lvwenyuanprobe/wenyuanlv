//
//  HomePageBottomView.h
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ServiceCaseModel;
@class TacticsShareModel;
@protocol HomePageBottomViewDelegate <NSObject>

/** 查看案例详情*/
- (void)gotoServiceExmpleDetail:(ServiceCaseModel*)model;
- (void)gotoShareVCDetail:(TacticsShareModel *)model;

@end

@interface HomePageBottomView : UIView
@property (nonatomic, weak) id<HomePageBottomViewDelegate>delegate;
@end
