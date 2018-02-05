//
//  MBBCouponsListDetailController.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBCouponsListDetailController.h"
#import "MBBCouponsCell.h"
#import "MBBCouponCell.h"
#import "CouponCellModel.h"

#import "MBBVCEmptyDefaultView.h"


@interface MBBCouponsListDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * publicArray;

@property (nonatomic, strong) MBBVCEmptyDefaultView * defaultView ;


@end

@implementation MBBCouponsListDetailController

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
    
    [self getDataSourceFromSever];

}
- (void)loadMoreData{
    
    [self getDataSourceFromSever];
    
}
- (void)getDataSourceFromSever{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"ordermycoupon";
     MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"token"] = model.token;
    /** 1 没有使用 2 使用过  3 已失效*/
    paramDic[@"status"] = self.couponStatus;
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager myCouponsList:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
           
            NSArray * models = [CouponCellModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            self.publicArray = [NSMutableArray arrayWithArray:models];
            [self.tableView reloadData];
        
        }else{
            [MBProgressHUD showError:@"失败" toView:self.view];
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
    cell.couponStatus = self.couponStatus;
    return cell;
}
    
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
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
                                                                                title:@"您还没有这样的优惠券"
                                                                             subTitle:nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
