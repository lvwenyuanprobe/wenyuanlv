//
//  MMHeaderView.h
//  MMComboBoxDemo
//
//  Created by wyy on 2016/12/19.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMCombinationItem.h"

@protocol MMHeaderViewDelegate;
@interface MMHeaderView : UIView
@property (nonatomic, strong) MMCombinationItem *item;
@property (nonatomic, weak) id<MMHeaderViewDelegate> delegate;
@end

@protocol MMHeaderViewDelegate <NSObject>
- (void)headerView:(MMHeaderView *)headerView didSelectedAtIndex:(NSInteger)index currentState:(BOOL)isSelected;
@end
