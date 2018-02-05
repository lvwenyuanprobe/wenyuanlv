//
//  MMCombineCell.h
//  MMComboBoxDemo
//
//  Created by wyy on 2016/12/19.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMCombinationItem.h"

@protocol MMCombineCellDelegate;
@interface MMCombineCell : UITableViewCell
@property (nonatomic, strong) MMItem *item;
@property (nonatomic, weak) id<MMCombineCellDelegate> delegate;
@end

@protocol MMCombineCellDelegate <NSObject>
- (void)combineCell:(MMCombineCell *)combineCell didSelectedAtIndex:(NSInteger)index;
@end
