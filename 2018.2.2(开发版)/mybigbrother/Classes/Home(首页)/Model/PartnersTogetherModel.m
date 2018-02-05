//
//  PartnersTogetherModel.m
//  mybigbrother
//
//  Created by 梦想 on 2017/4/19.
//  Copyright © 2017年 飞凡创客联盟. All rights reserved.
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
