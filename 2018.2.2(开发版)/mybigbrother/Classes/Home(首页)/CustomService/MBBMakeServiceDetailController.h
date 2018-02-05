//
//  MBBMakeServiceDetailController.h
//  mybigbrother
//
//  Created by SN on 2017/4/17.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBBaseUIViewController.h"
#import "CustomServiceCellModel.h"
#import "WYBaseUIViewController.h"

@interface MBBMakeServiceDetailController : WYBaseUIViewController

/** 服务id(必传)*/
@property (nonatomic, strong) NSString * serviceId;
/** 服务名称*/
@property (nonatomic, strong) NSString * navTitle;

@end
