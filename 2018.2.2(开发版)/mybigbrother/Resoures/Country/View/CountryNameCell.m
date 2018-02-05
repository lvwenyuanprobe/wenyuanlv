//
//  CountryNameCell.m
//  mybigbrother
//
//  Created by SN on 2017/6/16.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "CountryNameCell.h"
@interface CountryNameCell ()

@property (nonatomic, strong) UILabel *   countryName;
@property (nonatomic, strong) UILabel *   countryCode;
@end

@implementation CountryNameCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
    UILabel * countryName = [[UILabel alloc]init];
    countryName.textColor = FONT_LIGHT;
    countryName.font = MBBFONT(12);
    [self.contentView addSubview:countryName];
    _countryName = countryName;
    
    _countryName.sd_layout
    .topSpaceToView(self.contentView, 5)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(SCREEN_WIDTH)
    .heightIs(34);
}
- (void)setModel:(CountryNameModel *)model{
    _model = model;
    _countryName.text = [NSString stringWithFormat:@"%@  +%@",model.country,model.code];
}
@end
