//
//  MBBPublicOrderCell.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBPublicOrderCell.h"

@interface MBBPublicOrderCell ()
    
@property (nonatomic, strong) UIImageView *   iconImage;
@property (nonatomic, strong) UIImageView *   leftImage;
@property (nonatomic, strong) UILabel     *   state;
@property (nonatomic, strong) UILabel     *   title;
@property (nonatomic, strong) UILabel     *   price;
@property (nonatomic, strong) UIView      *   line;
@property (nonatomic, strong) UILabel     *   explain;
@property (nonatomic, strong) UIView      *   bgView;

@property (nonatomic, strong) UIImageView *   delete;

@end

@implementation MBBPublicOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
  
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    /** 图片*/
    _iconImage = [[UIImageView alloc]init];
    _iconImage.image = [UIImage imageNamed:@"order_stor"];
    
    /* 状态*/
    _state = [[UILabel alloc]init];
    _state.textColor = BASE_YELLOW;
    _state.font = MBBFONT(15);
    _state.textAlignment = NSTextAlignmentRight;

    /** 图*/
    _leftImage = [[UIImageView alloc]init];
    
    /** title*/
    _title = [[UILabel alloc]init];
    _title.textColor = FONT_DARK;
    _title.font = MBBFONT(15);
    _title.textAlignment = NSTextAlignmentLeft;
    
    _line = [[UIView alloc]init];
    _line.backgroundColor = BASE_CELL_LINE_COLOR;

    /** 说明*/
    _explain = [[UILabel alloc]init];
    _explain.textColor = FONT_DARK;
    _explain.font = MBBFONT(15);

    
    /** 价格*/
    _price = [[UILabel alloc]init];
    _price.textColor = FONT_DARK;
    _price.font = MBBFONT(15);
    _price.textAlignment = NSTextAlignmentRight;
    
    /** del*/
    _delete = [[UIImageView alloc]init];
    _delete.image = [UIImage imageNamed:@"order_del"];
    
    _bgView = [[UIView alloc]init];
    _bgView.backgroundColor = BASE_VC_COLOR;
    
    NSArray * arr = @[_iconImage,_state,_explain,_line,_leftImage,_title,_price,_delete,_bgView];
    
    [self.contentView sd_addSubviews:arr];
    
    /** 布局*/
    _bgView.sd_layout
    .topSpaceToView(self.contentView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(10);

    _iconImage.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(_bgView,10)
    .widthIs(20)
    .heightIs(20);
    
    _title.sd_layout
    .leftSpaceToView(_iconImage,10)
    .topSpaceToView(_bgView,10)
    .widthIs(SCREEN_WIDTH - 20 - 20 - 60 -10)
    .heightIs(20);
    
    _state.sd_layout
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(_bgView,10)
    .widthIs(60)
    .heightIs(20);
    
    _line.sd_layout
    .topSpaceToView(_title,10)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
    
    _leftImage.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(_line,60-35)
    .widthIs(50)
    .heightIs(50);
    
    
    _price.sd_layout
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(_line,10)
    .widthIs(100)
    .heightIs(20);
    
    _explain.sd_layout
    .leftSpaceToView(_leftImage,10)
    .topSpaceToView(_line,10)
    .rightSpaceToView(_price, 5)
    .heightIs(20);

    /** 暂时隐藏*/
    _delete.hidden = YES;
    _delete.sd_layout
    .rightSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,20)
    .widthIs(20)
    .heightIs(20);
    
}
    
- (void)setModel:(MyOrderModel *)model{
    _model = model;
    [_leftImage setImageWithURL: [NSURL URLWithString:model.f_img] placeholder:[UIImage imageNamed:@"default_bag"]];
    _title.text = model.f_name;
    
    if (model.status == 500) {
        _state.text = @"去付款";
    }
    if (model.status == 110) {
        _state.text = @"立即评价";
    }
    if (model.status == 100) {
        _state.text = @"进行中";
    }
    if (model.status == 111) {
        _state.text = @"已完成";
    }
    if (model.status == 555) {
        _state.text = @"已取消";
    }
    _price.text =[NSString stringWithFormat:@"$%@",model.or_price];
}

@end
