//
//  CarItemView.m
//  mybigbrother
//
//  Created by SN on 2017/4/11.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "CarItemView.h"

@implementation CarItemView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    UIImageView * carImage = [[UIImageView alloc]init];
    carImage.image = [UIImage imageNamed:@"mine_background.jpg"];
    [self addSubview:carImage];
    
    UILabel * carType = [[UILabel alloc]init];
    carType.text = @"紧凑5座";
    carType.textColor = FONT_DARK;
    carType.font = MBBFONT(15);
    carType.textAlignment = NSTextAlignmentCenter;
    [self addSubview:carType];

    
    UILabel * carName = [[UILabel alloc]init];
    carName.text = @"马自达CX-5";
    carName.textColor = FONT_LIGHT;
    carName.font = MBBFONT(15);
    carName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:carName];
    
    carImage.sd_layout
    .topSpaceToView(self, 10)
    .leftSpaceToView(self, 20)
    .widthIs(SCREEN_WIDTH*2/3 - 20)
    .heightIs(80);
    
    carType.sd_layout
    .topSpaceToView(carImage, 5)
    .leftSpaceToView(self, 0)
    .widthIs(SCREEN_WIDTH*2/3)
    .heightIs(20);
    
    carName.sd_layout
    .topSpaceToView(carType, 5)
    .leftSpaceToView(self, 0)
    .widthIs(SCREEN_WIDTH*2/3)
    .heightIs(20);
}
@end
