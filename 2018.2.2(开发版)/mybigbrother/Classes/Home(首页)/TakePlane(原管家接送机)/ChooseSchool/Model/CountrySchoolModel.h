//
//  CountrySchoolModel.h
//  mybigbrother
//
//  Created by mac on 2017/11/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SchoolsModel.h"
@interface CountrySchoolModel : NSObject

/*  */
@property(nonatomic,copy) NSString * county;
/** 学校子类数据*/
//@property (nonatomic, strong) NSArray<SchoolsModel *> * school;
/** 学校子类数据*/
@property (nonatomic, strong) NSArray * school;
@end
