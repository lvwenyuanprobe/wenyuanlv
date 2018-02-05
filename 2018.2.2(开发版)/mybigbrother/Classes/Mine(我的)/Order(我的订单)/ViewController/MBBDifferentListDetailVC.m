//
//  MBBDifferentListDetailVC.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBDifferentListDetailVC.h"
#import "MBBPublicOrderCell.h"
#import "MBBMyJudgeController.h"
#import "MyOrderModel.h"
#import "MyOrderDetailController.h"

#import "MBBVCEmptyDefaultView.h"

@interface MBBDifferentListDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) NSInteger  begin;
@property (nonatomic, strong) NSMutableArray * publicArray;
@property (nonatomic, strong) MBBVCEmptyDefaultView * defaultView ;

@end

@implementation MBBDifferentListDetailVC

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
    self.begin = 1;
    [self getDataSourceFromSever];
    
}
- (void)loadMoreData{
    self.begin = self.begin + 1;
    [self getDataSourceFromSever];
}
- (void)getDataSourceFromSever{
    
    [self fetchDataSourceFromServer];
    [self endRefreshAnimation];
}

- (void)setStatus:(NSString *)status{
    _status = status;
}
- (void)fetchDataSourceFromServer{
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"orderorder";
     MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    if (model.token) {
        paramDic[@"token"] = model.token;

    }else{
        return;
    }
    paramDic[@"status"] = self.status;
    paramDic[@"page"] = @(self.begin);
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager getMyOrderList:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            NSArray * arr =  [MyOrderModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            if (self.begin == 1) {
                self.publicArray = [NSMutableArray arrayWithArray:arr];
            }else{
                [self.publicArray  addObjectsFromArray:arr];
            }
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
    
}
    

#pragma mark - UITableViewDelegate - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"MBBPublicOrderCell";
    MBBPublicOrderCell *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[MBBPublicOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.publicArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 170;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    MyOrderDetailController * orderDetail = [[MyOrderDetailController alloc]init];
    orderDetail.model = self.publicArray[indexPath.row];
    [self.kNavigationController pushViewController:orderDetail animated:YES];
    

}

#pragma mark -
- (void)addVCDefaultImageViewWithSuperView:(UIView *)faterView{
    MBBVCEmptyDefaultView * defaultView = [[MBBVCEmptyDefaultView alloc]initWithFrame:CGRectMake(0,
                                                                                                 100,
                                                                                                 SCREEN_WIDTH,
                                                                                                 SCREEN_HEIGHT)
                                                                          centerImage:@"record_default"
                                                                                title:@"你还没有此类订单"
                                                                             subTitle:@"快去来一单吧,亲!"];
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
