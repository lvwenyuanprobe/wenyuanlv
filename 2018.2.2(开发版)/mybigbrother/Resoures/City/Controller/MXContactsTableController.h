//
//  MXContactsTableController.h
//  mybigbrother
//
//  Created by SN on 2017/4/20.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MXBaseTableViewController.h"
@class CityModel;
@interface MXContactsTableController : MXBaseTableViewController
@property (nonatomic, copy) void(^cityBlock)(CityModel * model) ;
@end
