//
//  InviteRecordCell.m
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "InviteRecordCell.h"
@interface InviteRecordCell ()

@property (nonatomic, strong) UILabel *   content;
@end

@implementation InviteRecordCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
    
    UILabel * content = [[UILabel alloc]init];
    content.font = MBBFONT(15);
    [self.contentView addSubview:content];;
    
    
    content.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(24);
    _content = content;
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self.contentView addSubview:line];
    
    line.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5)
    .bottomSpaceToView(self.contentView, 0);
}
- (void)setModel:(MineInviteRecordModel *)model{
    _model = model;
    _content.text = [NSString stringWithFormat:@"%@  %@",model.add_time, model.u_phone];
    
}
@end
