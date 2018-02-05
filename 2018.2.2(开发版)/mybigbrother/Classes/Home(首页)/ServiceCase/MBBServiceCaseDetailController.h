//
//  MBBServiceCaseDetailController.h
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBBaseUIViewController.h"
#import "ServiceCaseModel.h"
#import "MineCollectCellModel.h"

@interface MBBServiceCaseDetailController : MBBBaseUIViewController

/** 首页列表传入*/
@property (nonatomic, strong) ServiceCaseModel * model ;

/** 收藏列表传入*/
@property (nonatomic, strong) MineCollectCellModel* cellModel;
@end
