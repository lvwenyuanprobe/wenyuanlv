//
//  SearchListModel.h
//  mybigbrother
//
//  Created by SN on 2017/4/25.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchListModel : NSObject

/** id*/
@property (nonatomic, assign) NSInteger  f_id ;
/** 图片*/
@property (nonatomic, strong) NSString * f_img ;
/** 名称*/
@property (nonatomic, strong) NSString * f_name ;
/** 人数*/
@property (nonatomic, assign) NSInteger  f_number ;
/** 价格*/
@property (nonatomic, strong) NSString * f_price ;

@end
