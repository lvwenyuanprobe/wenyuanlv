//
//  ListViewController.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
    // Do any additional setup after loading the view.
}

    
#pragma mark -super method
- (void)updateUI{
    [self.view addSubview:self.tableView];
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    //马上进入刷新状态
//    [self.tableView.mj_header beginRefreshing];
    /** 更加自然的第一次加载数据*/
    [self loadData];
}
    
    
#pragma mark -custom func
- (void)loadData{
        
    
}
    
- (void)loadMoreData{
    
}
#pragma mark - accessor
- (UITableView *)tableView{
        if (!_tableView) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
            [_tableView setTableFooterView:[UIView new]];
        }
        return _tableView;
    }
    
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self endRefreshAnimation];
}
- (void)endRefreshAnimation{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)beginRefreshAnimation{
    
    [self.tableView.mj_header beginRefreshing];
}
    
- (void)dealloc{
    
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
