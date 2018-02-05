//
//  DriverDistanceCell.h
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DriverOrderModel.h"

typedef NS_ENUM (NSInteger, KDriverOperationType){
    KDriverOperationAccept = 1,/** 接单*/
    KDriverOperationRefuse,    /** 拒绝*/
    KDriverOperationSetout,    /** 出发*/
    KDriverOperationReceive,    /** 接到*/
    KDriverOperationDelived    /** 送达*/
};

@protocol DriverDistanceCellDelegate <NSObject>
/** 联系顾客*/
- (void)makeCallToCustomerTap:(DriverOrderModel *)orderModel;

/** 司机操作*/
- (void)driverOperationOrder:(KDriverOperationType )operation orderModel:(DriverOrderModel *)OrderModel;
@end

@interface DriverDistanceCell : UITableViewCell
/** 订单模型*/
@property (nonatomic, strong)  DriverOrderModel * model;

@property (nonatomic, strong) id<DriverDistanceCellDelegate>distanceCellDelegate;


@end
