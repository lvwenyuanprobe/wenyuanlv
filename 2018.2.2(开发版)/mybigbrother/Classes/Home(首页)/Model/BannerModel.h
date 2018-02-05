//
//  BannerModel.h
//  mybigbrother
//
//  Created by 梦想 on 2017/5/5.
//  Copyright © 2017年 飞凡创客联盟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject
/** 横幅id*/
@property (nonatomic, copy) NSString * b_id ;
/** 横幅图片*/
@property (nonatomic, copy) NSString * b_img ;
/** 横幅标题*/
@property (nonatomic, copy) NSString * b_title ;
/** */
@property (nonatomic, copy) NSString * b_url ;

@end
