//
//  PartnersTogetherModel.h
//  mybigbrother
//
//  Created by 梦想 on 2017/4/19.
//  Copyright © 2017年 飞凡创客联盟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartnersTogetherModel : NSObject
/** 昵称*/
@property (nonatomic, strong) NSString * nickname ;
/** 昵称*/
@property (nonatomic, strong) NSString * u_nickname ;
/** 描述简介*/
@property (nonatomic, strong) NSString * r_desc ;
/** 发布图片*/
@property (nonatomic, strong) NSString * r_img ;
/** 学校*/
@property (nonatomic, strong) NSString * r_school ;
/** 出发*/
@property (nonatomic, strong) NSString * r_setout ;
/** 用户头像*/
@property (nonatomic, strong) NSString * u_img ;
/** 发布时间*/
@property (nonatomic, strong) NSString * r_time ;

/** 到达*/
@property (nonatomic, strong) NSString *  r_arrive ;
/** 约伴限制*/
@property (nonatomic, assign) NSInteger  r_astrict ;
/** 航班号*/
@property (nonatomic, assign) NSString *  r_flight ;
/** 发布内容id*/
@property (nonatomic, assign) NSInteger  r_id ;
/** */
@property (nonatomic, assign) NSString *  r_status ;
/** 用户id*/
@property (nonatomic, strong) NSString *  u_id;


/** 出发时间*/
@property (nonatomic, strong) NSString * r_starttime;

/** fav useInfo(用户信息模型)*/
@property (nonatomic, strong) NSArray  * userlist;

@end
