//
//  WBMakeCallView.m
//  mybigbrother
//
//  Created by SN on 2017/6/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WBMakeCallView.h"

@implementation WBMakeCallView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    UIImageView * call = [[UIImageView alloc]init];
    call.image = [UIImage imageNamed:@"makecall"];
    
    UILabel * title = [[UILabel alloc]init];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"联系境内客服";
    title.font = MBBFONT(14);
    title.textColor = RGB(102, 102, 102);
    
    [self addSubview:call];
    [self addSubview:title];
    
    [call mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(26);
        make.left.mas_equalTo(15);
    }];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(call.mas_right).offset(15);
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(makeaCall)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)makeaCall{
    
    NSMutableString *str =[[NSMutableString alloc] initWithFormat:@"telprompt://%@", @"010-56617246"];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
}
@end
