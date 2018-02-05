//
//  ServicesModel.h
//  mybigbrother
//
//  Created by SN on 2017/4/14.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServicesModel : NSObject
/** 服务名称*/
@property (nonatomic, strong) NSString * f_name;
/** 图片*/
@property (nonatomic, strong) NSString * f_img;
/** 类型 0 1 */
@property (nonatomic, strong) NSString * f_type;
/** 服务id*/
@property (nonatomic, strong) NSString * f_id;
/** 服务费用*/
@property (nonatomic, strong) NSString * f_price;

@end
