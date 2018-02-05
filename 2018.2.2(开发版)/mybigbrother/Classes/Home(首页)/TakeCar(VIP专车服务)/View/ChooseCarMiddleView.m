//
//  ChooseCarMiddleView.m
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ChooseCarMiddleView.h"

@implementation ChooseCarMiddleView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView * countImage = [[UIImageView alloc]init];
    countImage.image = [UIImage imageNamed:@"home_people"];
    [self addSubview:countImage];
    
    UIImageView * packageImage = [[UIImageView alloc]init];
    packageImage.image = [UIImage imageNamed:@"home_luggage"];

    [self addSubview:packageImage];

    
    /** 人数*/
    UILabel * count = [[UILabel alloc]init];
    count.text = @"出行人数/容量";
    count.textColor = FONT_DARK;
    count.font = MBBFONT(15);
    [self addSubview:count];
    
    UILabel * personCount = [[UILabel alloc]init];
    personCount.text = @"2人/4人";
    personCount.textColor = FONT_DARK;
    personCount.font = MBBFONT(15);
    [self addSubview:personCount];
    
    
    countImage.sd_layout
    .topSpaceToView(self, 10)
    .leftSpaceToView(self, 10)
    .widthIs(15)
    .heightIs(20);
    
    count.sd_layout
    .topSpaceToView(self, 10)
    .leftSpaceToView(countImage, 10)
    .widthIs(SCREEN_WIDTH - 30 - 60 -10)
    .heightIs(20);

    personCount.sd_layout
    .topSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .widthIs(SCREEN_WIDTH - 30)
    .heightIs(20);
    personCount.textAlignment = NSTextAlignmentRight;
    
    /** 行李*/
    UILabel * packageLabel = [[UILabel alloc]init];
    packageLabel.text = @"可携带行李数(0寸)";
    packageLabel.textColor = FONT_DARK;
    packageLabel.font = MBBFONT(15);
    [self addSubview:packageLabel];
    
    UILabel * packageCount = [[UILabel alloc]init];
    packageCount.text = @"0件";
    packageCount.textColor = [UIColor redColor];
    packageCount.font = MBBFONT(15);
    [self addSubview:packageCount];
    packageCount.textAlignment = NSTextAlignmentRight;

    
    /** 说明*/
    UILabel * explain = [[UILabel alloc]init];
    explain.text = @"实际行李数如果超出限制,请更换更大车型";
    explain.textColor = FONT_LIGHT;
    explain.font = MBBFONT(12);
    [self addSubview:explain];

    
    packageImage.sd_layout
    .topSpaceToView(countImage, 20)
    .leftSpaceToView(self, 10)
    .widthIs(15)
    .heightIs(20);
    
    packageLabel.sd_layout
    .topEqualToView(packageImage)
    .leftSpaceToView(packageImage, 10)
    .widthIs(SCREEN_WIDTH - 30 - 60 -10)
    .heightIs(20);
    
    packageCount.sd_layout
    .topEqualToView(packageImage)
    .rightSpaceToView(self, 10)
    .widthIs(SCREEN_WIDTH - 30)
    .heightIs(20);
    
    
    
    explain.sd_layout
    .bottomSpaceToView(self, 10)
    .leftSpaceToView(self, 10)
    .widthIs(SCREEN_WIDTH - 30)
    .heightIs(20);
    
    _personCountLabel = personCount;

    _packageCountLabel = packageCount;
    
    _packageLabel = packageLabel;
    
}
@end
