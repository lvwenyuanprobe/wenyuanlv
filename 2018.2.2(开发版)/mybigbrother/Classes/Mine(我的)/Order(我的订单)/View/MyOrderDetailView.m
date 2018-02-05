//
//  MyOrderDetailView.m
//  mybigbrother
//
//  Created by SN on 2017/4/18.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MyOrderDetailView.h"
#import "MyOrderDetailModel.h"
@interface MyOrderDetailView()

@property (nonatomic, strong) UILabel *   orderNumber;
@property (nonatomic, strong) UILabel *   orderTime;
@property (nonatomic, strong) UILabel *   orderPayType;
@property (nonatomic, strong) UILabel *   orderPhone;

@end

@implementation MyOrderDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}

- (void)setUpUI{
    UILabel * orderNumber = [[UILabel alloc]init];
    orderNumber.textColor = FONT_LIGHT;
    orderNumber.font = MBBFONT(15);
    [self addSubview:orderNumber];

    UILabel * orderTime = [[UILabel alloc]init];
    orderTime.textColor = FONT_LIGHT;
    orderTime.font = MBBFONT(15);
    [self addSubview:orderTime];
    
    UILabel * orderPayType = [[UILabel alloc]init];
    orderPayType.textColor = FONT_LIGHT;
    orderPayType.font = MBBFONT(15);
    [self addSubview:orderPayType];
    
    UILabel * orderPhone = [[UILabel alloc]init];
    orderPhone.textColor = FONT_LIGHT;
    orderPhone.font = MBBFONT(15);
    [self addSubview:orderPhone];
    
    _orderNumber = orderNumber;
    _orderTime = orderTime;
    _orderPhone = orderPhone;
    _orderPayType = orderPayType;
    
    _orderNumber.sd_layout
    .topSpaceToView(self, 10)
    .leftSpaceToView(self, 10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(24);
    
    _orderTime.sd_layout
    .topSpaceToView(_orderNumber, 10)
    .leftSpaceToView(self, 10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(24);
    
    _orderPayType.sd_layout
    .topSpaceToView(_orderTime, 10)
    .leftSpaceToView(self, 10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(24);
    
    _orderPhone.sd_layout
    .topSpaceToView(_orderPayType, 10)
    .leftSpaceToView(self, 10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(24);
}

-(void)setModel:(MyOrderDetailModel *)model{
    _model = model;
    
    _orderNumber.text = [NSString stringWithFormat:@"订单编号: %@", model.or_number];
    
    _orderTime.text = [NSString stringWithFormat:@"下单时间: %@", model.or_addtime];

//    _orderPayType.text = [NSString stringWithFormat:@"支付方式: 在线支付", model.or_number];

    _orderPayType.text = @"支付方式: 在线支付";
    
    
//    _orderPhone.text = [NSString stringWithFormat:@"手机号码: %@", model.or_number];

//    _orderPhone.text = @"手机号码:";
    
    
    
}
@end
