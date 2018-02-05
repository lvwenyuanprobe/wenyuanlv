//
//  MyCommitJudgeView.h
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyCommitJudgeViewDelegate <NSObject>
/** 发表评价*/
- (void)publishMyComment;

@end

@interface MyCommitJudgeView : UIView
@property (nonatomic, strong) UIButton *  leftBtn;
@property (nonatomic, weak)id<MyCommitJudgeViewDelegate>delegate;
@end
