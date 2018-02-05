//
//  HomeServiceExmpleView.m
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "HomeServiceExmpleView.h"
#import "ServiceCaseModel.h"

@interface HomeServiceExmpleView ()

@property (nonatomic, strong) UIImageView *   picture;
@property (nonatomic, strong) UILabel *   title;
@property (nonatomic, strong) UILabel *   subTitle ;
@end

@implementation HomeServiceExmpleView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    /** 注意内部设置翻转*/
    self.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    UIView * lowView = self.contentView;

    
    UIImageView * iconImage = [[UIImageView alloc]init];
    [lowView addSubview:iconImage];
    
    _picture = iconImage;
    
    UILabel * title = [[UILabel alloc]init];
    title.text = @"西安到石头城";
    title.font = MBBFONT(17);
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = MBBHEXCOLOR(0x333333);
    [lowView addSubview:title];
    title.font = [UIFont boldSystemFontOfSize:17];
    _title = title;
    
    /** */

    UILabel * subTitle = [[UILabel alloc]init];
    subTitle.text = @"10000人";
    subTitle.font = MBBFONT(14);
    subTitle.textColor = MBBHEXCOLOR(0x666666);

    subTitle.textAlignment = NSTextAlignmentCenter;
    [lowView addSubview:subTitle];
    _subTitle = subTitle;

    [self layOutAllSubviews];
    
}
- (void)layOutAllSubviews{
    _picture.frame  = CGRectMake(10, 0, 148, 114);
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_picture);
        make.top.equalTo(_picture.mas_bottom).offset(10);
    }];
    [_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_picture);
        make.top.equalTo(_title.mas_bottom).offset(10);
    }];
}
- (void)setModel:(ServiceCaseModel *)model{
    _model = model;
    
    [_picture setImageWithURL: [NSURL URLWithString:model.case_img] placeholder:[UIImage imageNamed:@"default_big"]];
    _title.text = model.trip;
    _subTitle.text = [NSString stringWithFormat:@"%ld名学生",(long)model.number];
}
@end
