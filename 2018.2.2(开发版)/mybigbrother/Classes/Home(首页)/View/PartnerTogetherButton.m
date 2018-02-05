//
//  PartnerTogetherButton.m
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "PartnerTogetherButton.h"
@interface PartnerTogetherButton ()

@property (nonatomic, strong) UIImageView *   leftImage;
@property (nonatomic, strong) UIImageView *   rightImage;
@property(nonatomic, strong)  UILabel * invitLabel;
    
@end

@implementation PartnerTogetherButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    UIImageView * leftImage = [[UIImageView alloc]init];
    leftImage.image = [UIImage imageNamed:@"home_picture"];
    [self addSubview:leftImage];
    
    _leftImage = leftImage;
    
//    UIImageView * rightImage = [[UIImageView alloc]init];
//    rightImage.image = [UIImage imageNamed:@"home_arrow"];
//    [self addSubview:rightImage];
//    _rightImage = rightImage;
//    
//    UILabel * invitLabel = [[UILabel alloc]init];
//    invitLabel.textAlignment = NSTextAlignmentCenter;
//    invitLabel.textColor = FONT_DARK;
//    invitLabel.font = MBBFONT(16);
//    invitLabel.text = @"邀请搭伴同行";
//    _invitLabel = invitLabel;
//    [self addSubview:_invitLabel];
    
    [self layOutAllSubviews];
}
- (void)layOutAllSubviews{
    
//    _leftImage.sd_layout
//    .topSpaceToView(self,-10)
//    .leftSpaceToView(self,10)
//    .widthIs(100)
//    .heightIs(70);
    
//    _invitLabel.sd_layout
//    .topSpaceToView(self,0)
//    .leftSpaceToView(self,0)
//    .widthIs(SCREEN_WIDTH)
//    .heightIs(70);
//
//    _rightImage.sd_layout
//    .topSpaceToView(self,25)
//    .rightSpaceToView(self,10)
//    .widthIs(10)
//    .heightIs(20);
    
    _leftImage.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
}
@end
