//
//  OrderInfoCellView.h
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderInfoCell;
@protocol OrderInfoCellDelegate <NSObject>
@optional
/** 结束编辑*/
- (void)rightFieldDidEndEdit:(OrderInfoCell *)cell;

@end

@interface OrderInfoCell : UITableViewCell
@property (nonatomic, strong) UILabel     *   leftLabel;
@property (nonatomic, strong) UITextField *   rightField;
@property (nonatomic, strong) UIView *   line;


@property (nonatomic, weak)id<OrderInfoCellDelegate>cellDelegate;
/** 表格的位置*/
@property (nonatomic, strong) NSIndexPath * cellIndexPath;

@end
