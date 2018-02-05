//
//  GetPartnerDetailHeader.m
//  mybigbrother
//
//  Created by SN on 2017/4/1.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "GetPartnerDetailHeader.h"
#import "MBBUserFavShowView.h"
#import "MBBPersonalInfoShowController.h"
@interface  GetPartnerDetailHeader()<MBBUserFavShowViewDelegate>
@property(nonatomic,strong)UIView * bgImage;
/** 头像*/
@property(nonatomic,strong)UIImageView * iconImage;
/** 昵称*/
@property(nonatomic,strong)UILabel * nickName;

/** 点赞显示*/
@property (nonatomic, strong) MBBUserFavShowView * usersFav;

@property (nonatomic, strong) UIButton * stateBtn;

@end

@implementation GetPartnerDetailHeader
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}

- (void)setUpUI{
    
    
    UIImageView * iconImage = [[UIImageView alloc]init];
    iconImage.contentMode = UIViewContentModeScaleAspectFill;
    iconImage.clipsToBounds = YES;
    iconImage.layer.cornerRadius = 28;
    iconImage.layer.masksToBounds = YES;

    UIView *bgImage = [[UIView alloc] init];
    bgImage.backgroundColor = [UIColor whiteColor];

    
   UILabel * nickName  = [[UILabel alloc]init];
    nickName.textAlignment = NSTextAlignmentCenter;
    nickName.font = MBBFONT(16);
    nickName.textColor = [UIColor blackColor];
    
    UIView *lineView = [[UIView alloc] init];
    [bgImage addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#eae9e9"];
    
    
    [self addSubview:bgImage];
    UIButton * sateBtn = [[UIButton alloc]init];
    sateBtn.backgroundColor = [UIColor colorWithHexString:@"#e5a2c1"];
    [sateBtn setTitle:@"已约" forState:UIControlStateNormal];
    [sateBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [sateBtn.titleLabel setFont:MBBFONT(11)];
    sateBtn.clipsToBounds = YES;
    sateBtn.layer.cornerRadius = 3;
    sateBtn.alpha = 0.7;

    [bgImage addSubview:iconImage];
    [bgImage addSubview:nickName];
    [bgImage addSubview:sateBtn];

    _bgImage = bgImage;
    _iconImage = iconImage;
    _nickName = nickName;
    _stateBtn = sateBtn;

    
    _bgImage.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(98);

    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-20);
        make.width.height.mas_equalTo(60);
    }];
    
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconImage);
        make.left.mas_equalTo(20);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.left.right.mas_equalTo(0);
        make.top.equalTo(_iconImage.mas_bottom).offset(15);
    }];
    
    _stateBtn.sd_layout
    .bottomEqualToView(_iconImage).offset(-8)
    .leftSpaceToView(_iconImage, -30)
    .widthIs(34)
    .heightIs(17);
    
    UITapGestureRecognizer * iconTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTapToPersonalInfo)];
    iconImage.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    bgImage.userInteractionEnabled = YES;
    [iconImage addGestureRecognizer:iconTap];
    
    MBBUserFavShowView * usersFav = [[MBBUserFavShowView  alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 34)];
    [self addSubview:usersFav];
    usersFav.delegate = self;
    _usersFav = usersFav;
    
}
#pragma mark - MBBUserFavShowViewDelegate
- (void)clickedNicknameWith:(MBBUserFavModel *)favUsermodel{
    MBBPersonalInfoShowController * personInfoShow = [[MBBPersonalInfoShowController alloc]init];
    personInfoShow.u_id =favUsermodel.u_id;
    [self.KNavgationController pushViewController:personInfoShow animated:YES];
}

- (void)iconTapToPersonalInfo{
    MBBPersonalInfoShowController * personInfoShow = [[MBBPersonalInfoShowController alloc]init];
    personInfoShow.u_id = self.model.u_id;
    [self.KNavgationController pushViewController:personInfoShow animated:YES];

}
-(void)setModel:(PartnersTogetherModel *)model{
    _model =model;
    
    if ([model.r_status isEqualToString:@"0"]) {
        [_stateBtn setTitle:@"未约" forState:UIControlStateNormal];
        _stateBtn.hidden = NO;
    }else{
        [_stateBtn setTitle:@"已约" forState:UIControlStateNormal];
        _stateBtn.hidden = NO;
    }
    
    [_iconImage setImageWithURL: [NSURL URLWithString:model.u_img] placeholder:[UIImage imageNamed:@"default_icon"]];
//    [_bgImage setImage:[UIImage imageNamed:@"detail_default"]];
    _nickName.text = model.u_nickname;
    
    NSArray * images = @[@"就读学校:",
                         @"航班:",
                         @"出发时间:",
                         @"目的地:",
                         @"寻找:",
                         @"发布时间:",
                         @"约伴简介:"];
    NSString * astrictSex  = [NSString string];
    if (model.r_astrict == 2) {
        astrictSex = @"不限性别";
    }
    if (model.r_astrict == 0) {
        astrictSex = @"仅限女生";
    }
    if (model.r_astrict == 1) {
        astrictSex = @"仅限男生";
    }

    
    NSArray * contents =@[
                          [NSString stringWithFormat:@"%@",self.model.r_school],
                          [NSString stringWithFormat:@"%@",self.model.r_flight],
                          [NSString stringWithFormat:@"%@",self.model.r_starttime?self.model.r_starttime:@""],
                          [NSString stringWithFormat:@"%@",self.model.r_arrive],
                          [NSString stringWithFormat:@"%@",astrictSex],
                          [NSString stringWithFormat:@"%@",self.model.r_time],
                          [NSString stringWithFormat:@"%@",self.model.r_desc],
                          ];
    for (int i = 0;  i < images.count; i++) {
        
        UIView * view =  [self makeBy:images[i] content:contents[i]];
        [self addSubview:view];

        UIView *botLine = [[UIView alloc] init];
        [view addSubview:botLine];
        botLine.backgroundColor = [UIColor colorWithHexString:@"#d6d6d6"];
        
        view.sd_layout
        .topSpaceToView(_bgImage,0 + i * 54)
        .leftSpaceToView(self,0)
        .widthIs(SCREEN_WIDTH)
        .heightIs(54);
        
        [botLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.equalTo(view.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
    }
    
    
    _usersFav.sd_layout
    .topSpaceToView(_bgImage,contents.count * 54)
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0);
    
    _usersFav.labelArray = [NSMutableArray arrayWithArray:model.userlist];
    
    [self setupAutoHeightWithBottomView:_usersFav bottomMargin:0];
}
- (UIView * )makeBy:(NSString * )leftImage content:(NSString *)contentStr{
    UIView * showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
//    UIImageView * left = [[UIImageView alloc]init];
//    left.image = [UIImage imageNamed:leftImage];
    UILabel * left = [[UILabel alloc]init];
    left.text = [NSString stringWithFormat:@"%@",leftImage];
    left.font = [UIFont systemFontOfSize:16.0f];
    left.textColor = [UIColor colorWithHexString:@"#050505"];
    
    UILabel * content = [[UILabel alloc]init];
    content.font = MBBFONT(16);
    content.textColor = [UIColor colorWithHexString:@"#999999"];
    content.text = contentStr;
    
    [showView addSubview:left];
    [showView addSubview:content];
    
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(showView);
        make.left.mas_equalTo(15);
    }];
    
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.equalTo(showView);
    }];

    content.sd_layout.maxHeightIs(content.font.lineHeight * 2.05);
    [content sizeToFit];
    
    return showView;
}
@end
