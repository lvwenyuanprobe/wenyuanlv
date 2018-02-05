//
//  MBBCouponCell.m
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBCouponCell.h"
#import "CouponCellModel.h"
@interface MBBCouponCell ()
@property (nonatomic, strong) UIImageView *   bgView;

/** 折扣*/
@property (nonatomic, strong) UILabel *    price;
/** 起始时间*/
@property (nonatomic, strong) UILabel *    dateBegin;
/** 结束时间*/
@property (nonatomic, strong) UILabel *    dateEnd ;

/** numb*/
@property (nonatomic, strong) UILabel *    number;

@end

@implementation MBBCouponCell

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
    
    UIImageView * bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"coupon_red"];
    [lowView addSubview:bgView];
    _bgView = bgView;
    

    
    bgView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(5, 20, 5, 20));
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"我的大师兄";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = MBBFONT(18);
    
    
    UILabel * price = [[UILabel alloc]init];
    price.textColor = [UIColor whiteColor];
    price.font = MBBFONT(35);

    UILabel * discount = [[UILabel alloc]init];
    discount.textColor = [UIColor whiteColor];
    discount.font = MBBFONT(12);
    
    UILabel * deadline = [[UILabel alloc]init];
    deadline.text = @"使用期限";
    deadline.textColor = [UIColor whiteColor];
    deadline.font = MBBFONT(12);

    UILabel * dateBegin = [[UILabel alloc]init];
    dateBegin.text = @"2017.2.21 00:00";
    dateBegin.textColor = [UIColor whiteColor];
    dateBegin.font = MBBFONT(12);

    UILabel * dateEnd = [[UILabel alloc]init];
    dateEnd.text = @"2017.2.21 00:00";
    dateEnd.textColor = [UIColor whiteColor];
    dateEnd.font = MBBFONT(12);
 
    UIButton * chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:chooseBtn];
    chooseBtn.clipsToBounds = YES;
    chooseBtn.layer.cornerRadius = 10;
    chooseBtn.userInteractionEnabled = NO;
    [chooseBtn setBackgroundImage:[UIImage imageNamed:@"paySelectNormal"]forState:UIControlStateNormal];
    [chooseBtn setBackgroundImage:[UIImage imageNamed:@"paySelected"]forState:UIControlStateSelected];
    
    chooseBtn.sd_layout.topSpaceToView(self.contentView, 55)
    .rightSpaceToView(self.contentView, 10)
    .widthIs(20)
    .heightIs(20);
    chooseBtn.hidden = YES;
    _chooseBtn = chooseBtn;
    
    [bgView addSubview:titleLabel];
    [bgView addSubview:price];
    [bgView addSubview:discount];
    [bgView addSubview:deadline];
    [bgView addSubview:dateBegin];
    [bgView addSubview:dateEnd];


    titleLabel.sd_layout
    .topSpaceToView(bgView,10)
    .leftSpaceToView(bgView,0)
    .widthIs(SCREEN_WIDTH - 40)
    .heightIs(30);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    price.sd_layout
    .bottomSpaceToView(bgView,20)
    .leftSpaceToView(bgView,10)
    .widthIs(SCREEN_WIDTH - 40)
    .heightIs(80);
    
    
    discount.sd_layout
    .bottomSpaceToView(bgView,0)
    .leftSpaceToView(bgView,10)
    .widthIs(SCREEN_WIDTH - 40)
    .heightIs(20);

    
    deadline.sd_layout
    .bottomSpaceToView(bgView,40)
    .rightSpaceToView(bgView,10)
    .widthIs(SCREEN_WIDTH - 40)
    .heightIs(20);
    deadline.textAlignment = NSTextAlignmentRight;
    
    dateBegin.sd_layout
    .bottomSpaceToView(bgView,20)
    .rightSpaceToView(bgView,10)
    .widthIs(SCREEN_WIDTH - 40)
    .heightIs(20);
    dateBegin.textAlignment = NSTextAlignmentRight;

    dateEnd.sd_layout
    .bottomSpaceToView(bgView,0)
    .rightSpaceToView(bgView,10)
    .widthIs(SCREEN_WIDTH - 40)
    .heightIs(20);
    dateEnd.textAlignment = NSTextAlignmentRight;
    
    _price = price;
    _dateBegin = dateBegin;
    _dateEnd = dateEnd;
    _number = discount;

}
/** */
- (void)setModel:(CouponCellModel *)model{
    _model = model;
    _price.text = [NSString stringWithFormat:@"%@折券",model.co_price];
    _dateBegin.text = model.start_time;
    _dateEnd.text = model.end_time;
    
    _number.text =[NSString stringWithFormat:@"%@张", model.co_number];
}

-(void)setCouponStatus:(NSNumber *)couponStatus{
    
    if ([couponStatus isEqualToNumber: @(1)]) {
        _bgView.image = [UIImage imageNamed:@"coupon_red"];
    }else{
        _bgView.image = [UIImage imageNamed:@"coupon_gray"];

    }
}
- (void)setChoose:(NSNumber *)choose{
    if ([choose isEqualToNumber:@(0)]) {
        _bgView.sd_layout
        .spaceToSuperView(UIEdgeInsetsMake(5, 20, 5, 60));
        _chooseBtn.hidden = NO;
        
    }else{
        
    }
}
@end
