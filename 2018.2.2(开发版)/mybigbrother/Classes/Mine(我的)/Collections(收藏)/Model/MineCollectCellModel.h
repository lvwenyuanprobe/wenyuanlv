//
//  MineCollectCellModel.h
//  mybigbrother
//
//  Created by SN on 2017/6/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineCollectCellModel : NSObject
/** 内容*/
@property (nonatomic, strong) NSString * type;
/** 名称*/
@property (nonatomic, strong) NSString * name;
/** id*/
@property (nonatomic, assign) NSInteger  c_id;
/** 类型:1案例 2攻略*/
@property (nonatomic, strong) NSString * c_type;
/** 标题*/
@property (nonatomic, strong) NSString * title;

/** 图片*/
@property (nonatomic, strong) NSString * c_img;

/** 收藏的时候针对我收藏的id*/
@property(nonatomic, assign)  NSInteger  col_id;

@end
