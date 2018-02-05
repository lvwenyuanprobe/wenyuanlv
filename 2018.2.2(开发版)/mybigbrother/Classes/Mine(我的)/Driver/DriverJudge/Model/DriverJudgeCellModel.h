//
//  DriverJudgeCellModel.h
//  mybigbrother
//
//  Created by SN on 2017/5/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DriverJudgeCellModel : NSObject

@property (nonatomic, strong) NSString * th_bewrite ;
@property (nonatomic, strong) NSString * th_id ;
@property (nonatomic, strong) NSString * th_price ;
@property (nonatomic, strong) NSString * th_quality ;
@property (nonatomic, strong) NSString * th_user ;
@property (nonatomic, strong) NSString * u_id ;


/** 头像*/
@property (nonatomic, strong) NSString * u_img ;
/** 昵称*/
@property (nonatomic, strong) NSString * u_nickname ;
/** 内容*/
@property (nonatomic, strong) NSString * th_con ;
/** 星级*/
@property (nonatomic, strong) NSString * th_total ;

/** 时间*/
@property (nonatomic, strong) NSString * th_time;

@end
