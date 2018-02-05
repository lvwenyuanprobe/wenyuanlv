//
//  PartnersTogetherModel.m
//  mybigbrother
//
//  Created by SN on 2017/4/19.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "PartnersTogetherModel.h"
#import "MBBUserFavModel.h"

@implementation PartnersTogetherModel

+ (NSDictionary *)objectClassInArray{
    
    return @{
             @"userlist":[MBBUserFavModel class]
             };
}



@end
