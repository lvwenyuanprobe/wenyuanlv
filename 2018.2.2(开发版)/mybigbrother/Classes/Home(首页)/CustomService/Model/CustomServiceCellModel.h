//
//  CustomServiceCellModel.h
//  mybigbrother
//
//  Created by SN on 2017/4/17.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomServiceCellModel : NSObject
/** 定制服务id*/
@property (nonatomic, strong) NSString * ma_id;
/** 主标题*/
@property (nonatomic, strong) NSString * ma_title;
/** 副标题*/
@property (nonatomic, strong) NSString * ma_content;
/** 图片*/
@property (nonatomic, strong) NSString * ma_path;

/** 服务价格*/
@property (nonatomic, strong) NSString * price;

@property (nonatomic, strong) NSString * ma_price;

@end
