//
//  MBBDifferentCouponsHeader.h
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KOrderStateType) {
    KOrderStateTypeAll = 0,
    KOrderStateTypeNew = 1,
    KOrderStateTypePaid = 2,
};

@protocol  MBBDifferentCouponsHeaderDelegate <NSObject>
/** 展示不同状态订单列表*/
- (void)showDifferentOrderListWithState:(KOrderStateType)sportType;
@end

@interface MBBDifferentCouponsHeader : UIScrollView
   
@property (nonatomic, weak) id<MBBDifferentCouponsHeaderDelegate>showDelegate;
@property (nonatomic, strong) NSMutableArray * buttonArray;
    
/** 传入订单数量的字典*/
@property (nonatomic, strong) NSDictionary * orderCountDic;
    
/** 初始化*/
- (instancetype)initWithFrame:(CGRect)frame;
    
/** 外部调用点击事件*/
- (void)publicButtonClicked:(NSInteger)buttonTag;
@end
