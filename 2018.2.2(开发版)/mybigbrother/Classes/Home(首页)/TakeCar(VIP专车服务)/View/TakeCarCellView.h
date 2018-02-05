//
//  TakeCarCellView.h
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TakeCarCellViewDelegate <NSObject>
/** 点击事件*/
- (void)takeCarChooseTap:(NSInteger )tag;

@end

@interface TakeCarCellView : UIView
@property (nonatomic, strong) UILabel * titleLabel ;
@property (nonatomic, strong) UILabel * leftLabel ;
@property (nonatomic, weak) id<TakeCarCellViewDelegate>delegate;
@end
