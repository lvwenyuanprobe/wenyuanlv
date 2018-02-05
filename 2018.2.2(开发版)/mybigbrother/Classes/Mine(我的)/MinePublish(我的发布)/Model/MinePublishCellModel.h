//
//  MinePublishCellModel.h
//  mybigbrother
//
//  Created by SN on 2017/4/17.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MinePublishCellModel : NSObject
/** 昵称*/
@property (nonatomic, strong) NSString * nickname;
/** 航班号*/
@property (nonatomic, assign) NSInteger  r_flight;
/** id*/
@property (nonatomic, assign) NSInteger  r_id;
/** 发布时间*/
@property (nonatomic, strong) NSString * r_time;

/** 出发时间*/
@property (nonatomic, strong) NSString * r_starttime;

/** 头像*/
@property (nonatomic, strong) NSString * u_img;

/** 价格*/
@property (nonatomic, strong) NSString * r_price;

/** 状态1 已匹配*/
@property (nonatomic, strong) NSString * r_status;

/** 订单编号()*/
@property (nonatomic, strong) NSString * r_order;

@end
