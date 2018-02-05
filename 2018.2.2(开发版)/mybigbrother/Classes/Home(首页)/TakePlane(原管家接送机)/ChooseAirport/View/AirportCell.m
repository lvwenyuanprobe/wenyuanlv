//
//  AirportCell.m
//  mybigbrother
//
//  Created by SN on 2017/4/17.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "AirportCell.h"
@interface AirportCell ()
@property (nonatomic, strong) UILabel *  name;
@property (nonatomic, strong) UILabel *  cityName;
@property (nonatomic, strong) UILabel *  EnName;

@end

@implementation AirportCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = FONT_LIGHT;
    titleLabel.font = MBBFONT(15);
    [self.contentView addSubview:titleLabel];

    _name = titleLabel;
    
    UILabel * cityName = [[UILabel alloc]init];
    cityName.textColor = FONT_LIGHT;
    cityName.font = MBBFONT(15);
    [self.contentView addSubview:cityName];
    
    _cityName = cityName;
    
    UILabel * EnNameLabel = [[UILabel alloc]init];
    EnNameLabel.textColor = FONT_LIGHT;
    EnNameLabel.font = MBBFONT(15);
    [self.contentView addSubview:EnNameLabel];
    
    _EnName = EnNameLabel;
    
    
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self.contentView addSubview:line];
    
    line.sd_layout
    .bottomSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 20)
    .widthIs(SCREEN_WIDTH*2/3 - 40)
    .heightIs(0.5);
}
- (void)setModel:(AirportModel *)model{
    _model = model;
    
    _EnName.hidden = NO;

    if (!model.a_named) {
        _name.sd_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 20)
        .widthIs(SCREEN_WIDTH*2/3 - 30)
        .heightIs(44);
    }else{
        _name.sd_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 20)
        .widthIs(SCREEN_WIDTH*2/3 - 20)
        .heightIs(20);
        
        _cityName.sd_layout
        .topSpaceToView(_name, 10)
        .leftSpaceToView(self.contentView, 20)
        .widthIs(SCREEN_WIDTH*2/3 - 20)
        .heightIs(20);
        
        _EnName.sd_layout
        .topSpaceToView(_cityName, 5)
        .leftSpaceToView(self.contentView, 20)
        .widthIs(SCREEN_WIDTH*2/3 - 20)
        .heightIs(20);
        _cityName.font = MBBFONT(12);
        _EnName.font = MBBFONT(12);

    }
    
    _name.text = model.c_name;
    _cityName.text = model.a_name;
    _EnName.text = model.a_named;
}
- (void)setSchoolModel:(SchoolsModel *)schoolModel{
    _schoolModel = schoolModel;
    _name.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 20)
    .widthIs(SCREEN_WIDTH*2/3 - 20)
    .heightIs(20);
    
    
    _EnName.sd_layout
    .topSpaceToView(_name, 5)
    .leftSpaceToView(self.contentView, 20)
    .widthIs(SCREEN_WIDTH*2/3 - 20)
    .heightIs(20);
    
    _EnName.hidden = NO;

    _name.text = schoolModel.s_name;
    _EnName.text = schoolModel.s_named;

}
@end
