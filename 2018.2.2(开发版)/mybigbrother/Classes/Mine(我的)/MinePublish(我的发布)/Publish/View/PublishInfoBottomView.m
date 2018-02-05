//
//  PublishInfoBottomView.m
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "PublishInfoBottomView.h"

@implementation PublishInfoBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"上传图片";
    titleLabel.textColor = FONT_DARK;
    titleLabel.font = MBBFONT(15);
    
    titleLabel.frame = CGRectMake(10, 10, SCREEN_WIDTH, 30);
    [self addSubview:titleLabel];
    
    
    UIImageView * plusBtn = [[UIImageView alloc]init];
    plusBtn.clipsToBounds = YES;
    plusBtn.layer.cornerRadius = 3;
    plusBtn.contentMode = UIViewContentModeScaleAspectFill;
    plusBtn.image = [UIImage imageNamed:@"xiangji3"];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPhotos)];
    plusBtn.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    [plusBtn addGestureRecognizer:tap];
    plusBtn.frame = CGRectMake(10, CGRectGetMaxY(titleLabel.frame) + 20,100, 100);
    [self addSubview:plusBtn];
    _selectIamge = plusBtn;

}

- (void)addPhotos{
    if ([self.delegate respondsToSelector:@selector(bottomViewAddPhotos)]) {
        [self.delegate bottomViewAddPhotos];
    }
}
@end
