//
//  MBBCommitOrderController.h
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBBaseUIViewController.h"

#import "CustomServiceCellModel.h"



@interface MBBCommitOrderController : MBBBaseUIViewController

/** required, 定制服务两者必传*/
/** 服务*/
@property (nonatomic, strong) NSString * ma_id;
/** 服务价格*/
@property (nonatomic, strong) NSString * price;

/** 服务模型(注意传递)*/
@property (nonatomic, strong) CustomServiceCellModel * model;

@end
