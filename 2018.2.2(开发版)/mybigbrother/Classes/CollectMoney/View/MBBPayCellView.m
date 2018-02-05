//
//  MBBPayCellView.m
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBPayCellView.h"

@implementation MBBPayCellView
- (instancetype)initWithFrame:(CGRect)frame methodImage:(NSString *)image methodName:(NSString*)name {
    
    self = [super initWithFrame:frame];
    
    if(self){
        UIImageView *payMethodImage = [[UIImageView alloc]initWithFrame:CGRectMake(10,10,24,25)];
        payMethodImage.image = [UIImage imageNamed:image];
        [self addSubview:payMethodImage];
        
        UILabel *payLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(payMethodImage.frame)+10,
                                                                     10,
                                                                     SCREEN_WIDTH,
                                                                     24)];
        
        payLabel.text = name;
        payLabel.font = MBBFONT(15);
        payLabel.textColor = FONT_DARK;
        [self addSubview:payLabel];
        
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseBtn.frame =CGRectMake(0, 0, 20,20);
        _chooseBtn.center =CGPointMake(SCREEN_WIDTH - W(30), 22);
        [self addSubview:_chooseBtn];
        _chooseBtn.clipsToBounds = YES;
        _chooseBtn.layer.cornerRadius = 10;
        _chooseBtn.userInteractionEnabled = NO;
        [_chooseBtn setBackgroundImage:[UIImage imageNamed:@"paySelectNormal"]forState:UIControlStateNormal];
        [_chooseBtn setBackgroundImage:[UIImage imageNamed:@"paySelected"]forState:UIControlStateSelected];
        UIView *line = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                                44,
                                                                SCREEN_WIDTH,
                                                                0.5)];
        line.backgroundColor = BASE_CELL_LINE_COLOR;
        [self addSubview:line];
    }
    return self;
}

@end
