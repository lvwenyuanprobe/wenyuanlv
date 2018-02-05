//
//  TacticsCell.m
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "TacticsCell.h"

@interface  TacticsCell()

@property (nonatomic, strong) UIImageView *   leftImage;
@property (nonatomic, strong) UILabel *       title;
@property (nonatomic, strong) UILabel *       content;


@end

@implementation TacticsCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    /** 图片*/
    _leftImage = [[UIImageView alloc]init];
    
    /** 标题*/
    UILabel * title = [[UILabel alloc]init];
    title.font = MBBFONT(17);
    title.numberOfLines = 0;
    title.textColor = [UIColor blackColor];
    title.alpha = 0.95;
    _title = title;
    
    /** 内容*/
    UILabel * content = [[UILabel alloc]init];
    content.font = MBBFONT(12);
    _content = content;
    content.textColor = RGB(150, 150, 150);
    
    _title.text = @"";
    _content.text = @"";
    

    NSArray * arr = @[_leftImage,_title,_content];
    [self.contentView sd_addSubviews:arr];
    /** 布局*/
    [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.width.mas_equalTo(180);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImage.mas_right).offset(10);
        make.top.equalTo(_leftImage.mas_top);
        make.right.mas_equalTo(-15);
    }];

    _content.sd_layout
    .topSpaceToView(_title,10)
    .leftSpaceToView(_leftImage,10)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(60);
    _content.numberOfLines = 0;
    [_content setMaxNumberOfLinesToShow:0];

    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self.contentView addSubview:line];
    
    line.sd_layout
    .bottomSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
    
}
- (void)setModel:(TacticsShareModel *)model{
    _model = model;
    [_leftImage setImageWithURL: [NSURL URLWithString:model.ra_img] placeholder:[UIImage imageNamed:@"default_big"]];
    _title.text = model.ra_title;
    _content.text = model.r_content;
    
}
@end
