//
//  TakeCarCellView.m
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "TakeCarCellView.h"

@implementation TakeCarCellView

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
    titleLabel.text = @"开始城市";
    titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    titleLabel.font = MBBFONT(17);
    [self addSubview:titleLabel];
    
    _titleLabel = titleLabel;
    
    

    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.text = @"请选择出发开始城市";
    leftLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    leftLabel.font = MBBFONT(15);
    [self addSubview:leftLabel];
    
    _leftLabel = leftLabel;
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
    }];
    
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel);
        make.right.mas_equalTo(-20);
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTap:)];
    self.userInteractionEnabled = YES;
    [self  addGestureRecognizer:tap];
}
- (void)chooseTap:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(takeCarChooseTap:)]) {
        [self.delegate takeCarChooseTap:tap.view.tag];
    }

}
@end
