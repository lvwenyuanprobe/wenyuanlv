//
//  PartnerCollectionViewcell.m
//  mybigbrother
//
//  Created by SN on 2017/7/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "PartnerCollectionViewCell.h"
@interface PartnerCollectionViewCell()
/** 头像*/
@property (nonatomic, strong) UIImageView * icon;
/** 年龄*/
@property (nonatomic, strong) UILabel *  age;
/** 昵称*/
@property (nonatomic, strong) UILabel *  nickName;
/** 时间*/
@property (nonatomic, strong) UILabel *  time;
/** 约否*/
@property (nonatomic, strong) UIButton * stateBtn ;
@end


@implementation PartnerCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        [self setupView];
    }
    return  self;
}
- (void)setupView{
    
    /** 头像*/
    UIImageView * icon = [[UIImageView alloc]init];
    _icon = icon;
    [self addSubview:icon];
    
    /** age*/
    UILabel * age = [[UILabel alloc]init];
    _age  = age;
    [self addSubview:age];
    

    
    /** name*/
    UILabel * nickName = [[UILabel alloc]init];
    _nickName  = nickName;
    [self addSubview:nickName];

    /** time*/
    UILabel * time = [[UILabel alloc]init];
    _time  = time;
    [self addSubview:time];
    
    


    _icon.clipsToBounds = YES;
    _icon.contentMode =UIViewContentModeScaleAspectFill;
    _icon.sd_cornerRadius = @((SCREEN_WIDTH-80)/6);
    
    _nickName.textColor = FONT_DARK;
    _nickName.font = MBBFONT(12);
    _nickName.textAlignment = NSTextAlignmentCenter;
    
    _time.textColor = FONT_LIGHT;
    _time.font = MBBFONT(10);
    _time.textAlignment = NSTextAlignmentCenter;
    
    UIButton * sateBtn = [[UIButton alloc]init];
    sateBtn.backgroundColor = MBBHEXCOLOR(0xfdb400);
    [sateBtn setTitle:@"已约" forState:UIControlStateNormal];
    [sateBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [sateBtn.titleLabel setFont:MBBFONT(9)];
    sateBtn.clipsToBounds = YES;
    sateBtn.layer.cornerRadius = 12.5;
    sateBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    sateBtn.layer.borderWidth = 2;
    [self addSubview:sateBtn];
    _stateBtn = sateBtn;


}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    /** 设置中行突出(cell内配合设置)*/
    if ((indexPath.row%3 == 0 || indexPath.row%3 == 2)&&indexPath.row/3 == 0){
        _icon.sd_layout
        .topSpaceToView(self,50)
        .leftSpaceToView(self,10)
        .widthIs((SCREEN_WIDTH-80)/3)
        .heightIs((SCREEN_WIDTH-80)/3);
        
        
        
        
        _stateBtn.sd_layout
        .topSpaceToView(_icon, -12.5)
        .leftSpaceToView(self, self.frame.size.width/2 - 12.5)
        .widthIs(25)
        .heightIs(25);
        
        _nickName.sd_layout
        .topSpaceToView(_stateBtn,5)
        .leftSpaceToView(self,0)
        .widthIs(self.frame.size.width)
        .heightIs(15);
        
        _time.sd_layout
        .topSpaceToView(_nickName,0)
        .leftSpaceToView(self,0)
        .widthIs(self.frame.size.width)
        .heightIs(10);


        
    }else{
        _icon.sd_layout
        .topSpaceToView(self,10)
        .leftSpaceToView(self,10)
        .widthIs((SCREEN_WIDTH-80)/3)
        .heightIs((SCREEN_WIDTH-80)/3);
        
        _stateBtn.sd_layout
        .topSpaceToView(_icon, -12.5)
        .leftSpaceToView(self, self.frame.size.width/2 - 12.5)
        .widthIs(25)
        .heightIs(25);
        
        _nickName.sd_layout
        .topSpaceToView(_stateBtn,5)
        .leftSpaceToView(self,0)
        .widthIs(self.frame.size.width)
        .heightIs(15);
        
        _time.sd_layout
        .topSpaceToView(_nickName,0)
        .leftSpaceToView(self,0)
        .widthIs(self.frame.size.width)
        .heightIs(10);

    }
    
}
-(void)setModel:(PartnersTogetherModel *)model{
    
    [_icon setImageWithURL: [NSURL URLWithString:model.u_img] placeholder:[UIImage imageNamed:@"default_big"]];
    
    _nickName.text = model.nickname;
    
    _time.text = model.r_time;
    
    if ([model.r_status isEqualToString:@"0"]) {
        [_stateBtn setTitle:@"未约" forState:UIControlStateNormal];
        _stateBtn.hidden = NO;
    }else{
        [_stateBtn setTitle:@"已约" forState:UIControlStateNormal];
        _stateBtn.hidden = NO;
    }

}
@end
