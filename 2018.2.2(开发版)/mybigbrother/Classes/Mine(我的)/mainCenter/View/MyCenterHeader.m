//
//  MyCenterHeader.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MyCenterHeader.h"

@interface MyCenterHeader ()
    
@property(nonatomic,strong)UIImageView * iconImage; // 原有的在蒙版下面那个头像
@property(nonatomic,strong)UIImageView *botIconImg; // 蒙版
@property(nonatomic,strong)UIImageView *headImg; // 最上边显示的那个头像
@property(nonatomic,strong)UILabel * nickName;
@property(nonatomic,strong)UILabel * signLabel;

    
@end

@implementation MyCenterHeader
    
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
        
        /** 登陆成功刷新数据*/
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHeaderView) name:MBB_LOGIN_IN object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHeaderView) name:MBB_LOGIN_OUT object:nil];
    }
    
    return self;
}
- (void)setUpUI{
    
    _iconImage = [[UIImageView alloc]init];
    _iconImage.image =[UIImage imageNamed:@"default_icon"];
    _iconImage.contentMode = UIViewContentModeScaleAspectFill;
    _iconImage.layer.masksToBounds = YES;
     [self addSubview:_iconImage];

    _botIconImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wd_bj"]];
    [self addSubview:_botIconImg];
    
    _headImg = [[UIImageView alloc]init];
    _headImg.image =[UIImage imageNamed:@"default_icon"];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.layer.cornerRadius = 43.8;
    _headImg.layer.masksToBounds = YES;
    [_botIconImg addSubview:_headImg];
    
    _nickName  = [[UILabel alloc]init];
    _nickName.textAlignment = NSTextAlignmentCenter;
    _nickName.text = @"游客请登录";
    _nickName.font = MBBFONT(20);
    _nickName.textColor = [UIColor whiteColor];
    [_nickName setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    
    _signLabel = [[UILabel alloc]init];
    _signLabel.textAlignment = NSTextAlignmentCenter;
    _signLabel.text = @"一起走吧！";
    _signLabel.font = MBBFONT(15);
    _signLabel.textColor = [UIColor whiteColor];
    _signLabel.alpha = 0.75;
    
    [_botIconImg addSubview:_nickName];
    [_botIconImg addSubview:_signLabel];
    
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    if (model.token) {
        [_iconImage setImageWithURL:[NSURL URLWithString:model.user.icon] placeholder:[UIImage imageNamed:@"default_icon"]]; //
        NSLog(@"666%@,777\n%@",_iconImage,model.user.icon);
        [_headImg setImageWithURL:[NSURL URLWithString:model.user.icon] placeholder:[UIImage imageNamed:@"default_icon"]]; // NULL
        NSLog(@"555%@,777\n%@",_headImg,model.user.icon);
        _nickName.text = model.user.nickName?model.user.nickName:@"游客请登录";
        _signLabel.text = model.user.autograph?model.user.autograph:@"一起走吧！";
    }
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(240);
        make.width.mas_equalTo(kScreenWidth);
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    [_botIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(240);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(90);
        make.centerX.equalTo(_botIconImg);
        make.top.mas_equalTo(64);
    }];
    
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headImg);
        make.top.equalTo(_headImg.mas_bottom).offset(10);
    }];
    
    [_signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headImg);
        make.top.equalTo(_nickName.mas_bottom).offset(10);
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}
- (void)tap{
    
    if ([self.delegate respondsToSelector:@selector(MyCenterIconTap)]) {
        [self.delegate MyCenterIconTap];
    }
}
- (void)refreshHeaderView{
     MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    [_iconImage setImageWithURL: [NSURL URLWithString:model.user.icon] placeholder:[UIImage imageNamed:@"default_icon"]];
     [_headImg setImageWithURL: [NSURL URLWithString:model.user.icon] placeholder:[UIImage imageNamed:@"default_icon"]];
    _nickName.text = model.user.nickName?model.user.nickName:@"游客请登录";
    _signLabel.text = model.user.autograph?model.user.autograph:@"一起走吧！";
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
