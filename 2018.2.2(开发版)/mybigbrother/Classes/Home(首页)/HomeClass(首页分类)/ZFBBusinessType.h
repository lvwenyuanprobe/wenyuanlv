//
//  ZFBBusinessType.h
//  05-商家分类
//
//  Created by LV on 16/8/14.
//  Copyright © 2016年 LV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFBBusinessType : NSObject
/**
 图片
 */
@property (nonatomic, copy) NSString *icon;
/**
 名称
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)businessTypeWithDict:(NSDictionary *)dict;
@end

