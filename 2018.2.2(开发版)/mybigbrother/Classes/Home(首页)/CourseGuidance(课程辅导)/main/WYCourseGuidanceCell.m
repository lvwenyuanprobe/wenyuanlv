//
//  WYCourseGuidanceCell.m
//  mybigbrother
//
//  Created by Loren on 2018/1/9.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYCourseGuidanceCell.h"
#import "WYBreifController.h"
@interface WYCourseGuidanceCell ()
{
    DWQGoBreifVCBlock goToBreifVCBlock;
}
@end
@implementation WYCourseGuidanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    UIView *botView = [[UIView alloc] init];
    [self addSubview:botView];
    botView.backgroundColor = [UIColor whiteColor];
    [botView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    
    // 头像
    self.iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiaoshou.jpg"]];
    [botView addSubview:self.iconImgView];
    self.iconImgView.contentMode=UIViewContentModeScaleAspectFill;
    self.iconImgView.clipsToBounds=YES;
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.width.height.mas_equalTo(70);
    }];
    
    _tvImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kc_sk"]];
    [_iconImgView addSubview:_tvImgView];
    [_tvImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-4);
        make.right.mas_equalTo(-4);
    }];
    UILabel *tvLabel = [[UILabel alloc] init];
    [_tvImgView addSubview:tvLabel];
    tvLabel.text = @"视频";
    tvLabel.font = [UIFont systemFontOfSize:8.0f];
    tvLabel.textColor = [UIColor colorWithHexString:@"#fcf9f9"];
    [tvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_tvImgView);
    }];
    
    _teacher = [[UILabel alloc] init];
    [self addSubview:_teacher];
    _teacher.font = [UIFont systemFontOfSize:16.0f];
    _teacher.textColor = [UIColor colorWithHexString:@"#010101"];
    _teacher.text = @"讲师:";
    _teacher.font = [UIFont boldSystemFontOfSize:16.0f];
    [_teacher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImgView.mas_right).offset(10);
        make.top.equalTo(_iconImgView);
    }];
    
    // 讲师名称
    _teacherName = [[UILabel alloc] init];
    [self addSubview:_teacherName];
    _teacherName.font = [UIFont systemFontOfSize:16.0f];
    _teacherName.textColor = [UIColor colorWithHexString:@"#010101"];
    _teacherName.text = @"Albert Einstein";
    _teacherName.font = [UIFont boldSystemFontOfSize:16.0f];
    [_teacherName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_teacher);
        make.left.equalTo(_teacher.mas_right).offset(8);
    }];
    
    _mainLecture = [[UILabel alloc] init];
    [self addSubview:_mainLecture];
    _mainLecture.font = [UIFont systemFontOfSize:14.0f];
    _mainLecture.textColor = [UIColor colorWithHexString:@"#666666"];
    _mainLecture.text = @"主讲:";
    [_mainLecture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconImgView);
        make.left.equalTo(_teacher);
    }];
    
    // 课程名称
    _mainLectureName = [[UILabel alloc] init];
    [self addSubview:_mainLectureName];
    _mainLectureName.font = [UIFont systemFontOfSize:14.0f];
    _mainLectureName.textColor = [UIColor colorWithHexString:@"#666666"];
    _mainLectureName.text = @"Special heory Of Relativity"; //
    [_mainLectureName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconImgView);
        make.left.equalTo(_mainLecture.mas_right).offset(8);
    }];
    
    //播放次数
    _message = [[UILabel alloc] init];
    [self addSubview:_message];
    _message.font = [UIFont systemFontOfSize:12.0f];
    _message.textColor = [UIColor colorWithHexString:@"#999999"];
    _message.text = @"29381"; //
    [_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_iconImgView);
        make.left.equalTo(_mainLecture);
    }];
    
    
    _messageContent = [[UILabel alloc] init];
    [self addSubview:_messageContent];
    _messageContent.font = [UIFont systemFontOfSize:12.0f];
    _messageContent.textColor = [UIColor colorWithHexString:@"#999999"];
    _messageContent.text = @"次播放"; //
    [_messageContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_iconImgView);
        make.left.equalTo(_message.mas_right).offset(8);
    }];
    
    _breif = [[UIButton alloc] init];
    [self addSubview:_breif];
    [_breif setTitle:@"简介>>" forState:UIControlStateNormal];
    [_breif setTitleColor:[UIColor colorWithHexString:@"#f76236"] forState:UIControlStateNormal];
    _breif.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_breif addTarget:self action:@selector(gotoBreifAction:) forControlEvents:UIControlEventTouchUpInside];
    [_breif mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_messageContent);
        make.right.mas_equalTo(-20);
    }];
}

- (void)gotoBreifAction:(UIButton *)sender
{
    
    if (goToBreifVCBlock) {
        goToBreifVCBlock(sender.titleLabel.text);
    }
//    WYBreifController *breifVC = [[WYBreifController alloc] init];
//    breifVC.hidesBottomBarWhenPushed = YES;
//    [[self viewController].navigationController pushViewController:breifVC animated:YES];
}
- (void)goToBreifVCBlock:(DWQGoBreifVCBlock)block{
    goToBreifVCBlock =block;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end












