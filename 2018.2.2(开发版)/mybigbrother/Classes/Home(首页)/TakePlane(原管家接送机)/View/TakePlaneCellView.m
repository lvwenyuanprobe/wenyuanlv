//
//  TakePlaneCellView.m
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "TakePlaneCellView.h"

@implementation TakePlaneCellView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    /** */
    UIImageView * leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(15,10,20, 20)];
    [self addSubview:leftImage];
    _leftImage = leftImage;

    //
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftImage.frame)+ 10, 0, SCREEN_WIDTH/2 - 10 -20, 44)];
    titleLabel.textColor = MBBHEXCOLOR(0x666666);
    titleLabel.font = MBBFONT(15);
    [self addSubview:titleLabel];
    _titleLabel =titleLabel;
    
    
    UIImageView * rightImage = [[UIImageView alloc]init];
    rightImage.image = [UIImage imageNamed:@"home_arrow"];
    rightImage.frame = CGRectMake(SCREEN_WIDTH - 35, H(15), 10, 20);
    [self addSubview:rightImage];
    _rightArrow = rightImage;
    
    UIView * line =[[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self addSubview:line];
    _line = line;
    
    
    UITextField * rightLabel = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2 - 10 -20, 44)];
    rightLabel.textColor = FONT_LIGHT;
    rightLabel.textAlignment = NSTextAlignmentRight;
//    rightLabel.keyboardType = UIKeyboardTypeDefault;
    [self addSubview:rightLabel];
    rightLabel.font = MBBFONT(15);
    rightLabel.placeholder = @"请填写";
    
    _rightLabel = rightLabel;


    
    _leftImage.sd_layout
    .topSpaceToView(self,15)
    .leftSpaceToView(self,10)
    .widthIs(20)
    .heightIs(20);
    
    _rightArrow.sd_layout
    .topSpaceToView(self,12)
    .rightSpaceToView(self,10)
    .widthIs(10)
    .heightIs(20);
    
    _line.sd_layout
    .bottomSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(0.5);
    
    _rightLabel.sd_layout
    .rightSpaceToView(self,40)
    .topSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH/2 - 30)
    .heightIs(44);
}

@end
