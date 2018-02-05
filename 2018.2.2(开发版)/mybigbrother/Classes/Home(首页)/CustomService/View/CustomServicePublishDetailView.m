//
//  CustomServicePublishDetailView.m
//  mybigbrother
//
//  Created by SN on 2017/6/21.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "CustomServicePublishDetailView.h"

@interface CustomServicePublishDetailView ()
@property (nonatomic, strong) UIButton * centerBtn;
@end
@implementation CustomServicePublishDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    self.backgroundColor =  [UIColor whiteColor];
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self addSubview:line];
    
    line.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
    
    UIButton * makeOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    makeOrderBtn.titleLabel.textColor = [UIColor whiteColor];
    [makeOrderBtn setBackgroundImage:[UIImage imageWithColor:BUTTON_COLOR] forState:UIControlStateNormal];
    [makeOrderBtn setBackgroundImage:[UIImage imageWithColor:BUTTON_COLOR] forState:UIControlStateSelected];
    [makeOrderBtn setTitle:@"我要发布" forState:UIControlStateNormal];
    [makeOrderBtn addTarget:self action:@selector(makeOrderClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:makeOrderBtn];

    _centerBtn = makeOrderBtn;
    
    _centerBtn.sd_layout
    .topSpaceToView(self,1)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(43);
}
- (void)makeOrderClicked{
    if ([self.delegate respondsToSelector:@selector(CustomServicePublishDetailViewClick)]) {
        [self.delegate CustomServicePublishDetailViewClick];
    }
}
@end
