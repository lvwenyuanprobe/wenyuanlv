//
//  WYEliteBrotherCell.m
//  mybigbrother
//
//  Created by Loren on 2018/1/5.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYEliteBrotherCell.h"

@implementation WYEliteBrotherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{


    UIView *botView = [[UIView alloc] init];
    [self addSubview:botView];
    botView.backgroundColor = [UIColor whiteColor];
    [botView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    
    // 头像
    self.iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg"]];
    [botView addSubview:self.iconImgView];
    self.iconImgView.contentMode=UIViewContentModeScaleAspectFill;
    self.iconImgView.clipsToBounds=YES;
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.width.height.mas_equalTo(70);
    }];
    
    // 兼职名称
    self.partTimeName = [[UILabel alloc] init];
    [botView addSubview:self.partTimeName];
    self.partTimeName.text = @"电商运营助理";
    self.partTimeName.textColor = [UIColor colorWithHexString:@"#282828"];
    self.partTimeName.font = [UIFont  systemFontOfSize:16.0f];
    self.partTimeName.font = [UIFont boldSystemFontOfSize:16.0f];
    [self.partTimeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImgView);
        make.left.equalTo(self.iconImgView.mas_right).offset(10);
    }];
    
    // 校标
    self.universityTipImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sx_xiao"]];
    [botView addSubview:self.universityTipImg];
    [self.universityTipImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.partTimeName);
        make.centerY.equalTo(self.iconImgView);
    }];
    
    // 大学名称
    self.uiniversityName = [[UILabel alloc] init];
    [botView addSubview:self.uiniversityName];
    self.uiniversityName.text = @"斯坦福大学";
    self.uiniversityName.font = [UIFont systemFontOfSize:14];
    self.uiniversityName.textColor = [UIColor colorWithHexString:@"#999999"];
    [self.uiniversityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.universityTipImg);
        make.left.equalTo(self.universityTipImg.mas_right).offset(5);
    }];
    
    // 专业标志
    self.professionalImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sx_zhuan"]];
    [botView addSubview:self.professionalImgView];
    [self.professionalImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.universityTipImg);
        make.left.equalTo(self.uiniversityName.mas_right).offset(10);
    }];
    
    // 专业名称
    self.professinalName = [[UILabel alloc] init];
    [botView addSubview:self.professinalName];
    self.professinalName.font = [UIFont systemFontOfSize:14];
    self.professinalName.textColor = [UIColor colorWithHexString:@"#999999"];
    self.professinalName.text = @"市场营销";
    [self.professinalName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.universityTipImg);
        make.left.equalTo(self.professionalImgView.mas_right).offset(5);
    }];
    
    UIView *weekView = [[UIView alloc] init];
    [botView addSubview:weekView];
    weekView.backgroundColor = [UIColor colorWithHexString:@"#f3f3f3"];
    weekView.layer.borderWidth = 0.5f;
    weekView.layer.borderColor = [UIColor colorWithHexString:@"#cfcfcf"].CGColor;
    [weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16.5);
        make.width.mas_equalTo(45);
        make.bottom.equalTo(_iconImgView.mas_bottom);
        make.left.equalTo(_universityTipImg);
    }];
    
    UIView *timeView = [[UIView alloc] init];
    [botView addSubview:timeView];
    timeView.layer.borderColor = [UIColor colorWithHexString:@"#cfcfcf"].CGColor;
    timeView.layer.borderWidth = 0.5f;
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16.5f);
        make.width.mas_equalTo(83);
        make.centerY.equalTo(weekView);
        make.left.equalTo(weekView.mas_right);
    }];
    
    UILabel *fengeLabel = [[UILabel alloc] init];
    [timeView addSubview:fengeLabel];
    fengeLabel.text = @"~";
    fengeLabel.font = [UIFont systemFontOfSize:10.0f];
    fengeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    [fengeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(timeView);
    }];
    
    // 星期几
    _weekLabel = [[UILabel alloc] init];
    [weekView addSubview:_weekLabel];
    _weekLabel.text = @"周日";
    _weekLabel.font = [UIFont systemFontOfSize:10.0f];
    _weekLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weekView);
    }];
    
    // 起始时间
    _starTime = [[UILabel alloc] init];
    [timeView addSubview:_starTime];
    _starTime.text = @"9:00";
    _starTime.font = [UIFont systemFontOfSize:10.0f];
    _starTime.textColor = [UIColor colorWithHexString:@"#999999"];
    [_starTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeView);
        make.right.equalTo(fengeLabel.mas_left).offset(-5);
    }];
    
    // 结束时间
    _endTime = [[UILabel alloc] init];
    [timeView addSubview:_endTime];
    _endTime.text = @"18:00";
    _endTime.font = [UIFont systemFontOfSize:10.0f];
    _endTime.textColor = [UIColor colorWithHexString:@"#999999"];
    [_endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeView);
        make.left.equalTo(fengeLabel.mas_right).offset(5);
    }];
    
    _everyDayLabel = [[UILabel alloc] init];
    [botView addSubview:_everyDayLabel];
    _everyDayLabel.font = [UIFont systemFontOfSize:17.0f];
    _everyDayLabel.textColor = [UIColor colorWithHexString:@"#fd2828"];
    _everyDayLabel.text = @"/ 时";
    [_everyDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_partTimeName);
        make.right.mas_equalTo(-15);
    }];
    
    // 价钱
    _priceLabel = [[UILabel alloc] init];
    [botView addSubview:_priceLabel];
    _priceLabel.font = [UIFont systemFontOfSize:17.0f];
    _priceLabel.textColor = [UIColor colorWithHexString:@"#fd2828"];
    _priceLabel.text = @"$35";
//    _priceLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_partTimeName);
        make.right.equalTo(_everyDayLabel.mas_left).offset(-5);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


























