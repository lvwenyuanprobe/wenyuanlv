//
//  CommentModel.h
//  mybigbrother
//
//  Created by 梦想 on 2017/4/19.
//  Copyright © 2017年 飞凡创客联盟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
/** 此条评论内容*/
@property (nonatomic, strong) NSString * com_content ;
/** 此条评论的id*/
@property (nonatomic, strong) NSString * com_id ;
/** 约伴发布者id*/
@property (nonatomic, strong) NSString * art_id ;
/** 评论回复者名字*/
@property (nonatomic, strong) NSString * put_id ;

/** 评论时间*/
@property (nonatomic, strong) NSString * add_time;
/** 评论/回复者头像*/
@property (nonatomic, strong) NSString * put_img;

/** 0只有评论 非0 回复者(pud_id)->回复->(reply_id)*/
@property (nonatomic, strong) NSString * reply_id ;

/** 类型id*/
@property (nonatomic, assign) NSInteger  type_id ;
/** 是否显示*/
@property (nonatomic, assign) NSInteger  is_show ;

/** 评论回复者id*/
@property (nonatomic, assign) NSInteger  put ;

@end
