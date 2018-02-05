//
//  DriverAccountCell.m
//  mybigbrother
//
//  Created by SN on 2017/5/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "DriverAccountCell.h"
@interface  DriverAccountCell()

/** 头像*/
@property (nonatomic, strong) UIImageView *  iconImage;

/** 收支*/
@property (nonatomic, strong) UILabel *   monneyLabel;

/** 日期*/
@property (nonatomic, strong) UILabel *   dateLabel;

/** 日期*/
@property (nonatomic, strong) UILabel *   timeLabel;


/** 描述*/
@property (nonatomic, strong) UILabel *   descLabel;

/** 提现状态*/
@property (nonatomic, strong) UILabel *  statusLabel;

@property (nonatomic, strong) UIView * line ;

@end

@implementation DriverAccountCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setupViews{
    
    UIImageView * iconImage = [[UIImageView alloc]init];
    iconImage.clipsToBounds = YES;
    iconImage.layer.cornerRadius = 30;
    
    UILabel * dateLabel = [[UILabel alloc]init];
    dateLabel.font = MBBFONT(15);
    dateLabel.textColor = FONT_DARK;
    
    UILabel * timeLabel = [[UILabel alloc]init];
    timeLabel.font = MBBFONT(12);
    timeLabel.textColor = FONT_LIGHT;

    
    
    UILabel * monneyLabel = [[UILabel alloc]init];
    monneyLabel.font = MBBFONT(15);
    monneyLabel.textColor = FONT_DARK;

    UILabel * descLabel = [[UILabel alloc]init];
    descLabel.font = MBBFONT(15);
    descLabel.textColor = FONT_LIGHT;
    
    UILabel * statusLabel = [[UILabel alloc]init];
    statusLabel.font = MBBFONT(12);

    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    
    
    _iconImage = iconImage;
    
    _dateLabel = dateLabel;
    
    _monneyLabel = monneyLabel;
    
    _descLabel = descLabel;
    
    _statusLabel = statusLabel;
    
    _timeLabel = timeLabel;
    
    _line = line;
    
    
    NSArray * views = @[_iconImage,
                        _dateLabel,
                        _monneyLabel,
                        _descLabel,
                        _statusLabel,
                        _line,
                        _timeLabel,
                        ];
    
    [self.contentView sd_addSubviews:views];
    
    
    _dateLabel.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView,15)
    .widthIs(40)
    .heightIs(20);
    
    _timeLabel.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(_dateLabel,5)
    .widthIs(40)
    .heightIs(20);
    
    
    _iconImage.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(_dateLabel, 20)
    .widthIs(60)
    .heightIs(60);
    
    _monneyLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(_iconImage, 20)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(30);
    
    
    _descLabel.sd_layout
    .topSpaceToView(_monneyLabel,0)
    .leftSpaceToView(_iconImage, 20)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(30);
    
    _line.sd_layout
    .bottomSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
    
    _statusLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 30)
    .widthIs(80)
    .heightIs(20);
    _statusLabel.textAlignment = NSTextAlignmentRight;
    
    _statusLabel.hidden = YES;
    
    
}
-(void)setModel:(DriverAccountListModel *)model{
    _model = model;
    
    _dateLabel.text = model.date;
    
    if ([model.date isEqualToString:@"今天"] || [model.date isEqualToString:@"昨天"]){
        
       _timeLabel.text = [model.bill_time substringWithRange:NSMakeRange(11, 5)];
        
    }else{
        
        _timeLabel.text = [model.bill_time substringWithRange:NSMakeRange(5, 5)];

    }
    /** 😀*/
    [_iconImage setImageWithURL: [NSURL URLWithString:model.b_status] placeholder:[UIImage imageNamed:@"default_icon"]];
    
    if ([model.b_status isEqualToString:@"收入"]) {
        _monneyLabel.text = [NSString stringWithFormat:@"+%@",model.bill_money];
    }
    
    if ([model.b_status isEqualToString:@"支出"]) {
        _monneyLabel.text = [NSString stringWithFormat:@"-%@",model.bill_money];
    }

    _descLabel.text = model.f_name;
    
    if ([model.f_name isEqualToString:@"提现"]) {
        _statusLabel.hidden = NO;
        if ([model.r_status isEqualToString:@"0"]) {
            _statusLabel.text = @"处理中";
            _statusLabel.textColor = BASE_YELLOW;
        }
        if ([model.r_status isEqualToString:@"1"]) {
            _statusLabel.text = @"审核不通过";
            _statusLabel.textColor = [UIColor redColor];
        }
        if ([model.r_status isEqualToString:@"2"]) {
            _statusLabel.text = @"审核通过";
            _statusLabel.textColor = FONT_LIGHT;
        }

    }else{
        _statusLabel.hidden = YES;
    }
    
}

@end
