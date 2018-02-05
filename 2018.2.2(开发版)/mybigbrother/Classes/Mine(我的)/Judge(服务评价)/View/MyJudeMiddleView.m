//
//  MyJudeMiddleView.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MyJudeMiddleView.h"
#import "MyJudgeStarsScoreView.h"

@implementation MyJudeMiddleView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    
    MyJudgeStarsScoreView * discrib = [[MyJudgeStarsScoreView alloc]init];
    discrib.title.text = @"服务描述";
    discrib.frame = CGRectMake(0, 5, SCREEN_WIDTH, 44);
    [self addSubview:discrib];
    
    MyJudgeStarsScoreView * quality = [[MyJudgeStarsScoreView alloc]init];
    quality.frame = CGRectMake(0, CGRectGetMaxY(discrib.frame)+5, SCREEN_WIDTH, 44);
    quality.title.text = @"服务质量";
    [self addSubview:quality];

    MyJudgeStarsScoreView * price = [[MyJudgeStarsScoreView alloc]init];
    price.frame = CGRectMake(0, CGRectGetMaxY(quality.frame)+5, SCREEN_WIDTH, 44);
    price.title.text = @"价格合理";
    [self addSubview:price];
    
    _discrib = discrib;
    _quality = quality;
    _price = price;
    
    
}

@end
