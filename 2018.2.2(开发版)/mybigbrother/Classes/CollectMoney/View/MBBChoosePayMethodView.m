//
//  MBBChoosePayMethodView.m
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBChoosePayMethodView.h"
#import "MBBPayCellView.h"

@interface MBBChoosePayMethodView ()
@property(nonatomic, strong) NSMutableArray * allPayButtonsArray;
@property(nonatomic, assign) NSInteger payMethod;
@end

@implementation MBBChoosePayMethodView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
   
    self.backgroundColor = [UIColor whiteColor];
    
    NSArray * methods = [NSArray array];
    methods = @[
               @{@"name" :@"支付宝支付",
                 @"image":@"zhifubao",
                 @"tag"  :@(KPayUseAlipay)},
               @{@"name" :@"微信支付",
                 @"image":@"weixin",
                 @"tag"  :@(KPayUseWeixin)}];
    
    _allPayButtonsArray =[NSMutableArray array];
    for (int i = 0 ;  i < methods.count; i ++) {
        MBBPayCellView * payCell = [[MBBPayCellView alloc]initWithFrame:CGRectMake(0, 44*i, SCREEN_WIDTH, 44)
                                                                          methodImage:methods[i][@"image"]
                                                                           methodName:methods[i][@"name"]];
        payCell.tag = [methods[i][@"tag"] integerValue];;
        [self addSubview:payCell];
        
        [_allPayButtonsArray addObject:payCell.chooseBtn];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPaycellView:)];
        payCell.userInteractionEnabled = YES;
        [payCell addGestureRecognizer:tap];
        
        if (i == 0) {
            payCell.chooseBtn.selected = YES;
            /** 确保默认选中的支付方式*/
            [self tapPaycellView:tap];
        }
        
    }
    
    UIView * bgView =[[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    
    bgView.frame = CGRectMake(0, 89, SCREEN_WIDTH, 44);
    [self addSubview:bgView];
    
    
    UILabel * rightDiscount = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2,
                                                                 10,
                                                                 SCREEN_WIDTH/2 - 40,
                                                                 24)];
    rightDiscount.font = MBBFONT(15);
    rightDiscount.textColor = FONT_DARK;
    [bgView addSubview:rightDiscount];
    rightDiscount.textAlignment = NSTextAlignmentRight;
    _rightDiscount = rightDiscount;

    
    UIImageView * titleImage = [[UIImageView alloc]init];
    titleImage.image = [UIImage imageNamed:@"pay_coupons"];
    titleImage.frame = CGRectMake(10, 10,24, 24);
    [bgView addSubview:titleImage];

    UIImageView * rightImage = [[UIImageView alloc]init];
    rightImage.image = [UIImage imageNamed:@"home_arrow"];
    rightImage.frame = CGRectMake(SCREEN_WIDTH - 35, 10, 10, 20);
    [bgView addSubview:rightImage];
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    line.frame = CGRectMake(0, 44, SCREEN_WIDTH, 0.5);
    [bgView addSubview:line];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCouponView)];
    bgView.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:tap];
    
}
- (void)tapPaycellView:(UITapGestureRecognizer *)tap{
    
    for (UIButton *btn in _allPayButtonsArray) {
        btn.selected = NO;
    }
    MBBPayCellView * payCell = (MBBPayCellView *)tap.view;
    payCell.chooseBtn.selected = YES;
    _payMethod = payCell.tag;
    [self chooseMethodAction];
}
-(void)chooseMethodAction{
    if ([self.delegate respondsToSelector:@selector(makeSurePayMethod:)]) {
        [self.delegate makeSurePayMethod:_payMethod];
    }
}
-(void)tapCouponView{
    if ([self.delegate respondsToSelector:@selector(tapCouponView)]) {
        [self.delegate tapCouponView];
    }
}

@end
