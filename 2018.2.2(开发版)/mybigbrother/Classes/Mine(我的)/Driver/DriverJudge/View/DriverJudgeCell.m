//
//  DriverJudgeCell.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "DriverJudgeCell.h"
#import "DriverStarsView.h"

@interface DriverJudgeCell ()

@property (nonatomic, strong) UIImageView *   icon;
@property (nonatomic, strong) UILabel *   nickName;
@property (nonatomic, strong) UILabel *   date;
@property (nonatomic, strong) UILabel *   content;

@property (nonatomic, strong) DriverStarsView * stars ;

@property (nonatomic, strong) UIView * line;
@end

@implementation DriverJudgeCell

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
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.clipsToBounds = YES;
    
    UILabel * nickName = [[UILabel alloc]init];
    nickName.text = @"夏天的风";
    nickName.font = MBBFONT(15);
    nickName.textColor = FONT_DARK;
    
    
    UILabel * content = [[UILabel alloc]init];
    content.text = @"好啊人生若只初相见,司机好帅当当,嘿嘿";
    content.font = MBBFONT(15);
    content.textColor = FONT_DARK;
   
    UILabel * date = [[UILabel alloc]init];
    date.text = @"今天02:38";
    date.font = MBBFONT(12);
    date.textColor = FONT_LIGHT;

    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    
    

    DriverStarsView * starView = [[DriverStarsView alloc]initWithFrame:CGRectMake(0, 0, 120, 20) starCount:0];
    
    _icon = icon;
    _nickName = nickName ;
    _date = date;
    _content = content;
    _stars = starView;
    _line = line;
    
    NSArray * subViews = @[_icon,
                           _nickName,
                           _date,
                           _content,
                           _stars,
                           _line,
                           ];
    [lowView sd_addSubviews:subViews];
    
    _icon.sd_layout
    .topSpaceToView (lowView,10)
    .leftSpaceToView(lowView,10)
    .widthIs(50)
    .heightIs(50);
    
    
    _nickName.sd_layout
    .topSpaceToView (lowView,25)
    .leftSpaceToView(_icon,10)
    .widthIs(SCREEN_WIDTH - 70)
    .heightIs(15);
    
    
    _content.sd_layout
    .topSpaceToView (_icon,10)
    .leftSpaceToView(lowView,10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(20);
    
    _date.sd_layout
    .topSpaceToView (_content,20)
    .leftSpaceToView(lowView,10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(10);

    
    _stars.sd_layout
    .topSpaceToView (lowView,10)
    .rightSpaceToView(lowView,10)
    .widthIs(100 + 20)
    .heightIs(20);
    
    _line.sd_layout
    .bottomSpaceToView(lowView, 0)
    .widthIs(SCREEN_WIDTH)
    .leftSpaceToView(lowView, 0)
    .heightIs(0.5);
    
    
    _icon.clipsToBounds = YES;
    _icon.layer.cornerRadius = 25;
    
}
-(void)setModel:(DriverJudgeCellModel *)model{
    _model = model;
    
    [_icon setImageWithURL: [NSURL URLWithString:model.u_img] placeholder:[UIImage imageNamed:@"default_icon"]];
    
    [_stars addStartCount:[model.th_total integerValue]];
    
    _nickName.text = model.u_nickname;
    
    _content.text = model.th_con;
    
    
    _date.text = model.th_time;
}

@end
