//
//  MBBMyCenterCell.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBMyCenterCell.h"

@implementation MBBMyCenterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            //左视图leftView
            UIImageView * leftView = [[UIImageView alloc]initWithFrame:CGRectMake(20,14,22, 22)];
            leftView.clipsToBounds = YES;
            leftView.layer.cornerRadius = 5;
            _leftView = leftView;
            [self.contentView addSubview:_leftView];
            //
            UILabel * menuLabel = [[UILabel alloc]init];
            _menuLabel = menuLabel;
            _menuLabel.textColor = MBBHEXCOLOR(0x333333);
            _menuLabel.font = [UIFont systemFontOfSize:16];
            [self.contentView addSubview:_menuLabel];
            [menuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(leftView.mas_right).offset(15);
            }];
            
            
            //you视图leftView
            UIImageView * rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2,10,20, 20)];
            rightImage.clipsToBounds = YES;
            rightImage.layer.cornerRadius = 5;
            [self.contentView addSubview:rightImage];
            _rightImage = rightImage;
            UILabel * rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rightImage.frame)+ 10, 0, SCREEN_WIDTH/2 - 10 -20, 44)];
            rightLabel.textColor = MBBHEXCOLOR(0x666666);
            [self.contentView addSubview:rightLabel];
            _rightLabel = rightLabel;

            _rightImage.hidden = YES;
            _rightLabel.hidden = YES;
            
            }
        return self;
}
- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(outSideCustomerService)];
    _rightLabel.userInteractionEnabled = YES;
    [_rightLabel addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer * leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(inSideCustomerService)];
    _menuLabel.userInteractionEnabled = YES;
    [_menuLabel addGestureRecognizer:leftTap];
}

- (void)outSideCustomerService{
    if ([self.delegate respondsToSelector:@selector(outSideCustomService)]) {
        [self.delegate outSideCustomService];
    }

}
- (void)inSideCustomerService{
    if ([self.delegate respondsToSelector:@selector(inSideCustomService)]) {
        [self.delegate inSideCustomService];
    }
 
}

@end
