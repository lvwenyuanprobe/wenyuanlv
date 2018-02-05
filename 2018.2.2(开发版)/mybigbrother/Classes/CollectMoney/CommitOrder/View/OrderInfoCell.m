//
//  OrderInfoCellView.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "OrderInfoCell.h"
@interface OrderInfoCell ()<UITextFieldDelegate>

@end

@implementation OrderInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    UILabel * left = [[UILabel alloc]init];
    left.textColor = FONT_DARK;
    left.font = MBBFONT(14);
    [self.contentView addSubview:left];
    
    _leftLabel=left;
    
    UITextField * right = [[UITextField alloc]init];
    right.textColor = FONT_LIGHT;
    right.font = MBBFONT(14);
    [self.contentView addSubview:right];
    right.textAlignment = NSTextAlignmentRight;
    right.delegate =self;
    
    _rightField =right;
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self.contentView addSubview:line];
    _line = line;
    
    
    _leftLabel.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10)
    .widthIs(SCREEN_WIDTH -20)
    .heightIs(30);
    
    
    _rightField.sd_layout
    .topSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .widthIs(SCREEN_WIDTH/2)
    .heightIs(30);
    
    line.sd_layout
    .bottomSpaceToView(self.contentView,0.5)
    .rightSpaceToView(self.contentView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
}
- (void)setCellIndexPath:(NSIndexPath *)cellIndexPath{
    _cellIndexPath = cellIndexPath;
}
#pragma mark - textField - delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _rightField.text =@"";

}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.cellDelegate respondsToSelector:@selector(rightFieldDidEndEdit:)]) {
        [self.cellDelegate rightFieldDidEndEdit:self];
    }
}
@end
