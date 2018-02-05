//
//  TakeCarDateView.m
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "TakeCarDateView.h"

@implementation TakeCarDateView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"包车日期";
    titleLabel.textColor = FONT_DARK;
    titleLabel.font = MBBFONT(17);
    [self addSubview:titleLabel];
    
    UILabel * begin = [[UILabel alloc]init];
    begin.text = @"请选择开始日期";
    begin.textColor = FONT_LIGHT;
    begin.font = MBBFONT(15);
    [self addSubview:begin];

    
    UILabel * end = [[UILabel alloc]init];
    end.text = @"请选择结束日期";
    end.textColor = FONT_LIGHT;
    end.font = MBBFONT(15);
    [self addSubview:end];
    
    begin.tag = KTakeCarTimeBegin;
    end.tag   = KTakeCarTimeEnd;
    
    _beginLabel = begin;
    _endLabel = end;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.equalTo(self);
    }];
    
    [_beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20);
        make.right.mas_equalTo(-20);
    }];
    
    UITapGestureRecognizer * beginTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTime:)];
    _beginLabel.userInteractionEnabled = YES;
    [_beginLabel addGestureRecognizer:beginTap];
    
    UITapGestureRecognizer * endTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTime:)];
    _endLabel.userInteractionEnabled = YES;
    [_endLabel addGestureRecognizer:endTap];
    
    self.userInteractionEnabled = YES;
    
}

- (void)chooseTime:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(takeCarTimeChoose:)]) {
        [self.delegate takeCarTimeChoose:tap.view.tag];
    }
}


@end
