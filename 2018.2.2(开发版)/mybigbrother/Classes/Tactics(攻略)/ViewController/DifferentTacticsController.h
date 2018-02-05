//
//  DifferentTacticsController.h
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ListViewController.h"

@interface DifferentTacticsController : ListViewController
/** 传入一个导航控制器*/
@property (nonatomic,strong)UINavigationController * kNavigationController;
/** 传入类型(bigbrotherShare 分享  newTactics 攻略)*/
@property (nonatomic,strong)NSString * type;
/** 回调banner*/
@property (nonatomic,copy) void(^bannerImagesBlock)(NSArray * imageStringGroup);
@property (nonatomic, assign) BOOL vcCanScroll;
@end
