//
//  MMBasePopupView.h
//  MMComboBoxDemo
//
//  WY
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMItem;
@protocol MMPopupViewDelegate;
@interface MMBasePopupView : UIView 
//@property (nonatomic, strong) MMItem *item;
@property (nonatomic, assign) CGRect sourceFrame;                                       /* tapBar的frame**/
@property (nonatomic, strong) UIView *shadowView;                                       /* 遮罩层**/
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UITableView *subTableView;
@property (nonatomic, strong) NSMutableArray *selectedArray;                            /* 记录所选的item**/
@property (nonatomic, strong) NSArray *temporaryArray;                                  /* 暂存最初的状态**/


@property (nonatomic, weak) id<MMPopupViewDelegate> delegate;
+ (MMBasePopupView *)getSubPopupView:(MMItem *)item;
- (id)initWithItem:(MMItem *)item;

- (void)popupViewFromSourceFrame:(CGRect)frame completion:(void (^)(void))completion;
- (void)dismiss;
- (void)dismissWithOutAnimation;

@end

@protocol MMPopupViewDelegate <NSObject>
@optional
- (void)popupView:(MMBasePopupView *)popupView didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index;
@required
- (void)popupViewWillDismiss:(MMBasePopupView *)popupView;
@end
