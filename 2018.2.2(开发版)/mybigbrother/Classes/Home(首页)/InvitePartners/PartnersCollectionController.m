//
//  PartnersCollectionController.m
//  mybigbrother
//
//  Created by SN on 2017/7/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "PartnersCollectionController.h"
#import "PartnerCollectionViewCell.h"
#import "PartnersTogetherModel.h"
#import "MinePublishDetailController.h"
#import "JRWaterFallLayout.h"
#import "MBBSearchPartnersController.h"

#import "MBBVCEmptyDefaultView.h"


#define PartnerCollectionViewCellID  @"PartnerCollectionViewCellID"

@interface PartnersCollectionController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
JRWaterFallLayoutDelegate>
/** 数据源*/
@property (nonatomic, strong) NSMutableArray * publicArray;
/** 分页*/
@property (nonatomic, assign) NSInteger deviation ;
/** 集合视图*/
@property (nonatomic, strong) UICollectionView * collectionView;

/** 筛选文本*/
@property (nonatomic, strong) NSString * searchText;

@property (nonatomic, strong) MBBVCEmptyDefaultView * defaultView ;

@end

@implementation PartnersCollectionController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = NO;

    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"约伴";
    
    /** 筛选*/
    UIButton * seeRuleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, W(30), H(17))];
    [seeRuleBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [seeRuleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [seeRuleBtn.titleLabel setFont:MBBFONT(15)];
    [seeRuleBtn addTarget:self action:@selector(seeRuleClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * selectBar = [[UIBarButtonItem alloc] initWithCustomView:seeRuleBtn];
    self.navigationItem.rightBarButtonItem = selectBar;

    [self setupCollectionView];
    
    // Do any additional setup after loading the view.
}
- (void)seeRuleClicked{
    __weak __typeof(self) weakSelf = self;

    MBBSearchPartnersController * searchVC = [[MBBSearchPartnersController alloc]init];
    searchVC.searchText = ^(NSString * result){
        /** 刷新*/
        _searchText = result;
        [weakSelf loadData];
    };
    [self.navigationController pushViewController:searchVC animated:YES];
}
-(NSString *)searchText{
    if (!_searchText) {
        _searchText = [NSString stringWithFormat:@""];
    }
    return _searchText;
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
    param[@"search"] = self.searchText;
    
    [MBBNetworkManager getPartnersTogetherList:param responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view  animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200 || [request.responseJSONObject[@"msg"] integerValue]== 300 ) {
            NSArray * modelArr = [PartnersTogetherModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            if (self.deviation == 1) {
                self.publicArray = [NSMutableArray arrayWithArray:modelArr];
            }else{
                [self.publicArray addObjectsFromArray:modelArr];
            }
            [self.collectionView reloadData];
            
        }else{
            
            
        }
        if (self.deviation == [request.responseJSONObject[@"other"][@"countpage"] integerValue]) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self addVCDefaultImageViewWithSuperView:self.collectionView];
        /** 联网请求失败 或 未能请求到数据*/
        if (self.publicArray.count == 0) {
            [self showVCDefaultImageView];
            self.collectionView.mj_footer.hidden = YES;
        }else{
            [self hideVCDefaultImageView];
            self.collectionView.mj_footer.hidden = NO;
        }
    }];
    [self endRefreshAnimation];
}
- (void)endRefreshAnimation{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

- (void)setupCollectionView{
    /** 设置布局流*/
    JRWaterFallLayout * layout = [[JRWaterFallLayout alloc]init];
    //设置代理
    layout.delegate = self;
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)
                                                          collectionViewLayout:layout];
    
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = MBBHEXCOLOR(0xffffff);
    [self.collectionView registerClass:[PartnerCollectionViewCell class] forCellWithReuseIdentifier:PartnerCollectionViewCellID];
    
    __weak __typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}
#pragma mark - JRWaterFallLayoutDelegate
/** index位置下的item的高度*/
- (CGFloat )waterFallLayout:(JRWaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSUInteger)index width:(CGFloat)width{
    /** 设置中行突出(cell内配合设置)*/
    if ((index%3 == 0 || index%3 == 2) && (index/3 == 0)) {
        return (SCREEN_WIDTH - 3*20)/3 + 30 + 50 + 15;
    }
    return (SCREEN_WIDTH - 3*20)/3 + 30 + 15;
}
/** 返回列间距*/
- (CGFloat)columnMarginOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout{
    return 5;
}
/** 列数*/
- (NSUInteger)columnCountOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout{
    return 3;
}
/** 行间距*/
- (CGFloat)rowMarginOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout{
    return 0;
}
/** 边缘间距*/
- (UIEdgeInsets)edgeInsetsOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - UICollectionViewDataSoure
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PartnerCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:PartnerCollectionViewCellID forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.model = self.publicArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MinePublishDetailController * detailVC = [[MinePublishDetailController alloc]init];
    PartnersTogetherModel * model = self.publicArray[indexPath.row];
    detailVC.r_id = model.r_id;
    detailVC.hidesBottomBarWhenPushed = YES;
    [MyControl CheckOutPresentVCLogin:self isLoginToPush:detailVC];
}

#pragma mark -
- (void)addVCDefaultImageViewWithSuperView:(UIView *)faterView{
    MBBVCEmptyDefaultView * defaultView = [[MBBVCEmptyDefaultView alloc]initWithFrame:CGRectMake(0,
                                                                                                 SCREEN_HEIGHT/3,
                                                                                                 SCREEN_WIDTH,
                                                                                                 SCREEN_HEIGHT)
                                                                          centerImage:@"record_default"
                                                                                title:@"没有您搜索的内容哦~~"
                                                                             subTitle:@""];
    [faterView addSubview:defaultView];
    _defaultView = defaultView;
    [_defaultView setHidden:YES];
}

- (void)showVCDefaultImageView{
    [_defaultView setHidden:NO];
}

- (void)hideVCDefaultImageView{
    for ( UIView * view  in self.collectionView.subviews) {
        if ([view isKindOfClass:[MBBVCEmptyDefaultView class]]) {
            [view setHidden:YES];
        }
    }
    [_defaultView setHidden:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
