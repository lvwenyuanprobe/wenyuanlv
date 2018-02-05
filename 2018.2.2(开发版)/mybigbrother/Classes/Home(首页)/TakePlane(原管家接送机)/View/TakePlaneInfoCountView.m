//
//  TakePlaneInfoCountView.m
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "TakePlaneInfoCountView.h"
@interface TakePlaneInfoCountView ()

@property (nonatomic, assign) NSInteger  count;
@property (nonatomic, strong) UIImageView * leftImage ;
@property (nonatomic, strong) UILabel     * titleLabel ;
@property (nonatomic, strong) UIView * line;

@property (nonatomic, strong,readwrite) UILabel * countLabel;


@end

@implementation TakePlaneInfoCountView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    _count =  1;
    /** */
    UIImageView * leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(15,10,20, 20)];
    [self addSubview:leftImage];
    _leftImage = leftImage;
    _leftImage.image = [UIImage imageNamed:@"takeplane_count"];
    
    //
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftImage.frame)+ 10, 0, SCREEN_WIDTH/2 - 10 -20, 44)];
    titleLabel.textColor = MBBHEXCOLOR(0x666666);
    titleLabel.font = MBBFONT(15);
    [self addSubview:titleLabel];
    _titleLabel =titleLabel;
    _titleLabel.text = @"人数";
    
    
    
    UIView * line =[[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self addSubview:line];
    _line = line;
    
    
    UIButton * reduceBtn = [[UIButton alloc] init];
    [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
    [reduceBtn setTitleColor:FONT_DARK forState:UIControlStateNormal];
    [reduceBtn addTarget:self action:@selector(reduceClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reduceBtn];

    UILabel * countLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
    countLabel.textColor = [UIColor redColor];
    countLabel.text = @"1";
    countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel = countLabel;
    [self addSubview:countLabel];

    
    
    
    UIButton * plusBtn = [[UIButton alloc] init];
    [plusBtn setTitle:@"+" forState:UIControlStateNormal];
    [plusBtn setTitleColor:FONT_DARK forState:UIControlStateNormal];
    [plusBtn addTarget:self action:@selector(plusClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:plusBtn];

    
    
    _leftImage.sd_layout
    .topSpaceToView(self,15)
    .leftSpaceToView(self,10)
    .widthIs(20)
    .heightIs(20);
    
    
    _line.sd_layout
    .bottomSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(0.5);
    
    
    plusBtn.sd_layout
    .topSpaceToView(self,0)
    .rightSpaceToView(self,10)
    .widthIs(30)
    .heightIs(44);
    
    countLabel.sd_layout
    .topSpaceToView(self,0)
    .rightSpaceToView(plusBtn,0)
    .widthIs(30)
    .heightIs(44);

    reduceBtn.sd_layout
    .topSpaceToView(self,0)
    .rightSpaceToView(countLabel,0)
    .widthIs(30)
    .heightIs(44);

}

- (void)plusClicked{
   _count =  _count + 1;
    _countLabel.text = [NSString stringWithFormat:@"%ld",(long)_count];
    
}
- (void)reduceClicked{
    if (_count == 1) {
        return;
    }
    _count =  _count - 1;
    _countLabel.text = [NSString stringWithFormat:@"%ld",(long)_count];

    
}
@end
