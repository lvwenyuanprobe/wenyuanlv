//
//  ZFBBusinessType.m
//  05-商家分类
//
//  Created by LV on 16/8/14.
//  Copyright © 2016年 LV. All rights reserved.
//

#import "ZFBBusinessType.h"

@implementation ZFBBusinessType
+ (instancetype)businessTypeWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}
@end
