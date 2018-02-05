//
//  ServiceCaseModel.h
//  mybigbrother
//
//  Created by 梦想 on 2017/4/18.
//  Copyright © 2017年 飞凡创客联盟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceCaseModel : NSObject
/** 案例的id*/
@property (nonatomic, assign) NSInteger  case_id;
/** 图片*/
@property (nonatomic, strong) NSString * case_img;
/** 人数*/
@property (nonatomic, assign) NSInteger  number;
/** 旅程描述*/
@property (nonatomic, strong) NSString * trip;

@end
