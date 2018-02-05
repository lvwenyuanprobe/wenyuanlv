//
//  MinePublishCell.m
//  mybigbrother
//
//  Created by SN on 2017/4/1.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MinePublishCell.h"

@interface MinePublishCell ()

@property (nonatomic, strong) UIImageView *   icon;
@property (nonatomic, strong) UILabel *   nickName;
@property (nonatomic, strong) UILabel *   date;
@property (nonatomic, strong) UILabel *   planeNum;
@property (nonatomic, strong) UIImageView *  operationView;
@property (nonatomic, strong) UIView *  bgView;
@property (nonatomic, strong) UIButton * statusBtn;

@end

@implementation MinePublishCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    UIView * lowView = self.contentView;
    
    UIImageView * icon = [[UIImageView alloc]init];
    icon.image = [UIImage imageNamed:@"default_icon"];
    icon.clipsToBounds = YES;
    
    UIButton * statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [statusBtn setBackgroundImage:[UIImage imageWithColor:MBBHEXCOLOR(0xfdb400)] forState:UIControlStateNormal];
    [statusBtn setTitle:@"已约成功" forState:UIControlStateNormal];
    [statusBtn.titleLabel setFont:MBBFONT(10)];
    statusBtn.clipsToBounds = YES;
    statusBtn.layer.cornerRadius = 3;
    
    
    
    
    UILabel * nickName = [[UILabel alloc]init];
    nickName.font = MBBFONT(15);
    nickName.textColor = FONT_DARK;
    
    
    UILabel * date = [[UILabel alloc]init];
    date.font = MBBFONT(12);
    date.textColor = FONT_LIGHT;


    UILabel * planeNum = [[UILabel alloc]init];
    planeNum.font = MBBFONT(15);
    planeNum.textColor = FONT_DARK;

    
    UIImageView * operationView = [[UIImageView alloc]init];
    
    UIView * bgVIew = [[UIView alloc]init];
    bgVIew.backgroundColor = BASE_VC_COLOR;
   
    _bgView = bgVIew;
    _icon = icon;
    _nickName = nickName ;
    _date = date;
    _planeNum = planeNum;
    
    
    _statusBtn = statusBtn;
    _operationView = operationView;
    
    
    
    NSArray * subViews = @[_icon,
                           _statusBtn,
                           _nickName,
                           _date,
                           _planeNum,
                           _operationView,
                           _bgView];
    
    [lowView sd_addSubviews:subViews];
    
    _icon.sd_layout
    .topSpaceToView (lowView,10)
    .leftSpaceToView(lowView,10)
    .widthIs(50)
    .heightIs(50);
    
    _statusBtn.sd_layout
    .topSpaceToView(_icon, 5)
    .leftEqualToView(_icon)
    .widthIs(50)
    .heightIs(15);
    
    
    _nickName.sd_layout
    .topSpaceToView (lowView,10)
    .leftSpaceToView(_icon,10)
    .widthIs(SCREEN_WIDTH - 70)
    .heightIs(20);
    
    _date.sd_layout
    .topSpaceToView (_nickName,5)
    .leftSpaceToView(_icon,10)
    .widthIs(SCREEN_WIDTH - 70)
    .heightIs(20);
    
    _planeNum.sd_layout
    .topSpaceToView (_date,0)
    .leftSpaceToView(_icon,10)
    .widthIs(SCREEN_WIDTH - 70)
    .heightIs(20);
    
    _operationView.sd_layout
    .topSpaceToView (lowView,10)
    .rightSpaceToView(lowView,10)
    .widthIs(30)
    .heightIs(15);

    _bgView.sd_layout
    .bottomSpaceToView (lowView,0)
    .rightSpaceToView(lowView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(10);

    
    
    _icon.clipsToBounds = YES;
    _icon.layer.cornerRadius = 25;
    _operationView.userInteractionEnabled = YES;
    _operationView.image = [UIImage imageNamed:@""];

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(operationClicked)];
    _operationView.userInteractionEnabled = YES;
    [_operationView addGestureRecognizer:tap];

}
- (void)setModel:(MinePublishCellModel *)model{
    _model = model;
    
    if([model.r_status isEqualToString:@"1"]){
        _statusBtn.hidden = NO;
    }else{
        _statusBtn.hidden = YES;
    }
    
    [_icon setImageWithURL: [NSURL URLWithString:model.u_img] placeholder:[UIImage imageNamed:@"default_icon"]];
   
    _planeNum.text = [NSString stringWithFormat:@"%d",model.r_flight];
    
    _nickName.text = model.nickname;
    
    _date.text = model.r_time;
    
}
- (void)operationClicked{
    
}
@end
