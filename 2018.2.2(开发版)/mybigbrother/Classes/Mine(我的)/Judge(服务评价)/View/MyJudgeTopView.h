//
//  MyJudgeTopView.h
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomServiceCellModel.h"
#import "MyOrderDetailModel.h"
#import "SPCommitOrderTopModel.h"

@interface MyJudgeTopView : UIView


/** 为评价与服务提交订单页公用顶部视图*/
/** 服务模型(注意是传递层)[服务提交订单顶部视图]*/
@property (nonatomic, strong) CustomServiceCellModel * model;

/** 评价顶部视图 */
@property (nonatomic, strong) MyOrderDetailModel  * judgeModel;

/** 学生家长提交订单 */
@property (nonatomic, strong) SPCommitOrderTopModel * SPCommitOrderModel;

@end
