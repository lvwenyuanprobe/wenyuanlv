//
//  CollectionViewController.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

    
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self endRefreshAnimation];
}
- (void)setupUI{
    
    [self.view addSubview:self.collectionView];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.collectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    //hide time
    ((MJRefreshStateHeader *)self.collectionView.mj_header).lastUpdatedTimeLabel.hidden = YES;
    
    //马上进入刷新状态
    //    [self.collectionView.mj_header beginRefreshing];
    
    //    [self.collectionView reloadData];
    
}
    
#pragma mark - Custom Func - (子类中重写调用)
- (void)loadData{
    
}
    
- (void)loadMoreData{
    
}
    
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                collectionViewLayout:layout];
        self.collectionView.backgroundColor = BASE_VC_COLOR;
    }
    return _collectionView;
}
    
- (void)endRefreshAnimation{
    
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}
    
- (void)beginRefreshAnimation{
    [self.collectionView.mj_header beginRefreshing];
}
    
/** 销毁时候调用*/
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
