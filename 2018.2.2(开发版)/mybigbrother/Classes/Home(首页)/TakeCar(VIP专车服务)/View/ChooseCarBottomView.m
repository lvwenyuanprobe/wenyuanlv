//
//  ChooseCarBottomView.m
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ChooseCarBottomView.h"
@interface ChooseCarBottomView ()
@property (nonatomic, strong) UILabel * personAverage;
@end

@implementation ChooseCarBottomView

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
    titleLabel.textColor = FONT_DARK;
    titleLabel.font = MBBFONT(15);
    [self addSubview:titleLabel];
    
    UILabel * priceLabel = [[UILabel alloc]init];
    priceLabel.textColor = FONT_LIGHT;
    priceLabel.font = MBBFONT(15);
    [self addSubview:priceLabel];
    
    UIView * line = [[UIView alloc]init];
    [self addSubview:line];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    
    UILabel * personAverage = [[UILabel alloc]init];
    personAverage.text = @"全程人均费用";
    personAverage.textColor = FONT_DARK;
    personAverage.font = MBBFONT(15);
    [self addSubview:personAverage];
    
    UILabel * averagePrice = [[UILabel alloc]init];
    averagePrice.textColor = FONT_LIGHT;
    averagePrice.font = MBBFONT(15);
    [self addSubview:averagePrice];
    
    
    /** */
    titleLabel.sd_layout
    .topSpaceToView(self, 10)
    .leftSpaceToView(self, 10)
    .widthIs(SCREEN_WIDTH - 10)
    .heightIs(24);
    
    priceLabel.sd_layout
    .topSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .widthIs(SCREEN_WIDTH - 10)
    .heightIs(24);
    priceLabel.textAlignment = NSTextAlignmentRight;
    
    
    line.sd_layout
    .topSpaceToView(self, 43)
    .leftSpaceToView(self, 10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(0.5);

    /** */
    personAverage.sd_layout
    .topSpaceToView(self, 54)
    .leftSpaceToView(self, 10)
    .widthIs(SCREEN_WIDTH - 10)
    .heightIs(24);
    
    averagePrice.sd_layout
    .topSpaceToView(self, 54)
    .rightSpaceToView(self, 10)
    .widthIs(SCREEN_WIDTH - 10)
    .heightIs(24);
    averagePrice.textAlignment = NSTextAlignmentRight;

    _titleLabel = titleLabel;
    
    _price = priceLabel;
    _averagePrice = averagePrice;
    


}
@end
