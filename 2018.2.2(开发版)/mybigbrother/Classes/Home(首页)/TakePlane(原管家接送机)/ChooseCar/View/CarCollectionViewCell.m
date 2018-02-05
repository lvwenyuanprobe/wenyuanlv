//
//  CarCollectionViewCell.m
//  mybigbrother
//
//  Created by SN on 2017/4/28.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "CarCollectionViewCell.h"
#import "CarModel.h"

@interface CarCollectionViewCell ()

@property (nonatomic, strong) UIImageView * carImage;
@end

@implementation CarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews{
    
    UIView * lowView = self.contentView;
    UIImageView * iconImage = [[UIImageView alloc]init];
    [lowView addSubview:iconImage];
    iconImage.layer.masksToBounds = YES;
    iconImage.layer.cornerRadius = 5;
//    lowView.layer.shadowColor = [UIColor blackColor].CGColor;
//    lowView.layer.shadowOpacity = 0.8;
//    lowView.layer.shadowRadius = 4;
//    lowView.layer.shadowOffset = CGSizeMake(3, 3);
    
    iconImage.sd_layout.spaceToSuperView(UIEdgeInsetsMake(5, 5, 5, 5));
    _carImage = iconImage;
    
}
- (void)setModel:(id)model{
    
    if ([model isKindOfClass:[CarModel class]]) {
        CarModel * TModel = model;
        [_carImage setImageWithURL: [NSURL URLWithString:TModel.car_img] placeholder:[UIImage imageNamed:@"default_big"]];
    }else{
    
    }
    
}
@end
