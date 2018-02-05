//
//  TakePlaneInfoView.h
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 注意顺序*/
typedef NS_ENUM (NSInteger, KCellTapType){
    KCellTapPlane = 100,//机场
    KCellTapSchool,     //学校
    KCellTapCount,      //人数
    KCellTapSetoutTime, //出发时间
    KCellTapArriveTime, //到达时间
    KCellTapFlight,     //航班号
    KCellTapChooseCar   //选择车型
};
@protocol TakePlaneInfoViewDelegate <NSObject>
/** 选中*/
- (void)TakePlaneInfoViewChooseInfo:(KCellTapType)type;

@end

@interface TakePlaneInfoView : UIView
@property (nonatomic, weak) id<TakePlaneInfoViewDelegate>delegate;
@property (nonatomic, strong) NSMutableArray * cells;
@end
