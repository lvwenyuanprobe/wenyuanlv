//
//  DriverAccountListController.m
//  mybigbrother
//
//  Created by SN on 2017/5/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "DriverAccountListController.h"
#import "DriverAccountCell.h"
#import "DriverAccountListModel.h"

@interface DriverAccountListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, assign) NSInteger begin;
@property (nonatomic, strong) NSMutableArray * publicArray;
@end

@implementation DriverAccountListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的账单";
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
    paramDic[@"sign"] = @"driverbill";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"token"] = model.token;
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userDriverAccountList:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            NSArray * models = [DriverAccountListModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            self.publicArray = [NSMutableArray arrayWithArray:models];
            [self.tableView reloadData];
        }else{
                
        }
    
    }];
    [self endRefreshAnimation];

    
}



#pragma mark - UITableViewDelegate - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"MessageCell";
    DriverAccountCell *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[DriverAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.publicArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
