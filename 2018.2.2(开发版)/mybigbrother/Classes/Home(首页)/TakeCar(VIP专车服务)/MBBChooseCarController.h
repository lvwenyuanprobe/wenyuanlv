//
//  MBBChooseCarController.h
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBBaseUIViewController.h"

@interface MBBChooseCarController : MBBBaseUIViewController

/** 出行人数*/
@property (nonatomic, assign) NSInteger   personNumber ;

/** 包车天数*/
@property (nonatomic, assign) NSInteger   chaterCarDays;

/** 包车信息*/
@property (nonatomic, strong) NSMutableDictionary  *  infoDic;
@end
