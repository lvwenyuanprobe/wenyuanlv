//
//  CarModel.h
//  mybigbrother
//
//  Created by SN on 2017/4/13.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject
/** 车辆描述*/
@property (nonatomic, strong) NSString *  car_desc;
/** id*/
@property (nonatomic, assign) NSInteger   car_id;
/** 车辆图片*/
@property (nonatomic, strong) NSString *  car_img;
/** 可载行李数*/
@property (nonatomic, assign) NSInteger   car_lugaae;
/** 可载人数*/
@property (nonatomic, assign) NSInteger   car_number;
/** 租用费*/
@property (nonatomic, assign) CGFloat     car_price;
/** 车辆类型*/
@property (nonatomic, strong) NSString *  car_type;
/** 是否显示*/
@property (nonatomic, assign) NSInteger   is_show;
/** 可载行李大小*/
@property (nonatomic, assign) NSInteger   lugaae_size;

@end
