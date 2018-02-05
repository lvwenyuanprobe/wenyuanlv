//
//  MBBTextViewTableViewCell.m
//  mybigbrother
//
//  Created by qiu on 21/1/18.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBTextViewTableViewCell.h"
#define kRight 10
@interface MBBTextViewTableViewCell ()
{
    DWQTextViewChangedBlock textViewWithBlock;
}
@end
@implementation MBBTextViewTableViewCell

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
    
    _textView = [[UITextView alloc] init];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-kRight-5);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
    }];
    
    _labelTip = [[UILabel alloc] init];
    _labelTip.text = @"告诉我们你想要什么样的旅行吧！";
    [_labelTip setFont:[UIFont systemFontOfSize:14.0f weight:UIFontWeightThin]];
    [_labelTip setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [self.contentView addSubview:_labelTip];
    [_labelTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.width.mas_equalTo(350);
    }];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textViewWithBlock) {
        textViewWithBlock(textView.text);
    }
    
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length==0) {
        _labelTip.hidden = NO;
    }else{
        _labelTip.hidden = YES;
    }
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    _labelTip.hidden = YES;
    
}
- (void)textViewWithBlock:(DWQTextViewChangedBlock)block{
    textViewWithBlock = block;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

