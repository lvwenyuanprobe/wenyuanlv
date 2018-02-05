//
//  DetailReplyCell.m
//  mybigbrother
//
//  Created by SN on 2017/4/1.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "DetailReplyCell.h"

@interface DetailReplyCell ()

@property (nonatomic, strong) UIImageView *   icon;
@property (nonatomic, strong) UILabel *   nickName;
@property (nonatomic, strong) UILabel *   date;
@property (nonatomic, strong) UILabel *   planeNum;
@property (nonatomic, strong) UILabel *   operation;
@property (nonatomic, strong) UIView  *   line;
@property (nonatomic, strong) UIImageView *   report;

@property (nonatomic, strong) UIView * reportView;
@end
@implementation DetailReplyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViews{
    UIView * lowView = self.contentView;
    
    UIImageView * icon = [[UIImageView alloc]init];
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.clipsToBounds = YES;
    
    UILabel * nickName = [[UILabel alloc]init];
    nickName.font = MBBFONT(15);
    nickName.textColor = FONT_DARK;
    
    
    UILabel * date = [[UILabel alloc]init];
    date.font = MBBFONT(10);
    date.textColor = FONT_LIGHT;
    
    
    UILabel * planeNum = [[UILabel alloc]init];
    planeNum.font = MBBFONT(12);
    planeNum.textColor = FONT_DARK;

    
    UILabel * operationView = [[UILabel alloc]init];
    operationView.font = MBBFONT(12);
    operationView.textColor = [UIColor blueColor];
    operationView.text = @"回复";
    operationView.textAlignment = NSTextAlignmentCenter;
    
    UIImageView * report = [[UIImageView alloc]init];
    report.image = [UIImage imageNamed:@"home_comment"];
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    
    UIView * reportView = [[UIView alloc]init];
    
    
    _line = line ;
    _icon = icon;
    _nickName = nickName ;
    _date = date;
    _planeNum = planeNum;
//    _operation = operationView;
    
    _report = report;
    
    _reportView = reportView;
    
    
    
    
    NSArray * subViews = @[_icon,
                           _nickName,
                           _date,
                           _planeNum,
//                           _operation,
                           _line,
                           _report,
                           _reportView
                           ];
    [lowView sd_addSubviews:subViews];
    
    _icon.sd_layout
    .topSpaceToView (lowView,10)
    .leftSpaceToView(lowView,10)
    .widthIs(50)
    .heightIs(50);
    
    
    _nickName.sd_layout
    .topSpaceToView (lowView,10)
    .leftSpaceToView(_icon,10)
    .widthIs(SCREEN_WIDTH - 70)
    .heightIs(15);
    
    _date.sd_layout
    .topSpaceToView (_nickName,10)
    .leftSpaceToView(_icon,10)
    .widthIs(SCREEN_WIDTH - 70)
    .heightIs(10);
    
    _planeNum.sd_layout
    .topSpaceToView (_date,10)
    .leftSpaceToView(_icon,10)
    .widthIs(SCREEN_WIDTH - 80)
    .autoHeightRatio(0);
    
    
    _report.sd_layout
    .bottomSpaceToView(lowView,10)
    .rightSpaceToView(lowView,15)
    .widthIs(13)
    .heightIs(12);
    
    _reportView.sd_layout
    .bottomSpaceToView(lowView,0)
    .rightSpaceToView(lowView,0)
    .widthIs(50)
    .heightIs(50);
    
//    _operation.sd_layout
//    .topSpaceToView (lowView,5)
//    .rightSpaceToView(_report,5)
//    .widthIs(20)
//    .heightIs(20);


    
    _line.sd_layout
    .bottomSpaceToView(lowView, 0)
    .leftSpaceToView(lowView, 20)
    .widthIs(SCREEN_WIDTH - 30)
    .heightIs(0.5);
    
    
    _icon.clipsToBounds = YES;
    _icon.layer.cornerRadius = 25;
    _operation.userInteractionEnabled = YES;
    _report.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(operationClicked)];
    [_reportView addGestureRecognizer:tap];
    
//    UITapGestureRecognizer * reportTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reportClicked)];
//    [_report addGestureRecognizer:reportTap];
    
    UITapGestureRecognizer * iconTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTap)];
    _icon.userInteractionEnabled = YES;
    [_icon addGestureRecognizer:iconTap];

    

    
}
- (void)iconTap{
    if ([self.delegate respondsToSelector:@selector(scanReplyUserPersonInfo:)]) {
        [self.delegate scanReplyUserPersonInfo:self.model];
    }
}
-(void)setModel:(CommentModel *)model{
    _model = model;
    
     MBBUserInfoModel * usermodel = [MBBToolMethod fetchUserInfo];
    if (usermodel.user.uid == model.put) {
        _report.hidden = YES;
        _reportView.hidden = YES;
    }else{
        _report.hidden = NO;
        _reportView.hidden = NO;

    }
    
    [_icon setImageWithURL: [NSURL URLWithString:model.put_img] placeholder:[UIImage imageNamed:@"default_icon"]];
    _nickName.text = model.put_id;
    _planeNum.text = model.com_content;
    _date.text = model.add_time;
    
    if (model.reply_id) {
        NSAttributedString * p2 = [[NSAttributedString alloc] initWithString:model.reply_id
                                                                  attributes:@{NSForegroundColorAttributeName:MBBCOLOR(33, 198, 200)}];
        NSAttributedString * p3 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@": %@",model.com_content]];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"回复 "];
        [attributedString appendAttributedString:p2];
        [attributedString appendAttributedString:p3];
        _planeNum.attributedText = attributedString;
        [_planeNum sizeToFit];
    }
    _planeNum.sd_layout.maxHeightIs(_planeNum.font.lineHeight * 2.05);
}
- (void)operationClicked{
    if ([self.delegate respondsToSelector:@selector(operationReply:)]) {
        [self.delegate operationReply:self.model];
    }
}

- (void)reportClicked{
    if ([self.delegate respondsToSelector:@selector(reportUserContent:)]) {
        [self.delegate reportUserContent:self.model];
    }
}
@end
