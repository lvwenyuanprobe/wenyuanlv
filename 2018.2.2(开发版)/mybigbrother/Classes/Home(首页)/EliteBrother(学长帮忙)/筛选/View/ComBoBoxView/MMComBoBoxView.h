//
//  MMComBoBoxView.h
//  MMComboBoxDemo
//
//  WY
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMItem.h"

@protocol MMComBoBoxViewDataSource;
@protocol MMComBoBoxViewDelegate;
@interface MMComBoBoxView : UIView
@property (nonatomic, weak) id<MMComBoBoxViewDataSource> dataSource;
@property (nonatomic, weak) id<MMComBoBoxViewDelegate> delegate;
- (void)reload;
- (void)dimissPopView;
@end

@protocol MMComBoBoxViewDataSource <NSObject>
@required;
- (NSUInteger)numberOfColumnsIncomBoBoxView :(MMComBoBoxView *)comBoBoxView;
- (MMItem *)comBoBoxView:(MMComBoBoxView *)comBoBoxView infomationForColumn:(NSUInteger)column;
@end

@protocol MMComBoBoxViewDelegate <NSObject>
@optional
- (void)comBoBoxView:(MMComBoBoxView *)comBoBoxViewd didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index;
@end
