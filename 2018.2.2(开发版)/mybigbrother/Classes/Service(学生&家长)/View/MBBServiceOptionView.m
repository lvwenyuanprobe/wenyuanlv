//
//  MBBServiceOptionView.m
//  mybigbrother
//
//  Created by SN on 2017/4/1.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBServiceOptionView.h"
#import "ServicesModel.h"

@interface MBBServiceOptionView()
@property(nonatomic, strong)UIImageView * iconImage;
@property (nonatomic, strong) UILabel * titleLbel;
@end

@implementation MBBServiceOptionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setupViews{
    UIImageView * iconImage = [[UIImageView alloc]init];
    _iconImage = iconImage;
    [self addSubview:iconImage];
    
    
    UILabel * title = [[UILabel alloc]init];
    title.textColor = [UIColor whiteColor];
    
    title.font = MBBFONT(15);
    title.textColor = RGB(102, 102, 102);
    title.textAlignment = NSTextAlignmentCenter;
    _titleLbel = title;
    [self addSubview:_titleLbel];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(26);
        make.centerX.equalTo(self);
        make.top.mas_equalTo(20);
    }];
    
    [_titleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_iconImage);
        make.top.equalTo(_iconImage.mas_bottom).offset(15);
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
    
}
- (void)tap{
    if ([self.delegate respondsToSelector:@selector(showServiceDetail:)]) {
        [self.delegate showServiceDetail:self];
    }
}
-(void)setModel:(ServicesModel *)model{
    _model = model;
    
    [_iconImage setImageWithURL: [NSURL URLWithString:model.f_img] placeholder:[UIImage imageNamed:@"default_big"]];
    _titleLbel.text = model.f_name;
    
}
@end
