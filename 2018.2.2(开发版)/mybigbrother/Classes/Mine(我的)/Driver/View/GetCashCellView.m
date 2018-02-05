//
//  GetCashCellView.m
//  mybigbrother
//
//  Created by SN on 2017/5/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "GetCashCellView.h"

@implementation GetCashCellView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel * left = [[UILabel alloc]init];
    left.textColor = FONT_DARK;
    left.font = MBBFONT(13);
    [self addSubview:left];
    
    UILabel * right = [[UILabel alloc]init];
    right.textColor = FONT_LIGHT;
    right.font = MBBFONT(13);
    [self addSubview:right];
    
    left.sd_layout
    .topSpaceToView(self,10)
    .leftSpaceToView(self,10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(24);
    
    right.sd_layout
    .topSpaceToView(self,10)
    .leftSpaceToView(self,10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(24);
    right.textAlignment = NSTextAlignmentRight;
    
    _leftLabel= left;
    _rightLabel = right;    
}
@end
