//
//  MBBUserInfoModel.h
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBBUser.h"

@interface MBBUserInfoModel : NSObject
/** token*/
@property(nonatomic, strong) NSString * token;

/** 用户信息*/
@property(nonatomic, strong) MBBUser  * user;

/** 字典转化模型*/
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/** 模型转化字典*/
- (NSDictionary *)toDictionary;

/** 本地字典转模型*/
- (instancetype)initWithLocalDictionary:(NSDictionary *)dictionary;

@end
