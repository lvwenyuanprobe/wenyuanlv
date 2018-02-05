//
//  MyOrderDetailController.m
//  mybigbrother
//
//  Created by SN on 2017/4/18.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MyOrderDetailController.h"
#import "MyOrderDetailView.h"
#import "MyOrderDetailModel.h"
#import "MBBMyJudgeController.h"
#import "MBBCollectMoneyController.h"

@interface MyOrderDetailController ()
@property (nonatomic, strong) UILabel * status;
@property (nonatomic, strong) UILabel * price;
@property (nonatomic, strong) UILabel * content;
@property (nonatomic, strong) UIImageView * leftImage;
@property (nonatomic, strong) MyOrderDetailView * detailView ;
@end

@implementation MyOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * orderStatus = [[UILabel alloc]init];
    orderStatus.text = @"订单状态";
    orderStatus.textColor = FONT_LIGHT;
    orderStatus.font = MBBFONT(15);
    [self.view addSubview:orderStatus];
    
    UILabel * status = [[UILabel alloc]init];
    status.textColor = [UIColor redColor];
    status.font = MBBFONT(15);
    [self.view addSubview:status];
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self.view addSubview:line];
    
    orderStatus.sd_layout
    .topSpaceToView(self.view, 10)
    .leftSpaceToView(self.view , 10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(20);
    
    status.sd_layout
    .topSpaceToView(self.view, 10)
    .rightSpaceToView(self.view , 10)
    .widthIs(SCREEN_WIDTH - 20)
    .heightIs(20);
    status.textAlignment = NSTextAlignmentRight;
    
    line.sd_layout
    .topSpaceToView(status, 10)
    .leftSpaceToView(self.view , 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
    

    UIImageView * leftImage = [[UIImageView alloc]init];
    [self.view addSubview:leftImage];

    UILabel * content = [[UILabel alloc]init];
    content.textColor = FONT_DARK;
    content.font = MBBFONT(15);
    [self.view addSubview:content];

    UILabel * price = [[UILabel alloc]init];
    price.textColor = FONT_DARK;
    price.font = MBBFONT(15);
    [self.view addSubview:price];
    
    
    UIView * line2 = [[UIView alloc]init];
    line2.backgroundColor = BASE_CELL_LINE_COLOR;
    [self.view addSubview:line2];
    
    leftImage.sd_layout
    .topSpaceToView(line, 10)
    .leftSpaceToView(self.view , 10)
    .widthIs(100)
    .heightIs(100);

    
    price.sd_layout
    .topSpaceToView(line, 10)
    .rightSpaceToView(self.view , 10)
    .widthIs(100)
    .heightIs(20);
    
    content.sd_layout
    .topEqualToView(leftImage)
    .leftSpaceToView(leftImage , 10)
    .rightSpaceToView(price, 10)
    .heightIs(20);
    
    line2.sd_layout
    .topSpaceToView(leftImage, 10)
    .leftSpaceToView(self.view, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
    
    MyOrderDetailView * detailView = [[MyOrderDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10 + 24 * 4 + 30)];
    [self.view addSubview:detailView];
    detailView.sd_layout
    .topSpaceToView(line2, 10)
    .leftSpaceToView(self.view, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(10 + 24 * 4 + 30);
    
    _status = status;
    _content = content;
    _price = price;
    _leftImage = leftImage;
    _detailView = detailView;
    [self fetchOrderDetailFromServer];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:MBBHEXCOLOR(0xdd0112)] forState:UIControlStateNormal];
    [btn.titleLabel setFont:MBBFONT(15)];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 3;
    [self.view addSubview:btn];
    btn.sd_layout
    .topSpaceToView(detailView, 44)
    .leftSpaceToView(self.view, 30)
    .widthIs(SCREEN_WIDTH - 60)
    .heightIs(44);
    
    if (self.model.status == 500) {
        [btn setTitle:@"去付款" forState:UIControlStateNormal];
    }else if (self.model.status == 110) {
        [btn setTitle:@"去评价" forState:UIControlStateNormal];
    }else{
        btn.hidden = YES;
    }
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}

/** 按钮操作*/
- (void)buttonClicked:(UIButton *)button{
    if ([button.titleLabel.text isEqualToString:@"去付款"]) {
        
        MBBCollectMoneyController * collectMoney = [[MBBCollectMoneyController alloc]init];
        /** 优惠券筛选条件(缺少)*/
        collectMoney.serviceId = _detailView.model.f_id;
        collectMoney.airportId = _detailView.model.j_id;;
        collectMoney.carId = _detailView.model.car_id;;
        /** */
        collectMoney.orderId = self.model.or_id;
        
        collectMoney.orderPrice = self.model.or_price;
        
        [self.navigationController pushViewController:collectMoney animated:YES];
    
    }
    
    if ([button.titleLabel.text isEqualToString:@"去评价"]) {
        MBBMyJudgeController * JudgeVC = [[MBBMyJudgeController alloc]init];
        /** 取出*/
        JudgeVC.model = _detailView.model;
        JudgeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:JudgeVC animated:YES];
    }
}

- (void)fetchOrderDetailFromServer{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"orderorderInfo";
     MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"token"] = model.token;
    paramDic[@"or_id"] = self.model.or_id;
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager getMyOrderDetail:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            MyOrderDetailModel * model = [MyOrderDetailModel mj_objectWithKeyValues:request.responseJSONObject[@"data"]];
            
            if (model.status == 500) {
                _status.text = @"等待买家付款";
            }
            
            if (model.status == 110) {
                _status.text = @"等待买家评价";
            }
            if (model.status == 100) {
                _status.text = @"已付款进行中";
            }
            if (model.status == 555) {
                _status.text = @"已取消";
            }

            
            _price.text = [NSString stringWithFormat:@"$ %@",model.or_price];
            _content.text = model.f_name;
            _detailView.model = model;
            [_leftImage setImageWithURL: [NSURL URLWithString:model.f_img] placeholder:[UIImage imageNamed:@"default_big"]];
            
            
        }else{
        
        }
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
