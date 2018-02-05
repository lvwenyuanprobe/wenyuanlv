//
//  SNBrotherShareViewController.m
//  mybigbrother
//
//  Created by apple on 2017/12/1.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "SNBrotherShareViewController.h"
#import "DifferentTacticsHeader.h"
#import "DifferentTacticsController.h"
@interface SNBrotherShareViewController ()<UIScrollViewDelegate,QYQDifferentOrderStateHeaderDelegate,SDCycleScrollViewDelegate>
@property (nonatomic, assign) int page;

@property (nonatomic, assign) int beforePage;

@property (nonatomic, assign) int btnIndex;

@property (nonatomic, strong) NSMutableArray *IndexAr;

/** 头部滚动视图*/
@property (nonatomic, strong) DifferentTacticsHeader * sliderView;

/** 内容滚动视图*/
@property (nonatomic, strong) UIScrollView * contentScorllView;
@end

@implementation SNBrotherShareViewController

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
    // Do any additional setup after loading the view.
    [self setupViews];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    //    self.edgesForExtendedLayout = UIRectEdgeNone;// 推荐使用
    self.title = @"师兄分享";
}
- (void)setupViews{
    
    UIScrollView *listScroll = [[UIScrollView alloc] init];
    listScroll.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    listScroll.pagingEnabled = YES;
    listScroll.bounces = NO;
    listScroll.delegate = self;
    listScroll.backgroundColor = [UIColor clearColor];
    listScroll.contentSize = CGSizeMake(SCREEN_WIDTH, 0);
    listScroll.showsHorizontalScrollIndicator = NO;
    self.contentScorllView = listScroll;
    [self.view addSubview:listScroll];
    
    //    NSArray * arr = @[@"newTactics",@"bigbrotherShare"];
    
    DifferentTacticsController * orderListVC = [[DifferentTacticsController alloc]init];
    orderListVC.kNavigationController = self.navigationController;
    orderListVC.type =@"bigbrotherShare";
    [self addChildViewController:orderListVC];
    [listScroll addSubview:orderListVC.view];
    
}

#pragma mark - QYQDifferentOrderStateHeaderDelegate
-(void)showDifferentOrderListWithState:(KOrderStateType)sportType{
    
    _contentScorllView.contentOffset = CGPointMake(SCREEN_WIDTH * sportType, 0);
    
    self.btnIndex = sportType;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

