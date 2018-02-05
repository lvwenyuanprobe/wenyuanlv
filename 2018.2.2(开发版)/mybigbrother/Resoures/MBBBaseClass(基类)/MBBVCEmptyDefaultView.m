//
//  MBBVCEmptyDefaultView.m
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBVCEmptyDefaultView.h"
@interface  MBBVCEmptyDefaultView()
/** 默认图*/
@property (nonatomic, strong) UIImageView * defaultImage;
/** 主默认说明*/
@property (nonatomic, strong) UILabel * mainLabel;
/** 副默认说明*/
@property (nonatomic, strong) UILabel * subLabel;
@end

@implementation MBBVCEmptyDefaultView

- (instancetype)initWithFrame:(CGRect)frame centerImage:(NSString *)image title:(NSString *)title subTitle:(NSString * )subTitle{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setupViews:image title:title subTitle:subTitle];
    }
    
    return self;
}
- (void)setupViews:(NSString *)image title:(NSString *)title subTitle:(NSString *)subTitle{
    
    UIImageView * defautImage = [[UIImageView alloc]init];
    defautImage.image = [UIImage imageNamed:image];
    [self addSubview:defautImage];
    
    UILabel * defautLabel =  [[UILabel alloc]init];
    defautLabel.text = title?title:@"";
    defautLabel.textColor = FONT_LIGHT;
    defautLabel.font = MBBFONT(15);
    defautLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:defautLabel];
    
    UILabel * defautLabel1 =  [[UILabel alloc]init];
    defautLabel1.text = subTitle?subTitle:@"";
    defautLabel1.textColor = FONT_LIGHT;
    defautLabel1.font = MBBFONT(15);
    defautLabel1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:defautLabel1];
    
    
    defautImage.sd_layout
    .topSpaceToView(self,10)
    .leftSpaceToView(self,120)
    .widthIs(SCREEN_WIDTH - 240)
    .heightIs(SCREEN_WIDTH - 240);
    
    defautLabel.sd_layout
    .topSpaceToView(defautImage,10)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(20);

    defautLabel1.sd_layout
    .topSpaceToView(defautLabel,0)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(20);
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    UIImageView * defaultImage = [[UIImageView alloc]init];
    [self addSubview:defaultImage];
    UILabel * mainLabel =  [[UILabel alloc]init];
    mainLabel.text = @"";
    mainLabel.textColor = FONT_LIGHT;
    mainLabel.font = MBBFONT(15);
    mainLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:mainLabel];
    
    UILabel * subLabel =  [[UILabel alloc]init];
    subLabel.text = @"";
    subLabel.textColor = FONT_LIGHT;
    subLabel.font = MBBFONT(15);
    subLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:subLabel];
    
    defaultImage.sd_layout
    .topSpaceToView(self,10)
    .leftSpaceToView(self,120)
    .widthIs(SCREEN_WIDTH - 240)
    .heightIs(100);
    
    mainLabel.sd_layout
    .topSpaceToView(defaultImage,10)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(20);
    
    subLabel.sd_layout
    .topSpaceToView(mainLabel,0)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(20);
    
    _defaultImage = defaultImage;
    _mainLabel    = mainLabel;
    _subLabel = subLabel;
}
- (void)setDefaultImageStr:(NSString *)defaultImageStr{
    _defaultImageStr = defaultImageStr;
    _defaultImage.image = [UIImage imageNamed:defaultImageStr];
    
    
}
- (void)setMainTitle:(NSString *)mainTitle{
    _mainTitle = mainTitle;
    _mainLabel.text = mainTitle;
    
}
- (void)setSubTitle:(NSString *)subTitle{
    _subTitle = subTitle;
    _subLabel.text = subTitle;
}

- (void)defaultImageHidden{
    if (self.superview){
        [self removeFromSuperview];
    }
}
@end
