//
//  DriverOrderModel.h
//  mybigbrother
//
//  Created by SN on 2017/5/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DriverOrderModel : NSObject
/** 到达时间*/
@property (nonatomic, strong) NSString * a_time ;
/** 预估价格*/
@property (nonatomic, strong) NSString * actual_price ;
/** 送*/
@property (nonatomic, strong) NSString * give ;
/** 接*/
@property (nonatomic, strong) NSString * meet ;
/** 订单id*/
@property (nonatomic, strong) NSString * or_id ;
/** 订单编号*/
@property (nonatomic, strong) NSString * or_number ;
/** 订单价格*/
@property (nonatomic, strong) NSString * or_price ;
/** 行程状态*/
@property (nonatomic, strong) NSString * status ;
/** 预约状态*/
@property (nonatomic, strong) NSString * t_status ;

/** 联系人*/
@property (nonatomic, strong) NSArray * contacts;
@end
