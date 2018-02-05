//
//  SPCommitOrderTopModel.h
//  mybigbrother
//
//  Created by SN on 2017/6/15.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPCommitOrderTopModel : NSObject
@property (nonatomic, strong) NSString * content ;
@property (nonatomic, strong) NSString * f_content;
@property (nonatomic, strong) NSString * f_id ;
@property (nonatomic, strong) NSString * f_img ;
@property (nonatomic, strong) NSString * f_price ;

/** 0学生 1 家长*/
@property (nonatomic, strong) NSString * f_type ;

@end
