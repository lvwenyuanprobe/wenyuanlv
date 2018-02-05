//
//  MyJudgeStarsScoreView.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MyJudgeStarsScoreView.h"
@interface MyJudgeStarsScoreView ()

@property (nonatomic, strong) NSMutableArray *   buttonArray;
@property (nonatomic, strong) UIButton *   selBtn;
@property (nonatomic, strong) UILabel *   score;

@end

@implementation MyJudgeStarsScoreView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];

    
    self.buttonArray =[NSMutableArray array];
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"服务描述";
    titleLabel.textColor = FONT_DARK;
    titleLabel.font = MBBFONT(15);
    titleLabel.frame = CGRectMake(10, 12, 100, 22);
    _title = titleLabel;
    
    [self addSubview:titleLabel];
    
    UIView * starBgView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 10, 32*5, 22)];
    [self addSubview:starBgView];
    for (int i = 0; i < 5; i ++) {
        UIButton *starBtn = [[UIButton alloc] init];
        starBtn.frame = CGRectMake(i*32, 0, 22, 22);
        starBtn.tag = i;
        [starBtn setBackgroundImage:[UIImage imageNamed:@"comment_graystar"] forState:UIControlStateNormal];
        [starBtn setBackgroundImage:[UIImage imageNamed:@"comment_redstar"] forState:UIControlStateSelected];
        [starBgView addSubview:starBtn];
        if (i == 0) {
            starBtn.selected = YES;
        }
        [starBtn addTarget:self action:@selector(starBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:starBtn];
    }
    
    UILabel * score = [[UILabel alloc]init];
    score.text = @"1分";
    score.textAlignment = NSTextAlignmentCenter;
    score.textColor = [UIColor redColor];
    score.font = MBBFONT(12);
    score.backgroundColor = BASE_VC_COLOR;
    score.clipsToBounds = YES;
    score.layer.cornerRadius = 3;
    
    score.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame)+5*32+ 10, 10, 30, 22);
    _score = score;
    [self addSubview:score];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(buttonPan:)];
    starBgView.userInteractionEnabled = YES;
    [starBgView addGestureRecognizer:pan];
    


    self.scoreInt = 1;
}

- (void)starBtnClick:(UIButton *)button{
    
    if(self.selBtn == button)
    {
        return;
    }
    self.selBtn.selected = NO;
    button.selected = YES;
    self.selBtn = button;
    for (int i = 0; i < button.tag; i ++) {
        UIButton *nolBtn = self.buttonArray[i];
        nolBtn.selected = YES;
    }
    for (int i = (int)button.tag+1; i < self.buttonArray.count; i ++) {
        UIButton *nolBtn = self.buttonArray[i];
        nolBtn.selected = NO;
    }
    self.score.text = [NSString stringWithFormat:@"%ld分",(long)(button.tag+1)];
    self.scoreInt = (long)(button.tag+1);
}
- (void)buttonPan:(UISwipeGestureRecognizer *)pan{
    
    
    CGPoint  point = [pan locationInView:pan.view];
    
    self.scoreInt = (NSInteger)(point.x/20);
    if (self.scoreInt < 1) {
        self.scoreInt = 1;
    }
    if (self.scoreInt > 5) {
        self.scoreInt = 5;
    }
    for (int i = 0; i < self.scoreInt; i ++) {
        UIButton *nolBtn = self.buttonArray[i];
        nolBtn.selected = YES;
    }
    for (int i = (int)self.scoreInt; i < self.buttonArray.count; i ++) {
        UIButton *nolBtn = self.buttonArray[i];
        nolBtn.selected = NO;
    }
    self.score.text = [NSString stringWithFormat:@"%ld分",(long)(self.scoreInt)];

}
@end
