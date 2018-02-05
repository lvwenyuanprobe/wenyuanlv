//
//  PartnersListController.m
//  mybigbrother
//
//  Created by SN on 2017/5/8.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "PartnersListController.h"
#import "PartnersTogetherModel.h"
#import "PartnerListCell.h"
#import "MinePublishDetailController.h"
@interface PartnersListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * publicArray;
@property (nonatomic, assign) NSInteger deviation ;
@end

@implementation PartnersListController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"约伴";
    [self updateData];
    // Do any additional setup after loading the view.
}
- (void)updateData{
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - H(49));
    
}
- (void)loadData{
    self.deviation = 1;
    [self getDataSourceFromSever];
    
}
- (void)loadMoreData{
    self.deviation = self.deviation + 1;
    [self getDataSourceFromSever];
}
- (void)getDataSourceFromSever{
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    param[@"deviation"] = @(self.deviation);
    [MBBNetworkManager getPartnersTogetherList:param responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view  animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            NSArray * modelArr = [PartnersTogetherModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            if (self.deviation == 1) {
                self.publicArray = [NSMutableArray arrayWithArray:modelArr];
            }else{
                [self.publicArray addObjectsFromArray:modelArr];
            }
            [self.tableView reloadData];
        
        }else{
            
        
        }
        if (self.deviation == [request.responseJSONObject[@"other"][@"countpage"] integerValue]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        /** 联网请求失败 或 未能请求到数据*/
        if (self.publicArray.count == 0) {
            
        }
    }];
    [self endRefreshAnimation];
}



#pragma mark - UITableViewDelegate - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"PartnerListCell";
    PartnerListCell *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[PartnerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.publicArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MinePublishDetailController * detailVC = [[MinePublishDetailController alloc]init];
    PartnersTogetherModel * model = self.publicArray[indexPath.row];
    detailVC.r_id = model.r_id;
    detailVC.hidesBottomBarWhenPushed = YES;
    [MyControl CheckOutPresentVCLogin:self isLoginToPush:detailVC];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
