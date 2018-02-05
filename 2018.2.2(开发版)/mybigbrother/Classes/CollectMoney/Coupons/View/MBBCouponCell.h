//
//  MBBCouponCell.h
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CouponCellModel;

@interface MBBCouponCell : UITableViewCell
@property (nonatomic, strong) CouponCellModel * model;
/** 优惠券状态(1未使用)*/
@property (nonatomic, strong) NSNumber * couponStatus;

/** choose 0 */
@property (nonatomic, strong) NSNumber * choose;

@property (nonatomic, strong) UIButton * chooseBtn;

@end
