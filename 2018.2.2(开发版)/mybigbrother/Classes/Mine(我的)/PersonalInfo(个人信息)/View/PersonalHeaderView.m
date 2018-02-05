//
//  PersonalHeaderView.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "PersonalHeaderView.h"
@interface PersonalHeaderView ()
/** 昵称*/
@property (nonatomic, strong) UILabel *   nickName;

@end

@implementation PersonalHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}

- (void)setUpUI{
    
    self.backgroundColor = BASE_VC_COLOR;
    UIView *bgView  = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    bgView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(5, 0, 5, 0));
    
    
    UIImageView * icon = [[UIImageView alloc]init];
    icon.image = [UIImage imageNamed:@"default_icon"];
    icon.contentMode = UIViewContentModeScaleAspectFill;
    [bgView addSubview:icon];
    _icon = icon;
    
    UILabel * nickName = [[UILabel alloc]init];
    nickName.font = MBBFONT(15);
    nickName.textColor = FONT_DARK;
    [bgView addSubview:nickName];
    nickName.text = @"头像";
    _nickName = nickName;
    
    _nickName.sd_layout
    .topSpaceToView(bgView,25)
    .leftSpaceToView(bgView,10)
    .widthIs(SCREEN_WIDTH - 10 - 40 -10)
    .heightIs(30);
    
    _icon.sd_layout
    .topSpaceToView(bgView,10)
    .rightSpaceToView(bgView,10)
    .widthIs(60)
    .heightIs(60);
    
    _icon.clipsToBounds = YES;
    _icon.layer.cornerRadius = 30;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTap)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}
- (void)headerTap{
    if ([self.delegate respondsToSelector:@selector(PersonalChangeIconImage)]) {
        [self.delegate PersonalChangeIconImage];
    }

}
@end
