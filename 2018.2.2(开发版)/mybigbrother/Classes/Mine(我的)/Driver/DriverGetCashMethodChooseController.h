//
//  DriverGetCashMethodChooseController.h
//  mybigbrother
//
//  Created by SN on 2017/5/11.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBBaseUIViewController.h"
typedef NS_ENUM (NSInteger, KGetCashMethodType){
    KGetCashAlipay = 100,
    KGetCashWeixin,
};

@interface DriverGetCashMethodChooseController : MBBBaseUIViewController
@property (nonatomic,   copy) void(^chooseMethodBlock)(KGetCashMethodType method) ;
@end
