//
//  SearchResultCell.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "SearchResultCell.h"
#import "SearchListModel.h"

@interface  SearchResultCell()

@property (nonatomic, strong) UIImageView *   picture;
@property (nonatomic, strong) UILabel *   title;
@property (nonatomic, strong) UILabel *   count;
@property (nonatomic, strong) UILabel *   price;
@end

@implementation SearchResultCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}
- (void)setupViews{
    
    UIImageView * picture = [[UIImageView alloc]init];
    [self.contentView addSubview:picture];
    
    
    UILabel * title = [[UILabel alloc]init];
    title.textColor = FONT_DARK;
    title.font = MBBFONT(12);
    [self.contentView addSubview:title];
    
    
    UILabel * count = [[UILabel alloc]init];
    count.textColor = FONT_LIGHT;
    count.font = MBBFONT(12);
    [self.contentView addSubview:count];
    
    UILabel * price = [[UILabel alloc]init];
    price.textColor = [UIColor redColor];
    price.font = MBBFONT(12);
    [self.contentView addSubview:price];
    
    UIView * bgView = [[UIView alloc]init];
    bgView.backgroundColor = BASE_VC_COLOR;
    [self.contentView addSubview:bgView];
    
    
    _price = price;
    _picture = picture;
    _count = count;
    _title = title;
    
    UIView * contentView = self.contentView;
    
    bgView.sd_layout
    .topSpaceToView(contentView,0)
    .leftSpaceToView(contentView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(10);
    
    
    
    _picture.sd_layout
    .topSpaceToView(contentView,20)
    .leftSpaceToView(contentView,10)
    .heightIs(50)
    .widthIs(50);
    
    
    _title.sd_layout
    .topSpaceToView(bgView,0)
    .leftSpaceToView(_picture,10)
    .widthIs(SCREEN_WIDTH - 120 - 10 -10)
    .heightIs(40);
    _title.numberOfLines = 2;
    [_title setMaxNumberOfLinesToShow:2];
    
    _count.sd_layout
    .topSpaceToView(_title,0)
    .leftSpaceToView(_picture,10)
    .widthIs(SCREEN_WIDTH - 120 - 10 -10)
    .heightIs(40);
    
    _price.sd_layout
    .leftSpaceToView(_picture,10)
    .bottomSpaceToView(contentView,10)
    .widthIs(SCREEN_WIDTH - 120 - 10 -10)
    .heightIs(30);
}
- (void)setModel:(SearchListModel *)model{
    _model = model;
    
    [_picture setImageWithURL: [NSURL URLWithString:model.f_img] placeholder:[UIImage imageNamed:@"default_big"]];
    _title.text = model.f_name;
    _price.text = [NSString stringWithFormat:@"$ %@",model.f_price];
    _count.text = [NSString stringWithFormat:@"%ld人使用了该服务",(long)model.f_number];
}
@end
