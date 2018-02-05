//
//  WYPostType.m
//  mybigbrother
//
//  Created by Loren on 2018/1/23.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYPostType.h"

@implementation WYPostType
+ (instancetype)businessTypeWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}
@end
