//
//  CouponCellModel.h
//  mybigbrother
//
//  Created by SN on 2017/4/21.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponCellModel : NSObject
/** 优惠券id*/
@property (nonatomic, strong) NSString * co_id ;
/** 优惠券折扣*/
@property (nonatomic, strong) NSString * co_price ;
/** 优惠券到期时间*/
@property (nonatomic, strong) NSString * end_time ;
/** 优惠券开始时间*/
@property (nonatomic, strong) NSString * start_time;
/** 优惠券数量*/
@property (nonatomic, strong) NSString * co_number;

@end
