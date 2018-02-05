//
//  PersonalInfoCell.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "PersonalInfoCell.h"
@interface  PersonalInfoCell()


@end

@implementation PersonalInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
    UILabel * left = [[UILabel alloc]init];
    left.textColor = FONT_DARK;
    left.font = MBBFONT(15);
    [self.contentView addSubview:left];

    _left =left;
    
    UILabel * right = [[UILabel alloc]init];
    right.textColor = FONT_LIGHT;
    right.font = MBBFONT(15);
    [self.contentView addSubview:right];
    
    right.textAlignment = NSTextAlignmentRight;
    _right =right;
    
    
    _left.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10)
    .widthIs(SCREEN_WIDTH/4)
    .heightIs(30);
    
    
    _right.sd_layout
    .topSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .widthIs(SCREEN_WIDTH*3/4)
    .heightIs(30);
}
@end
