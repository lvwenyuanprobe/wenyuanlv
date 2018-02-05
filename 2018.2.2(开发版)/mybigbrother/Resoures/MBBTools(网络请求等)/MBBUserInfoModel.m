//
//  MBBUserInfoModel.m
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBUserInfoModel.h"

@implementation MBBUserInfoModel
/**
 * Instantiate the instance using the passed dictionary values to set the
 * properties values
 */

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (![dictionary[@"token"] isKindOfClass:[NSNull class]]) {
        self.token = dictionary[@"token"];
    }
    if (![dictionary[@"data"] isKindOfClass:[NSNull class]]) {
        self.user = [[MBBUser alloc] initWithDictionary:dictionary[@"data"]];
    }
    return self;
}

- (instancetype)initWithLocalDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (![dictionary[@"token"] isKindOfClass:[NSNull class]]) {
        self.token = dictionary[@"token"];
    }
    if (![dictionary[@"data"] isKindOfClass:[NSNull class]]) {
        self.user = [[MBBUser alloc] initWithLocalDictionary:dictionary[@"data"]];
    }
    return self;
}

/**
 * Returns all the available property values in the form of NSDictionary object
 * where the key is the approperiate json key and the value is the value of the
 * corresponding property
 */
- (NSDictionary *)toDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (self.token != nil) {
        dictionary[@"token"] = self.token;
    }
    if (self.user != nil) {
        dictionary[@"data"] = [self.user toDictionary];
    }
    return dictionary;
}

@end
