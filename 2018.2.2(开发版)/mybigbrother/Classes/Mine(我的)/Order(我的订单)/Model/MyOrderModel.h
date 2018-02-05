//
//  MyOrderModel.h
//  mybigbrother
//
//  Created by SN on 2017/4/18.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderModel : NSObject
/** 图片*/
@property (nonatomic, strong) NSString *  f_img;
/** 名称*/
@property (nonatomic, strong) NSString *  f_name;
/** 订单id*/
@property (nonatomic, strong) NSString *  or_id;
/** 订单号*/
@property (nonatomic, strong) NSString *  or_number;
/** 订单价格*/
@property (nonatomic, strong) NSString *  or_price;

/** 是否使用优惠券*/
@property (nonatomic, assign) NSInteger   co_id;
/** 订单状态
 500 待付款
 100 进行中
 110 待评价
 111 已完成
 */
@property (nonatomic, assign) NSInteger   status;
/** 用户id*/
@property (nonatomic, assign) NSInteger   u_id;


@end
