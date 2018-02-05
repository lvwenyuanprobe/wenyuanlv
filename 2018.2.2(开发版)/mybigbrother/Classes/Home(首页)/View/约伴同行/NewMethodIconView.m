//
//  NewMethodIconView.m
//  mybigbrother
//
//  Created by apple on 2017/12/11.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "NewMethodIconView.h"

@interface NewMethodIconView ()

@property (nonatomic, strong) UIImageView * iconImage;
@property (nonatomic, strong) UILabel     * nickName;
@property (nonatomic, strong) UIImageView * sex ;
@property (nonatomic, strong) UIButton    * stateBtn ;
@end

@implementation NewMethodIconView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setupViews];
    }
    
    return self;
}
- (void)setupViews{
    self.backgroundColor = [UIColor whiteColor];
    UIView * lowView = self;
    
    UIImageView * iconImage = [[UIImageView alloc]init];
    iconImage.image = [UIImage imageNamed:@"default_big"];
    iconImage.clipsToBounds = YES;
    iconImage.contentMode = UIViewContentModeScaleAspectFill;
    [lowView addSubview:iconImage];
    
    _iconImage = iconImage;
    
    UILabel * nickName = [[UILabel alloc]init];
    nickName.font = MBBFONT(14);
    nickName.textAlignment = NSTextAlignmentCenter;
    [lowView addSubview:nickName];
    nickName.textColor = [UIColor blackColor];
    nickName.alpha = 0.7;
//    nickName.numberOfLines = 2;
    nickName.textAlignment = NSTextAlignmentLeft;
    _nickName = nickName;
    
    UIImageView * sexImage = [[UIImageView alloc]init];
    sexImage.image = [UIImage imageNamed:@"default_big"];
    [lowView addSubview:sexImage];
    _sex = sexImage;
    
    
    [self lalyOutAllSubviews];
}

-(void)lalyOutAllSubviews{
    /** 翻转之后,布局坐标注意宽度*/
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(0);
        make.width.height.mas_equalTo(148);
    }];
    /** 宽度和cell的高度保持一致*/
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).with.offset(0);
//        make.right.equalTo(self.mas_right).with.offset(0);
        make.left.equalTo(_iconImage.mas_left);
        
        make.centerX.equalTo(_iconImage);
        make.top.equalTo(_iconImage.mas_bottom).offset(10);
        
    }];
}
- (void)setModel1:(TacticsShareModel *)model{
    _model1 = model;
    [_iconImage setImageWithURL: [NSURL URLWithString:_model1.ra_img] placeholder:[UIImage imageNamed:@"default_big"]];
    _nickName.text = _model1.ra_title;
    //    _content.text = _model1.r_content;
    
}
- (void)setModel:(PartnersTogetherModel *)model{
    _model = model;
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.width.height.mas_equalTo(148);
    }];
    
    /** */
    [_iconImage setImageWithURL: [NSURL URLWithString:model.u_img] placeholder:[UIImage imageNamed:@"default_icon"]];
    _nickName.text = model.nickname;
    
}

@end


