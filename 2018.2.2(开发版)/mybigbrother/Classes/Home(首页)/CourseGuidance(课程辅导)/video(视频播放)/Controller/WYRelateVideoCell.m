//
//  WYRelateVideoCell.m
//  mybigbrother
//
//  Created by Loren on 2018/1/12.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYRelateVideoCell.h"

@implementation WYRelateVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    _teacherLabel = [[UILabel alloc] init];
    [self addSubview:_teacherLabel];
    _teacherLabel.text = @"讲师:";
    _teacherLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    _teacherLabel.font = [UIFont systemFontOfSize:14.0f];
    [_teacherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
    }];
    
    // 赋值
    _teacher = [[UILabel alloc] init];
    [self addSubview:_teacher];
    _teacher.text = @"Joie";
    _teacher.textColor = [UIColor colorWithHexString:@"#000000"];
    _teacher.font = [UIFont systemFontOfSize:14.0f];
    [_teacher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_teacherLabel);
        make.left.equalTo(_teacherLabel.mas_right).offset(10);
    }];
    
    _coruseLabel = [[UILabel alloc] init];
    [self addSubview:_coruseLabel];
    _coruseLabel.text = @"课程:";
    _coruseLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    _coruseLabel.font = [UIFont systemFontOfSize:14.0f];
    [_coruseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_teacherLabel.mas_bottom).offset(10);
        make.left.equalTo(_teacherLabel);
    }];
    
    // 赋值
    _coruse = [[UILabel alloc] init];
    [self addSubview:_coruse];
    _coruse.text = @"TOEFL Speaking";
    _coruse.textColor = [UIColor colorWithHexString:@"#000000"];
    _coruse.font = [UIFont systemFontOfSize:14.0f];
    [_coruse mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_coruseLabel);
        make.left.equalTo(_coruseLabel.mas_right).offset(10);
    }];
    
    // 赋值
    _playerNumber = [[UILabel alloc] init];
    [self addSubview:_playerNumber];
    _playerNumber.text = @"28123 次播放";
    _playerNumber.textColor = [UIColor colorWithHexString:@"#999999"];
    _playerNumber.font = [UIFont systemFontOfSize:12.0f];
    [_playerNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_teacherLabel);
        make.top.equalTo(_coruseLabel.mas_bottom).offset(10);
    }];
    
    // 赋值
    _teacherIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiaoshou.jpg"]];
    [self addSubview:_teacherIcon];
    _teacherIcon.contentMode=UIViewContentModeScaleAspectFill;
    _teacherIcon.clipsToBounds=YES;
    [_teacherIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(105);
        make.height.mas_equalTo(70);
        make.centerY.equalTo(self);
        make.right.mas_equalTo(-15);
    }];
}

//重写高亮函数
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    if (highlighted) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



















