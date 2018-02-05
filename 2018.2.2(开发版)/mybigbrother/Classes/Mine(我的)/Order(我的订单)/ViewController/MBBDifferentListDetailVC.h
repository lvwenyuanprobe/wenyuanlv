//
//  MBBDifferentListDetailVC.h
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ListViewController.h"

@interface MBBDifferentListDetailVC : ListViewController

/** 传入一个导航控制器*/
@property (nonatomic,strong)UINavigationController * kNavigationController;
    
/** 订单状态:
 500 待付款
 100 进行中 
 110 未评价 
 111 已完成  
 空获取全部*/
@property (nonatomic, strong) NSString  * status;

@end
