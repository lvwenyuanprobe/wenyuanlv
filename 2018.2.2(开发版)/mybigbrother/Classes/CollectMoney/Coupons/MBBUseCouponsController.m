//
//  MBBUseCouponsController.m
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBUseCouponsController.h"
#import "MBBCouponCell.h"
#import "CustomServiceDetailBottomView.h"

#import "MBBVCEmptyDefaultView.h"

@interface MBBUseCouponsController ()<UITableViewDataSource,
UITableViewDelegate,
CustomServiceDetailBottomViewDelegate>
@property (nonatomic, assign) NSInteger  begin;
@property (nonatomic, assign) NSInteger  size;
@property (nonatomic, strong) NSMutableArray * publicArray;
@property (nonatomic, strong) CustomServiceDetailBottomView * bottomView;
@property (nonatomic, strong) NSIndexPath * selectIndexPath;
@property (nonatomic, strong) MBBVCEmptyDefaultView * defaultView ;

@end

@implementation MBBUseCouponsController

- (NSMutableArray *)publicArray{
    if (!_publicArray) {
        _publicArray = [NSMutableArray array];
    }
    return _publicArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"使用优惠券";
    self.publicArray = [NSMutableArray array];
    
    [self updateData];
    
    CustomServiceDetailBottomView * bottomView;
    if (kDevice_Is_iPhoneX) {
        bottomView = [[CustomServiceDetailBottomView alloc]initWithFrame:CGRectMake(0,
                                                                                    SCREEN_HEIGHT- 45,
                                                                                    SCREEN_WIDTH,
                                                                                    44)
                      
                                                              rightTitle:@"确定"];
    }else{
        bottomView = [[CustomServiceDetailBottomView alloc]initWithFrame:CGRectMake(0,
                                                                                    SCREEN_HEIGHT- 45,
                                                                                    SCREEN_WIDTH,
                                                                                    44)
                      
                                                              rightTitle:@"确定"];
    }
    
    bottomView.delegate = self;
    bottomView.servicePrice = @"使用优惠券:";
    _bottomView = bottomView;
    [self.view addSubview:bottomView];
    // Do any additional setup after loading the view.
}

-(BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}


- (void)updateData{
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (kDevice_Is_iPhoneX) {
        self.tableView.frame = CGRectMake(0, 84, SCREEN_WIDTH, SCREEN_HEIGHT - H(49));
    }else{
        self.tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - H(49));
    }
    
}
- (void)loadData{
    [self getDataSourceFromSever];
    
}
- (void)loadMoreData{
    [self getDataSourceFromSever];
}
- (void)getDataSourceFromSever{
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"indexquerycoupon";
    if(self.serviceId){
        paramDic[@"f_id"] = self.serviceId;
    }
    if(self.airportId){
        paramDic[@"j_id"] = self.airportId;
    }
    if(self.carId){
        paramDic[@"type_id"] = self.carId;
    }
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"token"] = model.token;
    
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userCheckOutCoupons:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"成功" toView:self.view];
            NSArray * models = [CouponCellModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            self.publicArray = [NSMutableArray arrayWithArray:models];
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:@"没有可用优惠券..." toView:self.view];
        }
        
        [self addVCDefaultImageViewWithSuperView:self.tableView];
        if (self.publicArray.count == 0) {
            [self showVCDefaultImageView];
            self.tableView.mj_footer.hidden = YES;
        }else{
            [self hideVCDefaultImageView];
            self.tableView.mj_footer.hidden = NO;
        }

        
    }];
    [self endRefreshAnimation];
}
#pragma mark - delegate

- (void)rihgtButtonClicked{
    if (self.selectIndexPath) {
        self.couponBackBlock(self.publicArray[self.selectIndexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDelegate - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"MBBCouponCell";
    MBBCouponCell *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[MBBCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.publicArray[indexPath.row];
    /** 选择使用*/
    cell.choose = @(0);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.selectIndexPath){
        MBBCouponCell *  cell = [tableView cellForRowAtIndexPath:self.selectIndexPath];
        cell.chooseBtn.selected = NO;
    }
    MBBCouponCell *  cell = [tableView cellForRowAtIndexPath:indexPath];
    /** 反选*/
    cell.chooseBtn.selected =  !cell.chooseBtn.selected;
    if (cell.chooseBtn.selected == YES) {
        self.selectIndexPath = indexPath;
        CouponCellModel * model = self.publicArray[indexPath.row];
        _bottomView.servicePrice =[NSString stringWithFormat:@"使用优惠券:%@折",model.co_price];

    }
}


- (void)addVCDefaultImageViewWithSuperView:(UIView *)faterView{
    MBBVCEmptyDefaultView * defaultView = [[MBBVCEmptyDefaultView alloc]initWithFrame:CGRectMake(0,
                                                                                                 SCREEN_HEIGHT/3,
                                                                                                 SCREEN_WIDTH,
                                                                                                 SCREEN_HEIGHT)
                                                                          centerImage:@"record_default"
                                                                                title:@"您没有可用的优惠券"
                                                                             subTitle:@"快来邀请好友获取吧!"];
    [faterView addSubview:defaultView];
    _defaultView = defaultView;
    [_defaultView setHidden:YES];
}

- (void)showVCDefaultImageView{
    [_defaultView setHidden:NO];
}

- (void)hideVCDefaultImageView{
    [_defaultView setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
