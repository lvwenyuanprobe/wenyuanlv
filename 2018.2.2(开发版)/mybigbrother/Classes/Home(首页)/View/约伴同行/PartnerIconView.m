//
//  PartnerIconView.m
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "PartnerIconView.h"
@interface PartnerIconView ()

@property (nonatomic, strong) UIImageView * iconImage;
@property (nonatomic, strong) UILabel     * nickName;
@property (nonatomic, strong) UIImageView * sex ;
@property (nonatomic, strong) UIButton    * stateBtn ;
@property (nonatomic, strong) UIImageView * stateImg;
@property (nonatomic, strong) UILabel *commiteLabe;
@end

@implementation PartnerIconView

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
    nickName.font = MBBFONT(18);
    nickName.textAlignment = NSTextAlignmentCenter;
    [lowView addSubview:nickName];
    nickName.textColor = RGB(51, 51, 51);
    nickName.font = [UIFont boldSystemFontOfSize:17];
    _nickName = nickName;
    
    UIImageView * sexImage = [[UIImageView alloc]init];
    sexImage.image = [UIImage imageNamed:@"default_big"];
    [lowView addSubview:sexImage];
    _sex = sexImage;
    
    _stateImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shouye_bj"]];
    [_iconImage addSubview:_stateImg];
    _stateImg.alpha = 0.7;
    
    _commiteLabe = [[UILabel alloc] init];
    [_stateImg addSubview:_commiteLabe];
    _commiteLabe.font = [UIFont systemFontOfSize:15];
    _commiteLabe.textColor = RGB(51, 51, 51);
    
    
    [_stateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-5);
    }];
    
    [_commiteLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_stateImg);
        make.centerY.equalTo(_stateImg);
    }];
    
    
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
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);

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
    /** model内无数据,加载更多设置*/
    //    if (!model.u_id) {
    //        _iconImage.image = [UIImage imageNamed:@"home_loadmore"];
    //        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.left.mas_equalTo(10);
    //            make.top.mas_equalTo(20);
    //            make.width.height.mas_equalTo(148);
    //        }];
    //
    //        _nickName.text = @"更多";
    //        _stateBtn.hidden = YES;
    //        return;
    //    }
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.width.height.mas_equalTo(148);
    }];
    
    _stateImg.hidden = NO;
    /** */
    [_iconImage setImageWithURL: [NSURL URLWithString:model.u_img] placeholder:[UIImage imageNamed:@"default_icon"]];
    _nickName.text = model.nickname;
    if ([model.r_status isEqualToString:@"0"]) {
        _commiteLabe.text = @"未约";
        _stateImg.hidden = NO;
    }else{
        _commiteLabe.text = @"已约";
        _stateImg.hidden = NO;
    }
    
}

@end






