//
//  MBBPublishInputController.h
//  mybigbrother
//
//  Created by SN on 2017/4/14.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBBaseUIViewController.h"

@interface MBBPublishInputController : MBBBaseUIViewController

@property (nonatomic, strong) NSString * navTitle ;

/** 传入更改前字符*/
@property (nonatomic, strong) NSString * placeholder;

/** 更改类型*/
@property (nonatomic, strong) NSString * changeKey;

@property (nonatomic,   copy) void (^changeStrBlock)(NSString * changeStr) ;
@end
