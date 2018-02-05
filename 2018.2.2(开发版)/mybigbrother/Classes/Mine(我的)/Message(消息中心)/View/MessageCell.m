//
//  MessageCell.m
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MessageCell.h"
@interface MessageCell ()

@property (nonatomic, strong) UIImageView *  icon;
@property (nonatomic, strong) UILabel *   title;
@property (nonatomic, strong) UILabel *   subTitle;
@property (nonatomic, strong) UIView *   line;

@end

@implementation MessageCell

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
    
    _icon = leftImage;
    
    UILabel * title = [[UILabel alloc]init];
    title.text = @"系统消息";
    title.font = MBBFONT(16);
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
    
    
    [self latOutAllSubviews];
}
- (void)latOutAllSubviews{
    
    _icon.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10)
    .widthIs(44)
    .heightIs(44);
    _icon.sd_cornerRadius = @(22);
    
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
    
    _subTitle.numberOfLines = 2;
    [_subTitle setMaxNumberOfLinesToShow:2];
    
    _title.numberOfLines = 2;
    [_title setMaxNumberOfLinesToShow:2];
    
    _line.sd_layout
    .bottomSpaceToView(self.contentView, 0.5)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
}
- (void)setModel:(MessageModel *)model{
    
    _subTitle.text = model.add_time;
    _title.text = model.content;
    
}
@end
