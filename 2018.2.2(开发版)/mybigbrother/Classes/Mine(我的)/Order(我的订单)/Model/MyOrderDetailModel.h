//
//  MyOrderDetailModel.h
//  mybigbrother
//
//  Created by SN on 2017/4/18.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderDetailModel : NSObject

/** 图片*/
@property (nonatomic, strong) NSString * f_img ;
/** 名称*/
@property (nonatomic, strong) NSString * f_name;
/** 订单编号*/
@property (nonatomic, strong) NSString * or_id ;
/** 价格*/
@property (nonatomic, strong) NSString * or_price;

/** 下单时间*/
@property (nonatomic, strong) NSString * or_addtime;
/** 订单支付时间*/
@property (nonatomic, strong) NSString * pay_time;
/** 订单编号*/
@property (nonatomic, strong) NSString * or_number ;


/** 状态*/
@property (nonatomic, assign) NSInteger  status ;
/** 用户id*/
@property (nonatomic, assign) NSInteger  u_id ;
/** 是否使用优惠券 0 未使用*/
@property (nonatomic, assign) NSInteger  co_id ;
/** 是否支付 0 未使用*/
@property (nonatomic, assign) NSInteger  is_pay ;

/** 是否评价 0 未评价*/
@property (nonatomic, assign) NSInteger  review ;


/******* 优惠券筛选条件 *******/
/** 机场id*/
@property (nonatomic, strong) NSString *  j_id;
/** 车id*/
@property (nonatomic, strong) NSString *  f_id;
/** 服务id*/
@property (nonatomic, strong) NSString *  car_id;

@end
