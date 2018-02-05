//
//  CityModel.h
//  mybigbrother
//
//  Created by SN on 2017/4/20.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
/** 城市名称*/
@property (nonatomic, strong) NSString * c_name;

/** 英文*/
@property (nonatomic, strong) NSString * c_named;

@property (nonatomic, assign) NSInteger c_id;

@property (nonatomic, assign) NSInteger p_id;

@end
