//
//  DriverGetCashMethodChooseController.m
//  mybigbrother
//
//  Created by SN on 2017/5/11.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "DriverGetCashMethodChooseController.h"
#import "MBBPayCellView.h"

@interface DriverGetCashMethodChooseController ()
@property(nonatomic, strong) NSMutableArray * allPayButtonsArray;
@property(nonatomic, assign) NSInteger payMethod;

@end

@implementation DriverGetCashMethodChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择提现方式";
    NSArray * methods = [NSArray array];
    methods = @[
                @{@"name" :@"支付宝",
                  @"image":@"zhifubao",
                  @"tag"  :@(KGetCashAlipay)},
                @{@"name" :@"微信",
                  @"image":@"weixin",
                  @"tag"  :@(KGetCashWeixin)}];
    
    _allPayButtonsArray =[NSMutableArray array];
    for (int i = 0 ;  i < methods.count; i ++) {
        MBBPayCellView * payCell = [[MBBPayCellView alloc]initWithFrame:CGRectMake(0, 44*i, SCREEN_WIDTH, 44)
                                                            methodImage:methods[i][@"image"]
                                                             methodName:methods[i][@"name"]];
        payCell.tag = [methods[i][@"tag"] integerValue];;
        [self.view addSubview:payCell];
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
    
    /** 确认提现*/
    UIButton * getCrash = [[UIButton alloc] init];
    [getCrash setTitle:@"确认提现" forState:UIControlStateNormal];
    [getCrash setBackgroundImage:[UIImage imageWithColor:BUTTON_COLOR] forState:UIControlStateNormal];
    [getCrash addTarget:self action:@selector(chooseMethodAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getCrash];
    
    getCrash.sd_layout
    .topSpaceToView(self.view,88 + 100)
    .leftSpaceToView(self.view , 20)
    .widthIs(SCREEN_WIDTH - 40)
    .heightIs(44);
    getCrash.sd_cornerRadius = @(5);

    
}

- (void)tapPaycellView:(UITapGestureRecognizer *)tap{
    for (UIButton *btn in _allPayButtonsArray) {
        btn.selected = NO;
    }
    MBBPayCellView * payCell = (MBBPayCellView *)tap.view;
    payCell.chooseBtn.selected = YES;
    _payMethod = payCell.tag;
}

-(void)chooseMethodAction{
    
    self.chooseMethodBlock(_payMethod);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
