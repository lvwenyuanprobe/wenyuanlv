//
//  TacticsShareModel.h
//  mybigbrother
//
//  Created by SN on 2017/4/18.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TacticsShareModel : NSObject
/** 内容*/
@property (nonatomic, strong) NSString * ra_content;

@property (nonatomic, strong) NSString * r_content;

/** id*/
@property (nonatomic, assign) NSInteger  ra_id;
/** 图片*/
@property (nonatomic, strong) NSString * ra_img;
/** 标题*/
@property (nonatomic, strong) NSString * ra_title;

@end
