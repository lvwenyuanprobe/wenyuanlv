//
//  MBBSearchResultListController.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBSearchResultListController.h"
#import "SearchResultCell.h"
#import "SearchListModel.h"
#import "MBBCustomServiceDetailController.h"

#import "MBBVCEmptyDefaultView.h"


@interface MBBSearchResultListController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) NSInteger  begin;
@property (nonatomic, assign) NSInteger  size;
@property (nonatomic, strong) NSMutableArray * publicArray;
@property (nonatomic, strong) MBBVCEmptyDefaultView * defaultView ;

@end

@implementation MBBSearchResultListController


- (NSMutableArray *)publicArray{
    if (!_publicArray) {
        _publicArray = [NSMutableArray array];
    }
    return _publicArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"服务搜索";
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
    paramDic[@"sign"] = @"indexsearch";
    paramDic[@"data"] = self.searchString;
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userSearchService:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"成功" toView:self.view];
            NSArray * models = [SearchListModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            self.publicArray = [NSMutableArray arrayWithArray:models];
            [self.tableView reloadData];
            
        }else{
            [MBProgressHUD showError:@"暂时没有此类服务" toView:self.view];
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
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}


#pragma mark - UITableViewDelegate - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"SearchResultCell";
    SearchResultCell *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[SearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.publicArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    MBBMakeServiceDetailController * detailVC = [[MBBMakeServiceDetailController alloc]init];
    SearchListModel * model = self.publicArray[indexPath.row];
//    detailVC.navTitle = model.f_name;
//    detailVC.serviceId = [NSString stringWithFormat:@"%d", model.f_id];
//    [self.navigationController pushViewController:detailVC animated:YES];
    
    MBBCustomServiceDetailController * detialVC = [[MBBCustomServiceDetailController alloc]init];
    detialVC.serviceId =  [NSString stringWithFormat:@"%ld", (long)model.f_id];
    [self.navigationController pushViewController:detialVC animated:YES];


}
#pragma mark -
- (void)addVCDefaultImageViewWithSuperView:(UIView *)faterView{
    MBBVCEmptyDefaultView * defaultView = [[MBBVCEmptyDefaultView alloc]initWithFrame:CGRectMake(0,
                                                                                                 SCREEN_HEIGHT/3,
                                                                                                 SCREEN_WIDTH,
                                                                                                 SCREEN_HEIGHT)
                                                                          centerImage:@"record_default"
                                                                                title:@"还没有好友贡献奖励"
                                                                             subTitle:@"快去邀请他们吧"];
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
