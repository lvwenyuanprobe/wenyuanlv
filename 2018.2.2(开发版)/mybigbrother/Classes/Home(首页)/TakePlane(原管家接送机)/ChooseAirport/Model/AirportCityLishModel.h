//
//  AirportCityLishModel.h
//  mybigbrother
//
//  Created by 方舟智联 on 2017/10/20.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AirportModel.h"

@interface AirportCityLishModel : NSObject

/** 机场id*/
@property (nonatomic, strong) NSString * a_id;
/** 机场名称*/
@property (nonatomic, strong) NSString * a_name;
/** 机场城市*/
@property (nonatomic, strong) NSString * c_name;
/** 英文机场*/
@property (nonatomic, strong) NSString * a_named;
/** 机场子类数据*/
@property (nonatomic, strong) NSArray<AirportModel *> * data;
@end
