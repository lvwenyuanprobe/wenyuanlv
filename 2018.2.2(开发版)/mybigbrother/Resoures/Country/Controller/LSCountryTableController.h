//
//  LSCountryTableController.h
//  mybigbrother
//
//  Created by SN on 2017/6/16.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MXBaseTableViewController.h"
#import "CountryNameModel.h"

@interface LSCountryTableController : MXBaseTableViewController
@property (nonatomic, copy) void(^countryBlock)(CountryNameModel * model) ;
@end
