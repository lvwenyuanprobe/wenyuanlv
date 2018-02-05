//
//  WYTableViewCell.m
//  mybigbrother
//
//  Created by qiu on 9/1/18.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYTableViewCell.h"
@interface WYTableViewCell ()
{
    DWQNumberChangedBlock numberAddBlock;
}
@end
@implementation WYTableViewCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
//}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUI];
    }
    return self;
}
-(void)setUI{
    _titleLab = [[UILabel alloc] init];
    [_titleLab setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightThin]];
    [self.contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(-55);
        make.height.mas_equalTo(20);
    }];
    
    _titleLab.textColor = [UIColor blackColor];
    _titleLab.text = @"增加行程";
    [self.contentView addSubview:_titleLab];
    
    _subtractionButton = [[UIButton alloc] init];
    [_subtractionButton setBackgroundImage:[UIImage imageNamed:@"gj_jh"] forState:UIControlStateNormal];
    [self.contentView addSubview:_subtractionButton];
    [_subtractionButton addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_subtractionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
}
- (void)addBtnClick:(UIButton*)button {
    
    if (numberAddBlock) {
        numberAddBlock(0);
    }
}
- (void)numberAddWithBlock:(DWQNumberChangedBlock)block {
    numberAddBlock = block;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

