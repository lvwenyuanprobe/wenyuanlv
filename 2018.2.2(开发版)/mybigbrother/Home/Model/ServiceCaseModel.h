//
//  ServiceCaseModel.h
//  mybigbrother
//
//  Created by SN on 2017/4/18.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
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
