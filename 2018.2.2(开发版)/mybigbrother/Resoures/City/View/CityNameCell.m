//
//  CityNameCell.m
//  mybigbrother
//
//  Created by SN on 2017/4/20.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "CityNameCell.h"
@interface CityNameCell ()

@property (nonatomic, strong) UILabel * name;
@end


@implementation CityNameCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /** 解决开启字母排序后cell会向左缩进*/
        self.contentView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupViews];

    }
    return self;
}
- (void)setupViews{
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"热门搜索";
    titleLabel.font = MBBFONT(15);
    titleLabel.textColor = BASE_YELLOW;
    [self.contentView addSubview:titleLabel];
    
    _name = titleLabel;
    
    _name.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(24);
    
}
- (void)setModel:(CityModel *)model{
    
    _name.text = [NSString stringWithFormat:@"%@  %@",model.c_name,model.c_named?model.c_named:@""];
    
}
@end
