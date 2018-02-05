//
//  ServiceBannerModel.h
//  mybigbrother
//
//  Created by SN on 2017/5/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceBannerModel : NSObject

/** 横幅id*/
@property (nonatomic, strong) NSString * b_id ;
/** 横幅图片*/
@property (nonatomic, strong) NSString * b_img ;
/** 横幅标题*/
@property (nonatomic, strong) NSString * b_title ;
/** */
@property (nonatomic, strong) NSString * b_url ;

@end
