//
//  MyCommitJudgeView.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MyCommitJudgeView.h"
@interface MyCommitJudgeView()

@property (nonatomic, strong) UIButton *  rightBtn ;
@end

@implementation MyCommitJudgeView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self addSubview:line];
    
    line.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(1);
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitleColor:FONT_DARK forState:UIControlStateNormal];;
    [leftBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    [leftBtn setTitle:@"匿名评价" forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"judge_no"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"judge_right"] forState:UIControlStateSelected];
    [leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    _leftBtn = leftBtn;
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.titleLabel.textColor = [UIColor whiteColor];
    [rightBtn setBackgroundImage:[UIImage imageWithColor:BASE_YELLOW] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageWithColor:BASE_YELLOW] forState:UIControlStateSelected];
    [rightBtn setTitle:@"发表评价" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(commitComment) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    _rightBtn = rightBtn;
    
    
    
    _leftBtn.sd_layout
    .topSpaceToView(self,1)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH*2/3)
    .heightIs(43);
    
    _rightBtn.sd_layout
    .topSpaceToView(self,1)
    .leftSpaceToView(_leftBtn,0)
    .widthIs(SCREEN_WIDTH/3)
    .heightIs(43);
}
- (void)leftBtnClicked:(UIButton *)btn{
    btn.selected = !btn.selected;
}
- (void)commitComment{
    if ([self.delegate respondsToSelector:@selector(publishMyComment)]) {
        [self.delegate publishMyComment];
    }
}
@end
