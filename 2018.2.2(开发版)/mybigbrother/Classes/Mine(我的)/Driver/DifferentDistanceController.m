//
//  DifferentDistanceController.m
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "DifferentDistanceController.h"
#import "DriverDistanceCell.h"
#import "DriverOrderModel.h"
#import "MBBVCEmptyDefaultView.h"

@interface DifferentDistanceController ()<UITableViewDataSource,UITableViewDelegate,DriverDistanceCellDelegate,LCActionSheetDelegate>
@property (nonatomic, assign) NSInteger  begin;
@property (nonatomic, strong) NSMutableArray * publicArray;
@property (nonatomic, strong) NSMutableArray * phonesArray;
@property (nonatomic, strong) MBBVCEmptyDefaultView * defaultView ;
@end

@implementation DifferentDistanceController

- (NSMutableArray *)publicArray{
    if (!_publicArray) {
        _publicArray = [NSMutableArray array];
    }
    return _publicArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateData];
    // Do any additional setup after loading the view.
}

- (void)updateData{
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - H(49));
    
}
- (void)loadData{
    self.begin = 0;
    [self getDataSourceFromSever];
    
}
- (void)loadMoreData{
    self.begin = self.begin + 1;
    [self getDataSourceFromSever];
}
- (void)getDataSourceFromSever{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"driverorder";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"token"]  = model.token;
    
    /** 未约  已约 参数 t_status*/
    if([self.orderState isEqualToString:@"0"]){
        paramDic[@"t_status"] = @"0";
 
    }
    if([self.orderState isEqualToString:@"1"]){
        paramDic[@"t_status"] = @"1";
    }
    
    /** 进行中  已完成 参数 status*/
    if([self.orderState isEqualToString:@"2"]){
        
        paramDic[@"status"] = @"1";
    }
    if([self.orderState isEqualToString:@"3"]){
       
        paramDic[@"status"] = @"2";
    }
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userDriverDistanceOrderList:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            NSArray * models = [DriverOrderModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            self.publicArray = [NSMutableArray arrayWithArray:models];
            [self.tableView reloadData];
        
        }else{
        
            
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

#pragma mark - DistanceCellDelegate
- (void)makeCallToCustomerTap:(DriverOrderModel *)orderModel{
    NSArray * phones = orderModel.contacts;
    NSMutableArray * namesPhones = [ NSMutableArray array];
    _phonesArray = [ NSMutableArray array];
    for (NSDictionary * dic  in phones) {
        NSString * str = [NSString stringWithFormat:@"%@%@",dic[@"name"],dic[@"phone"]];
        [namesPhones addObject:str];
        [_phonesArray addObject:dic[@"phone"]];
    }
    LCActionSheet * sheet  = [[LCActionSheet alloc]initWithTitle:@"联系顾客" delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:namesPhones];
    sheet.delegate = self;
    [sheet show];
    
}
/** 司机对订单的操作*/
- (void)driverOperationOrder:(KDriverOperationType )operation orderModel:(DriverOrderModel *)OrderModel{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"driveroperation";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"token"] = model.token;
    paramDic[@"or_id"] = OrderModel.or_id;
    paramDic[@"status"] = @(operation);
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager driverOperationDistanceOrder:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
       
        }else{
        
        
        }

   
    }];

}
- (void)actionSheet:(LCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_phonesArray[buttonIndex-1]]]];
    }
}
#pragma mark - UITableViewDelegate - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"DriverDistanceCell";
    DriverDistanceCell *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[DriverDistanceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.distanceCellDelegate = self;
    cell.model = self.publicArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 230;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
- (void)addVCDefaultImageViewWithSuperView:(UIView *)faterView{
    MBBVCEmptyDefaultView * defaultView = [[MBBVCEmptyDefaultView alloc]initWithFrame:CGRectMake(0,
                                                                                                 100,
                                                                                                 SCREEN_WIDTH,
                                                                                                 SCREEN_HEIGHT)
                                                                          centerImage:@"record_default"
                                                                                title:@"您还没有此类订单"
                                                                             subTitle:@""];
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
