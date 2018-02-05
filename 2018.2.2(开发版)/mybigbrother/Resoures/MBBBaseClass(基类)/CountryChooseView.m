//
//  CountryChooseView.m
//  mybigbrother
//
//  Created by SN on 2017/6/16.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "CountryChooseView.h"
@interface CountryChooseView ()

@property (nonatomic, strong) UILabel * countryNumber;
@end

@implementation CountryChooseView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    UILabel * countryNumber = [[UILabel alloc]init];
    countryNumber.text = @"+86";
    countryNumber.textColor = FONT_DARK;
    countryNumber.font = MBBFONT(12);
    countryNumber.textAlignment = NSTextAlignmentCenter;
    [self addSubview:countryNumber];
    UIImageView * image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"choose_budge"];
    
    [self addSubview:image];
    
    _countryNumber = countryNumber;
    countryNumber.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    image.sd_layout
    .rightSpaceToView(self, 0)
    .bottomSpaceToView(self, 0)
    .widthIs(10)
    .heightIs(10);
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    
}
- (void)tap{
    if ([self.delegate respondsToSelector:@selector(makeChoiceCountry:)]) {
        [self.delegate makeChoiceCountry:self];
    }
}
-(void)setCountryNum:(NSString *)countryNum{
    _countryNum = countryNum;
    _countryNumber.text = countryNum;
}
@end
