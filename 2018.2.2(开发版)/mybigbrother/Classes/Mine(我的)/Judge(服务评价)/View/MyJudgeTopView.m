//
//  MyJudgeTopView.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MyJudgeTopView.h"
@interface MyJudgeTopView ()

@property (nonatomic, strong) UIImageView *   leftImage;
@property (nonatomic, strong) UILabel *   title;
@property (nonatomic, strong) UILabel *   price;
@property (nonatomic, strong) UIView * line ;
@end

@implementation MyJudgeTopView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView * leftImage = [[UIImageView alloc]init];
    [self addSubview:leftImage];
    _leftImage = leftImage;
    
    UILabel * title = [[UILabel alloc]init];
    title.font = MBBFONT(12);
    title.textColor = FONT_DARK;
    [self addSubview:title];
    _title = title;
    
    UILabel * price = [[UILabel alloc]init];
    price.font = MBBFONT(10);
    price.textAlignment = NSTextAlignmentRight;
    price.textColor = FONT_LIGHT;
    [self addSubview:price];
    _price = price;
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self addSubview:line];
    _line = line;
    
    [self latOutAllSubviews];

}
- (void)latOutAllSubviews{
    
    _leftImage.sd_layout
    .topSpaceToView(self,20)
    .leftSpaceToView(self,10)
    .widthIs(100)
    .heightIs(100);
    
    _title.sd_layout
    .topEqualToView(_leftImage)
    .leftSpaceToView(_leftImage,10)
    .widthIs(SCREEN_WIDTH - 100 - 20 - 100)
    .heightIs(100);
    
    _price.sd_layout
    .topEqualToView(_leftImage)
    .rightSpaceToView(self,10)
    .widthIs(100)
    .heightIs(20);
    
    _line.sd_layout
    .bottomEqualToView(self)
    .rightSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);

    _title.numberOfLines = 2;
    [_title setMaxNumberOfLinesToShow:2];
}

- (void)setModel:(CustomServiceCellModel *)model{
    _model = model;
    [_leftImage setImageWithURL: [NSURL URLWithString:model.ma_path] placeholder:[UIImage imageNamed:@"default_big"]];
    
    _title.text = model.ma_title;
    
    _price.text = [NSString stringWithFormat:@"$ %@ ",model.ma_price];
        
}
- (void)setJudgeModel:(MyOrderDetailModel *)judgeModel{
    _judgeModel = judgeModel;
    [_leftImage setImageWithURL: [NSURL URLWithString:judgeModel.f_img] placeholder:[UIImage imageNamed:@"default_big"]];
    _title.text = judgeModel.f_name;
    _price.text = [NSString stringWithFormat:@"$ %@ ",judgeModel.or_price];
}
- (void)setSPCommitOrderModel:(SPCommitOrderTopModel *)SPCommitOrderModel{
    _SPCommitOrderModel = SPCommitOrderModel;
    [_leftImage setImageWithURL: [NSURL URLWithString:SPCommitOrderModel.f_img] placeholder:[UIImage imageNamed:@"default_big"]];
    _title.text = SPCommitOrderModel.content;
    _price.text = [NSString stringWithFormat:@"$ %@ ",SPCommitOrderModel.f_price];

    
    
}
@end
