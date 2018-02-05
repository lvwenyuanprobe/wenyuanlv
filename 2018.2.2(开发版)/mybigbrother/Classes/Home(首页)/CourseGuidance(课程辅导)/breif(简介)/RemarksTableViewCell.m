//
//  RemarksTableViewCell.m
//  mybigbrother
//
//  Created by Loren on 2018/1/10.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "RemarksTableViewCell.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"

@interface RemarksTableViewCell ()

{
    NSIndexPath *_cellIndexPath;  // 当前Cell的下标
}

@end

@implementation RemarksTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self layoutUI];
    }
    return self;
}

- (void)setCellContent:(NSString *)contentStr andIsShow:(BOOL)isShow andCellIndexPath:(NSIndexPath *)indexPath
{
    _textsLabel.text = contentStr;
    _cellIndexPath = indexPath;
    
    // 设置
    [UILabel changeLineSpaceForLabel:_textsLabel WithSpace:5.0];
    
     CGRect rect = [_textsLabel.text boundingRectWithSize:CGSizeMake(BOUNDS.size.width-30, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    if (rect.size.height > 125) {
        // 文字大于三行，显示展开收起按钮
        self.moreBtn.hidden = NO;
        if (isShow) {
            _textsLabel.numberOfLines = 0;
             [_textsLabel sizeToFit];
            _textsLabel.adjustsFontSizeToFitWidth = YES;
            
            [_textsLabel mas_remakeConstraints:^(MASConstraintMaker *make){
                make.left.mas_equalTo(self.contentView.mas_left).offset(15);
                make.top.mas_equalTo(15);
                make.width.mas_equalTo(BOUNDS.size.width-30);
                make.height.mas_equalTo(rect.size.height);
            }];
        } else {
            [_textsLabel mas_remakeConstraints:^(MASConstraintMaker *make){
                make.left.mas_equalTo(self.contentView.mas_left).offset(15);
                make.top.mas_equalTo(15);
                make.width.mas_equalTo(BOUNDS.size.width-30);
                make.height.mas_equalTo(125);
            }];
        }
    } else {
        // 文字小于三行，隐藏展开收起按钮
        _textsLabel.numberOfLines = 7;
        self.moreBtn.hidden = YES;
         [_textsLabel sizeToFit];
        [_textsLabel mas_remakeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
            make.top.mas_equalTo(15);
            make.width.mas_equalTo(BOUNDS.size.width-30);
            make.height.mas_equalTo(rect.size.height+1);  // 由于系统计算的那个高度有时候会有1像素到2像素的误差，所以这里把高度+1
        }];
    }
}

#pragma mark - 显示更多按钮点击事件
- (void)moreButtonClicked
{
    self.moreBtn.selected = !self.moreBtn.selected;
    if (self.moreBtn.selected) {
        [self.moreBtn setImage:[UIImage imageNamed:@"收起"] forState:UIControlStateNormal];
    }else{
        [self.moreBtn setImage:[UIImage imageNamed:@"展开"] forState:UIControlStateNormal];
    }
    
    // 记录当前按钮的选中状态，并传递给Controller
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:_cellIndexPath.row] forKey:@"row"];
    [dic setObject:[NSNumber numberWithBool:self.moreBtn.selected] forKey:@"isShow"];
    
    
    // 协议回调，改变Controller中存放Cell展开收起状态的字典
    if (self.delegate && [self.delegate respondsToSelector:@selector(remarksCellShowContrntWithDic:andCellIndexPath:)]) {
        [self.delegate remarksCellShowContrntWithDic:dic andCellIndexPath:_cellIndexPath];
    }
}

- (void)layoutUI
{
    
    _textsLabel = [[UILabel alloc]init];
//    _textsLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _textsLabel.numberOfLines = 7;
    _textsLabel.font = [UIFont systemFontOfSize:15];
    _textsLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _textsLabel.text = @"";
    [_textsLabel sizeToFit];
    [self.contentView addSubview:_textsLabel];
    
    
    _moreBtn = [[UIButton alloc]init];
    [_moreBtn setImage:[UIImage imageNamed:@"展开"] forState:UIControlStateNormal];
    [_moreBtn setImage:[UIImage imageNamed:@"收起"] forState:UIControlStateHighlighted];
    [_moreBtn addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    _moreBtn.alpha = 0.7;
    [self.contentView addSubview:_moreBtn];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.mas_equalTo(150);
        make.top.mas_equalTo(_textsLabel.mas_bottom).offset(0);
        make.width.mas_equalTo(BOUNDS.size.width);
        make.height.mas_equalTo(30);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
