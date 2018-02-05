//
//  PartnerListCell.m
//  mybigbrother
//
//  Created by SN on 2017/5/8.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "PartnerListCell.h"
@interface PartnerListCell ()

@property (nonatomic, strong) UIImageView *   icon;
@property (nonatomic, strong) UILabel *    title;
@property (nonatomic, strong) UILabel *    subTitle;
@property (nonatomic, strong) UIButton *   stateBtn;
@property (nonatomic, strong) UIView  *    line;
@end

@implementation PartnerListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    UIImageView * leftImage = [[UIImageView alloc]init];
    leftImage.image = [UIImage imageNamed:@"default_icon"];
    [self.contentView addSubview:leftImage];
    leftImage.clipsToBounds = YES;
    leftImage.contentMode = UIViewContentModeScaleAspectFill;

    _icon = leftImage;
    
    UILabel * title = [[UILabel alloc]init];
    title.font = MBBFONT(15);
    title.textColor = FONT_DARK;
    [self.contentView addSubview:title];
    _title = title;
    
    UILabel * subTitle = [[UILabel alloc]init];
    subTitle.text = @"欢迎使用留学大师兄";
    subTitle.font = MBBFONT(12);
    subTitle.textColor = FONT_LIGHT;
    [self.contentView addSubview:subTitle];
    _subTitle = subTitle;
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self.contentView addSubview:line];
    _line = line ;
    
    UIButton * stateBtn = [[UIButton alloc]init];
    stateBtn.backgroundColor = MBBHEXCOLOR(0xfdb400);
    [stateBtn setTitle:@"已约" forState:UIControlStateNormal];
    [stateBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [stateBtn.titleLabel setFont:MBBFONT(9)];
    stateBtn.clipsToBounds = YES;
    stateBtn.layer.cornerRadius = 12.5;
    stateBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    stateBtn.layer.borderWidth = 2;
    [self.contentView addSubview:stateBtn];
    _stateBtn = stateBtn;

    
    [self latOutAllSubviews];
}

- (void)latOutAllSubviews{
    
    _icon.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10)
    .widthIs(41)
    .heightIs(41);
    _icon.sd_cornerRadius = @(20.5);
    
    _title.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(_icon,10)
    .widthIs(SCREEN_WIDTH - 100 - 20)
    .heightIs(22);
    
    _subTitle.sd_layout
    .topSpaceToView(_title,0)
    .leftSpaceToView(_icon,10)
    .widthIs(SCREEN_WIDTH - 100 - 20)
    .heightIs(22);
    
    _subTitle.numberOfLines = 1;
    [_subTitle setMaxNumberOfLinesToShow:1];
    
    _title.numberOfLines = 1;
    [_title setMaxNumberOfLinesToShow:1];
    
    _stateBtn.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .bottomSpaceToView(self.contentView, 10)
    .widthIs(25)
    .heightIs(25);
    
    _line.sd_layout
    .bottomSpaceToView(self.contentView, 0.5)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
}

- (void)setModel:(PartnersTogetherModel *)model{
    _model = model;
    
    [_icon setImageWithURL: [NSURL URLWithString:model.u_img] placeholder:[UIImage imageNamed:@"default_big"]];
    
    _title.text = model.nickname;
    
    _subTitle.text= model.r_desc;
    
    if ([model.r_status isEqualToString:@"0"]) {
        _stateBtn.hidden = YES;
    }else{
        _stateBtn.hidden = NO;
    }
}
@end
