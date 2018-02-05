//
//  CustomServiceCell.m
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "CustomServiceCell.h"
@interface CustomServiceCell ()

@property (nonatomic, strong) UIImageView *   leftImage;
@property (nonatomic, strong) UILabel *   title;
@property (nonatomic, strong) UILabel *   subTitle;
@property (nonatomic, strong) UIView  *   line  ;

@end

@implementation CustomServiceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
    
    UIImageView * leftImage = [[UIImageView alloc]init];
    leftImage.image = [UIImage imageNamed:@"mine_background.jpg"];
    [self.contentView addSubview:leftImage];
    _leftImage = leftImage;
   
    UILabel * title = [[UILabel alloc]init];
    title.text = @"~~";
    title.font = MBBFONT(15);
    title.textColor = FONT_DARK;
    [self.contentView addSubview:title];
    _title = title;
    
    UILabel * subTitle = [[UILabel alloc]init];
    subTitle.text = @"~~";
    subTitle.font = MBBFONT(12);
    subTitle.textColor = FONT_LIGHT;
    [self.contentView addSubview:subTitle];
    _subTitle = subTitle;
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self.contentView addSubview:line];
    _line  = line ;
    
    [self latOutAllSubviews];
    
}
    
- (void)latOutAllSubviews{
    
    _leftImage.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10)
    .widthIs(100)
    .heightIs(100);
    
    _title.sd_layout
    .topEqualToView(_leftImage)
    .leftSpaceToView(_leftImage,10)
    .widthIs(SCREEN_WIDTH - 100 - 20)
    .heightIs(40);
    
    _subTitle.sd_layout
    .topSpaceToView(_title,0)
    .leftSpaceToView(_leftImage,10)
    .widthIs(SCREEN_WIDTH - 100 - 20)
    .heightIs(40);
    
    _line.sd_layout
    .bottomSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
    
    _subTitle.numberOfLines = 2;
    [_subTitle setMaxNumberOfLinesToShow:2];
    
    
    _title.numberOfLines = 2;
    [_title setMaxNumberOfLinesToShow:2];
}
-(void)setModel:(CustomServiceCellModel *)model{
    _model = model;
    
    [_leftImage setImageWithURL: [NSURL URLWithString:model.ma_path] placeholder:[UIImage imageNamed:@"default_big"]];
    _title.text = model.ma_title;
    _subTitle.text = model.ma_content;
    
}
@end
