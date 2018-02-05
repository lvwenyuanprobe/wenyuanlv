//
//  WYPostType.h
//  mybigbrother
//
//  Created by Loren on 2018/1/23.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYPostType : NSObject
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
