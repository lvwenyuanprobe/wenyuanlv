//
//  CustomServiceDetailBottomView.m
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "CustomServiceDetailBottomView.h"
@interface CustomServiceDetailBottomView ()
@property (nonatomic, strong) UILabel *   price;
@property (nonatomic, strong) UIButton *  rightBtn;
@end

@implementation CustomServiceDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame rightTitle:(NSString *)rightStr{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUIWithStr:rightStr];
    }
    
    return self;
}
- (void)setUpUIWithStr:(NSString *)rightStr{
    
    self.backgroundColor =  [UIColor whiteColor];
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self addSubview:line];
    
    line.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
    
    UILabel * price = [[UILabel alloc]init];
    price.textAlignment = NSTextAlignmentCenter;
    price.font = MBBFONT(15);
    price.textColor = BASE_YELLOW;
    [self addSubview:price];
    _price = price;
    
    UIButton * makeOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    makeOrderBtn.titleLabel.textColor = [UIColor whiteColor];
    [makeOrderBtn setBackgroundImage:[UIImage imageWithColor:BASE_YELLOW] forState:UIControlStateNormal];
    [makeOrderBtn setBackgroundImage:[UIImage imageWithColor:BASE_YELLOW] forState:UIControlStateSelected];
    [makeOrderBtn setTitle:rightStr forState:UIControlStateNormal];
    [makeOrderBtn addTarget:self action:@selector(makeOrderClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:makeOrderBtn];
    
    _rightBtn = makeOrderBtn;
    
    _price.sd_layout
    .topSpaceToView(self,1)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH*2/3)
    .heightIs(43);
    
    _rightBtn.sd_layout
    .topSpaceToView(self,1)
    .leftSpaceToView(_price,0)
    .widthIs(SCREEN_WIDTH/3)
    .heightIs(43);


}
-(void)setServicePrice:(NSString *)servicePrice{
    _servicePrice = servicePrice;
    NSRange range = [servicePrice rangeOfString:@":"];
    _price.attributedText = [MyControl originalStr:servicePrice position:servicePrice.length - range.location-1 color:FONT_DARK];
    
}
- (void)makeOrderClicked{
    if ([self.delegate respondsToSelector:@selector(rihgtButtonClicked)]) {
        [self.delegate rihgtButtonClicked];
    }
}
@end
