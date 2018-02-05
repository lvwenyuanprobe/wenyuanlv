//
//  ConfigCell.m
//  mybigbrother
//
//  Created by SN on 2017/4/24.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ConfigCell.h"

@implementation ConfigCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
   
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = RGB(116, 116, 116);
    titleLabel.font = MBBFONT(15);
    [self.contentView addSubview:titleLabel];
    
    titleLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 20)
    .widthIs(SCREEN_WIDTH/2 - 10)
    .heightIs(24);
    
    _configLabel = titleLabel;

}
@end
