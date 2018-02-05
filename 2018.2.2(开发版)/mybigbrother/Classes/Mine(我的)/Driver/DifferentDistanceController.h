//
//  DifferentDistanceController.h
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ListViewController.h"

@interface DifferentDistanceController : ListViewController
/** 传入一个导航控制器*/
@property (nonatomic,strong)UINavigationController * kNavigationController;

/** 订单状态: 0 未预约 1 已预约 2 进行中 3 已完成 */
@property (nonatomic, strong) NSString  * orderState;

@end
