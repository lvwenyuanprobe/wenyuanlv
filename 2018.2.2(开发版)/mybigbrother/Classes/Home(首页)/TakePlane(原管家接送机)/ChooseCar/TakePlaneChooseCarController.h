//
//  TakePlaneChooseCarController.h
//  mybigbrother
//
//  Created by SN on 2017/4/26.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYBaseUIViewController.h"
@class CarModel;
/** 回调的车模型*/
typedef void (^carBackBlock)(CarModel * popModel);

@interface TakePlaneChooseCarController : WYBaseUIViewController
/** 出行人数*/
@property (nonatomic, assign) NSInteger   personNumber ;

@property (nonatomic,  copy) carBackBlock  carPopBlock;
@end
