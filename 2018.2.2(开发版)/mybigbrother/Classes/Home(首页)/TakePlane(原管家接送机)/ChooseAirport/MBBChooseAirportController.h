//
//  MBBChooseAirportController.h
//  mybigbrother
//
//  Created by SN on 2017/4/17.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYBaseUIViewController.h"
@class AirportModel;
@interface MBBChooseAirportController : WYBaseUIViewController
/** 回调机场名字*/
@property (nonatomic,   copy) void (^airportBlock)(AirportModel * model);
@end
