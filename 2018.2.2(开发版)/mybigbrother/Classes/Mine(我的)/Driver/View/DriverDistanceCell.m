//
//  DriverDistanceCell.m
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "DriverDistanceCell.h"
@interface DriverDistanceCell ()
/** 订单编号*/
@property (nonatomic, strong) UILabel     *   orderNum;
/** 订单状态*/
@property (nonatomic, strong) UILabel     *   orderState;
/** 预估价格*/
@property (nonatomic, strong) UILabel     *   orderPrice;
/** 1线*/
@property (nonatomic, strong) UIView      *   line;
/** 接:出发地*/
@property (nonatomic, strong) UILabel     *   beiginStation;
/** 到:目的地*/
@property (nonatomic, strong) UILabel     *   endStation;
/** 预约日期*/
@property (nonatomic, strong) UILabel     *   orderDate;
/** 灰背景*/
@property (nonatomic, strong) UIView      *   topView;
/** 二线*/
@property (nonatomic, strong) UIView      *   line2;
/** 接*/
@property (nonatomic, strong) UIButton    *   come;
/* */
@property (nonatomic, strong) UIView      *   give;
/** 三线*/
@property (nonatomic, strong) UIView      *   line3;
/** 打电话*/
@property (nonatomic, strong) UILabel     *   callCustomer;

@property (nonatomic, strong) UIImageView *    phoneImage ;
/*********** 操作************/
@property (nonatomic, strong) UIButton * firstOperation;

@property (nonatomic, strong) UIButton * secondOperation;

@end

@implementation DriverDistanceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = BASE_VC_COLOR;
    _topView = topView;

    UILabel * orderNum = [[UILabel alloc]init];
    orderNum.font = MBBFONT(15);
    orderNum.textColor = FONT_DARK;
    _orderNum = orderNum;
    
    UILabel * orderState = [[UILabel alloc]init];
    orderState.font = MBBFONT(15);
    orderState.textColor = MBBCOLOR(25, 165, 58);

    _orderState = orderState;
    
    UILabel * orderPrice = [[UILabel alloc]init];
    orderPrice.font = MBBFONT(15);
    orderPrice.textColor = MBBHEXCOLOR(0xfdb400);

    _orderPrice = orderPrice;
    
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    _line = line;
    
    
    
    UIButton * come = [[UIButton alloc]init];
    [come setTitle:@"接" forState:UIControlStateNormal];
    [come setBackgroundImage:[UIImage imageWithColor:MBBCOLOR(25, 165, 58)] forState:UIControlStateNormal];
    [come.titleLabel setFont:MBBFONT(15)];
    come.clipsToBounds = YES;
    come.userInteractionEnabled = NO;
    come.layer.cornerRadius = 10;
    _come = come;
    
    UILabel * beginStation = [[UILabel alloc]init];
    beginStation.font = MBBFONT(15);
    _beiginStation = beginStation;
    
    UIButton * give = [[UIButton alloc]init];
    [give setTitle:@"送" forState:UIControlStateNormal];
    [give setBackgroundImage:[UIImage imageWithColor:MBBCOLOR(250, 82, 97)] forState:UIControlStateNormal];
    [give.titleLabel setFont:MBBFONT(15)];
    give.clipsToBounds = YES;
    give.userInteractionEnabled = NO;
    give.layer.cornerRadius = 10;

    _give = give;
    
    UILabel * endStation = [[UILabel alloc]init];
    endStation.font = MBBFONT(15);
    endStation.textColor = FONT_DARK;
    _endStation = endStation;
    
    
    UIView * line2 = [[UIView alloc]init];
    line2.backgroundColor = BASE_CELL_LINE_COLOR;
    _line2 = line2;
    
    UILabel * orderDate = [[UILabel alloc]init];
    orderDate.font = MBBFONT(15);
    orderDate.textColor = FONT_DARK;
    _orderDate = orderDate;
    
    
    UIView * line3 = [[UIView alloc]init];
    line3.backgroundColor = BASE_CELL_LINE_COLOR;
    _line3 = line3;

    UILabel * callCustomer = [[UILabel alloc]init];
    callCustomer.text = @"联系顾客";
    callCustomer.font = MBBFONT(15);
    callCustomer.textColor = FONT_DARK;
    callCustomer.textAlignment = NSTextAlignmentCenter;
    _callCustomer = callCustomer;

    
    UIImageView * phoneImage = [[UIImageView alloc]init];
    phoneImage.image = [UIImage imageNamed:@"customer_phone"];
    _phoneImage = phoneImage;
    
    /******* 操作 ******/
    UIButton * firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstBtn setBackgroundImage:[UIImage imageWithColor:MBBCOLOR(25, 165, 58)] forState:UIControlStateNormal];
    firstBtn.clipsToBounds = YES;
    firstBtn.layer.cornerRadius = 3;
    [firstBtn.titleLabel setFont:MBBFONT(15)];
    _firstOperation = firstBtn;
    
    UIButton * secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [secondBtn setBackgroundImage:[UIImage imageWithColor:MBBCOLOR(25, 165, 58)] forState:UIControlStateNormal];
    secondBtn.clipsToBounds = YES;
    secondBtn.layer.cornerRadius = 3;
    [secondBtn.titleLabel setFont:MBBFONT(15)];

    _secondOperation = secondBtn;


    
    [self layoutAllSubviews];
    
}
- (void)layoutAllSubviews{
    NSArray * subViews = @[_topView,
                           _line,
                           _line2,
                           _endStation,
                           _beiginStation,
                           _come,
                           _give,
                           _orderNum,
                           _orderDate,
                           _orderPrice,
                           _orderState,
                           _line3,
                           _callCustomer,
                           _firstOperation,
                           _secondOperation,
                           _phoneImage,
                           ];
    
    UIView * contentView = self.contentView;
    [contentView sd_addSubviews:subViews];
    
    _topView.sd_layout
    .topSpaceToView(contentView,0)
    .leftSpaceToView(contentView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(10);
    
    _orderNum.sd_layout
    .topSpaceToView(_topView,10)
    .leftSpaceToView(contentView,10)
    .widthIs(SCREEN_WIDTH-20)
    .heightIs(20);
    
    _orderState.sd_layout
    .topSpaceToView(_orderNum,5)
    .leftSpaceToView(contentView,10)
    .widthIs(SCREEN_WIDTH)
    .heightIs(20);
    
    _orderPrice.sd_layout
    .topEqualToView(_orderState)
    .rightSpaceToView(contentView,10)
    .widthIs(SCREEN_WIDTH)
    .heightIs(20);
    _orderPrice.textAlignment = NSTextAlignmentRight;
    
    
    
    _line.sd_layout
    .topSpaceToView(_orderState,5)
    .leftSpaceToView(contentView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
    
    
    /** 接*/
    _come.sd_layout
    .topSpaceToView(_line,10)
    .leftSpaceToView(contentView,10)
    .widthIs(20)
    .heightIs(20);
    
    /** 出发点*/
    _beiginStation.sd_layout
    .topSpaceToView(_line,10)
    .leftSpaceToView(_come,10)
    .widthIs(SCREEN_WIDTH - 40)
    .heightIs(20);

    /** 送*/
    _give.sd_layout
    .topSpaceToView(_come,10)
    .leftSpaceToView(contentView,10)
    .widthIs(20)
    .heightIs(20);
    
    /** 到达点*/
    _endStation.sd_layout
    .topSpaceToView(_come,10)
    .leftSpaceToView(_give,10)
    .widthIs(SCREEN_WIDTH - 40)
    .heightIs(20);
    
    
    _line2.sd_layout
    .topSpaceToView(_give,15)
    .leftSpaceToView(contentView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
    
    
    _orderDate.sd_layout
    .topSpaceToView(_line2,5)
    .leftSpaceToView(contentView,10)
    .widthIs(SCREEN_WIDTH)
    .heightIs(30);
    
    
    _line3.sd_layout
    .topSpaceToView(_orderDate,5)
    .leftSpaceToView(contentView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
    
    _phoneImage.sd_layout
    .topSpaceToView(_line3, 10)
    .leftSpaceToView(self.contentView, SCREEN_WIDTH/2 - 60)
    .widthIs(20)
    .heightIs(20);
    
    
    _callCustomer.sd_layout
    .topSpaceToView(_line3,10)
    .leftSpaceToView(contentView,10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(20);
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(makeCallTap)];
    _callCustomer.userInteractionEnabled = YES;
    [_callCustomer addGestureRecognizer:tap];
    
    /*********** 操作**********/
    _firstOperation.sd_layout
    .topEqualToView(_endStation)
    .rightSpaceToView(self.contentView, 10)
    .widthIs(60)
    .heightIs(30);
    
    
    _secondOperation.sd_layout
    .topEqualToView(_orderDate)
    .rightSpaceToView(self.contentView, 10)
    .widthIs(60)
    .heightIs(30);
    
    _secondOperation.hidden = YES;
    _firstOperation.hidden = YES;
    
    [_firstOperation addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_secondOperation addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    
}
- (void)setModel:(DriverOrderModel *)model{
    _model = model;
//    NSLog(@"%@",  model.contacts);
    _orderNum.text = [NSString stringWithFormat:@"订单编号:%@",model.or_number];
    _beiginStation.text = model.meet;
    _endStation.text = model.give;
    _orderDate.text = [NSString stringWithFormat:@"预约日期:%@",model.a_time];

    /** t_status*/
    if([model.t_status isEqualToString:@"0"]){
        _orderState.text = @"订单状态:未预约";
        
        _firstOperation.hidden = NO;
        _secondOperation.hidden = NO;

        [_firstOperation setTitle:@"接受" forState:UIControlStateNormal];
        [_secondOperation setTitle:@"婉拒" forState:UIControlStateNormal];
        [_secondOperation setBackgroundImage:[UIImage imageWithColor:MBBCOLOR(253, 140, 142) ]forState:UIControlStateNormal];
        
        _firstOperation.tag = KDriverOperationAccept;
        _secondOperation.tag = KDriverOperationRefuse;

    }else{
        
        /** status*/
        if ([model.status isEqualToString:@"0"]) {
            _orderState.text = @"订单状态:已预约";
            _firstOperation.hidden = YES;
            _secondOperation.hidden = NO;
            [_secondOperation setTitle:@"出发" forState:UIControlStateNormal];
            
            _secondOperation.tag = KDriverOperationSetout;
            
            
        }
        if ([model.status isEqualToString:@"1"]) {
            _orderState.text = @"订单状态:进行中";
            _firstOperation.hidden = NO;
            _secondOperation.hidden = NO;
            [_firstOperation setBackgroundImage:[UIImage imageWithColor:MBBCOLOR(252, 128, 56)] forState:UIControlStateNormal];
            [_firstOperation setTitle:@"接到" forState:UIControlStateNormal];
            [_secondOperation setTitle:@"送达" forState:UIControlStateNormal];
            
            _firstOperation.tag = KDriverOperationReceive;
            _secondOperation.tag = KDriverOperationDelived;
            
        }
        if ([model.status isEqualToString:@"2"]) {
            _orderState.text = @"订单状态:已完成";
            _firstOperation.hidden = YES;
            _secondOperation.hidden = YES;
            
        }
    }
    
    
    NSAttributedString * str = [MyControl originalStr:_orderState.text position:3 color:FONT_DARK];
    _orderState.attributedText = str;
    
    _orderPrice.text = [NSString stringWithFormat:@"预估:%@元",model.or_price];
    NSAttributedString * priceStr = [MyControl originalStr:_orderPrice.text position:_orderPrice.text.length - 3 color:FONT_DARK];
    _orderPrice.attributedText = priceStr;
}
- (void)makeCallTap{
    if ([self.distanceCellDelegate respondsToSelector:@selector(makeCallToCustomerTap:)]) {
        [self.distanceCellDelegate makeCallToCustomerTap:self.model];
    }
}
- (void)operationButtonClicked:(UIButton * )button{
    if ([self.distanceCellDelegate respondsToSelector:@selector(driverOperationOrder:orderModel:)]) {
        [self.distanceCellDelegate driverOperationOrder:button.tag orderModel:self.model];
    }
}
@end
