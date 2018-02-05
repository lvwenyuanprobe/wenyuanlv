//
//  MyJudgeBottomView.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MyJudgeBottomView.h"
#import "MyJudgeStarsScoreView.h"
#import "MBBCustomTextView.h"
@interface MyJudgeBottomView ()<UITextViewDelegate>
@end

@implementation MyJudgeBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}

- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];

    MyJudgeStarsScoreView * judge = [[MyJudgeStarsScoreView alloc]init];
    judge.frame = CGRectMake(0, 5, SCREEN_WIDTH, 40);
    judge.title.text = @"总体评价";
    _judge = judge;
    
    [self addSubview:judge];

    /** 意见输入框*/
    MBBCustomTextView * feedBackTextView = [[MBBCustomTextView alloc] initWithFrame:CGRectMake(40,
                                                                           CGRectGetMaxY(judge.frame)+20,
                                                                           SCREEN_WIDTH - 80,
                                                                           100)
                                                 andPlaceholder:@"请写下您宝贵的意见"
                                            andPlaceholderColor:FONT_LIGHT];
    [self addSubview:feedBackTextView];
    feedBackTextView.backgroundColor = BASE_VC_COLOR;
    feedBackTextView.clipsToBounds = YES;
    feedBackTextView.layer.cornerRadius = 3;
    feedBackTextView.textColor = FONT_DARK;
    feedBackTextView.font = MBBFONT(12);
    feedBackTextView.keyboardType = UIKeyboardTypeDefault;
    feedBackTextView.delegate = self;
    _feedBackTextView = feedBackTextView;
    
//    [feedBackTextView becomeFirstResponder];
    
}
@end
