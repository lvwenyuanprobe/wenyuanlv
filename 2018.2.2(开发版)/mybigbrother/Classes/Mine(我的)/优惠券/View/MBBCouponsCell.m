//
//  MBBCouponsCell.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBCouponsCell.h"


@interface  MBBCouponsCell()
@property (nonatomic, strong) UIImageView *   couponImage;
@end
@implementation MBBCouponsCell
    
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
    }
    return self;
}
    
- (void)setupUI{
    
    /** 图片*/
    _couponImage = [[UIImageView alloc]init];
    _couponImage.backgroundColor = [UIColor greenColor];

    NSArray * arr = @[_couponImage];
    
    [self.contentView sd_addSubviews:arr];
    /** 布局*/
    _couponImage.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(10, 10, 10, 10));
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
