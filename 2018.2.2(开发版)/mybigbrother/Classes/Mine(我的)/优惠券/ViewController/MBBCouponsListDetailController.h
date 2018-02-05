//
//  MBBCouponsListDetailController.h
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ListViewController.h"

@interface MBBCouponsListDetailController : ListViewController

/** 传入一个导航控制器*/
@property (nonatomic,strong)UINavigationController * kNavigationController;
/** 订单状态*/
@property (nonatomic, strong) NSNumber  * couponStatus;

@end
