//
//  TacticsShareDetailController.h
//  mybigbrother
//
//  Created by SN on 2017/4/18.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBBaseUIViewController.h"
#import "TacticsShareModel.h"
#import "MineCollectCellModel.h"

@interface TacticsShareDetailController : MBBBaseUIViewController

/** 首页列表*/
@property (nonatomic, strong) TacticsShareModel  * model ;

/** 收藏列表*/
@property (nonatomic, strong) MineCollectCellModel  * collectModel ;


@end
