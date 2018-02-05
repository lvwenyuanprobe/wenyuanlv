//
//  MyJudgeBottomView.h
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyJudgeStarsScoreView;

@interface MyJudgeBottomView : UIView
@property (nonatomic, strong) MyJudgeStarsScoreView * judge ;
@property (nonatomic, strong) MBBCustomTextView * feedBackTextView ;
@end
