//
//  MBBHomeViewController.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBHomeViewController.h"

#import "HomePageTopView.h"
#import "PartnerTogetherButton.h"
#import "HomeGetParntersView.h"
#import "HomePageBottomView.h"
#import "SearchView.h"

#import "CharterCarController.h"
#import "MBBCustomServiceContoller.h"
#import "MBBServiceCaseDetailController.h"
#import "MBBGetFriendTogetherController.h"

#import "MinePublishDetailController.h"
#import "MBBSearchBeginController.h"
#import "MBBTakePlaneController.h"
#import "MBBTakeCarController.h"
#import "ServiceCaseModel.h"
#import "UIView+PSFrame.h"

#import "PartnersListController.h"
#import "HomepageTacticView.h"
#import "PartnersCollectionController.h"
#import "TacticsShareDetailController.h"
// 导航条颜色渐变设置
#import "UINavigationBar+Awesome.h"
#import "UIView+Utils.h"
// 首页分类
#import "ZFBBusinessType.h"
#import "ZFBBusinessTypeView.h"
#import "MBBCrisisHandlingViewController.h"
#define TabbarHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) // 适配iPhone x 底栏高度
#define NAVBAR_CHANGE_POINT 5
BOOL getPushControllEnabled = YES;

@interface MBBHomeViewController ()<
HomePageTopViewDelegate,
HomePageBottomViewDelegate,
HomeGetParntersViewDelegate,UIScrollViewDelegate>
{
    HomepageTacticView * TacticView;
    HomePageBottomView * bottomView;
    HomePageTopView * headerView;
}
@property(nonatomic, strong)SearchView * searchView;
@property (nonatomic,strong) UIButton *customSearchBar;
@property (nonatomic, strong) UIScrollView * mainScrollView;
@end

@implementation MBBHomeViewController{
    
    UIStatusBarStyle            _statusBarYStyle;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.hidden = YES;
    [_customSearchBar setHidden:NO];
    // 去掉导航条下的黑线1步
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    [_customSearchBar setHidden:YES];
    self.navigationController.navigationBar.hidden = NO;
    // 去掉导航条下的黑线2步
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)gotoSearch{
    MBBSearchBeginController * searchVC = [[MBBSearchBeginController alloc]init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

     self.navigationController.navigationBar.hidden = YES;
     self.view.backgroundColor = [UIColor yellowColor];
     self.navigationItem.title = @"";
     [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(scrollViewScrollToTop)
     name:TABHOMEPAGE_NOTIFA
     object:nil];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    //主滚动视图
    if (@available(iOS 11.0, *)) {
        _mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if (kDevice_Is_iPhoneX) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,-49,SCREEN_WIDTH,SCREEN_HEIGHT + 49)];
    }else{
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,-20,SCREEN_WIDTH,SCREEN_HEIGHT + 20)];
    }
    
    _mainScrollView.delegate =self;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mainScrollView];
    
    [self setupViews];
    [self createUI];
}

// 导航条上的搜索设置
- (void)createUI{

    CGRect mainViewBounds = self.navigationController.view.bounds;
    if (kDevice_Is_iPhoneX) {
        _customSearchBar = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-60)/2), CGRectGetMinY(mainViewBounds)+30, CGRectGetWidth(mainViewBounds)-60, 30)];
    }else{
        _customSearchBar = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-60)/2), CGRectGetMinY(mainViewBounds)+25, CGRectGetWidth(mainViewBounds)-60, 30)];
    }
    
    _customSearchBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _customSearchBar.alpha = 0.7;
    [self.navigationController.view addSubview: _customSearchBar];
    _customSearchBar.layer.cornerRadius = 15.0f;
    _customSearchBar.layer.masksToBounds = YES;
    [_customSearchBar addTarget:self action:@selector(gotoSearch) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * searchImage = [[UIImageView alloc]init];
    searchImage.image = [UIImage imageNamed:@"home_search"];
    [_customSearchBar addSubview:searchImage];
    
    UILabel * title = [[UILabel alloc]init];
    title.text = @"大师兄";
    title.textColor = MBBHEXCOLOR_ALPHA(0x999999, 1.0);
    title.font = MBBFONT(15);
    [_customSearchBar addSubview:title];
    
    UILabel * mid = [[UILabel alloc]init];
    mid.text = @"";
    mid.textColor = MBBHEXCOLOR_ALPHA(0x999999, 1.0);
    mid.font = MBBFONT(15);
    [_customSearchBar addSubview:mid];
    
    [mid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_customSearchBar);
        make.centerX.equalTo(_customSearchBar);
    }];
    [searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mid.mas_left).offset(-10);
        make.centerY.equalTo(_customSearchBar);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_customSearchBar);
        make.left.equalTo(mid.mas_right).offset(0);
    }];
}

- (void)setupViews{
    headerView = [[HomePageTopView alloc]init];
    headerView.frame = CGRectMake(0,0, SCREEN_WIDTH, 475);
    headerView.KNavgationController = self.navigationController;
    headerView.delegate = self;
    self.mainScrollView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:headerView];
    
   
    
    // 分类标签
    ZFBBusinessTypeView *businessTypeView = [[ZFBBusinessTypeView alloc] initWithFrame:CGRectMake(0, 285, self.view.bounds.size.width, 180)];
    businessTypeView.backgroundColor = [UIColor whiteColor];
    businessTypeView.businessTypeData = [self loadBusinessTypeData];
    [headerView addSubview:businessTypeView];
    
    UIView *lineView = [[UIView alloc] init];
    [businessTypeView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#d6d6d6"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    bottomView = [[HomePageBottomView alloc]initWithFrame:CGRectMake(0,
                                                                     CGRectGetMaxY(headerView.frame)+0,
                                                                     SCREEN_WIDTH,
                                                                     285)];
    bottomView.delegate = self;
    [self.mainScrollView addSubview:bottomView];
    
    
    HomeGetParntersView * partnersView = [HomeGetParntersView initFrame:CGRectMake(0,
                                                                                   CGRectGetMaxY(bottomView.frame)+0,
                                                                                   SCREEN_WIDTH,
                                                                                   179 + 100)PageContolViewWithTyle:PartnerRequstStyle];
    partnersView.delegate = self;
    [self.mainScrollView addSubview:partnersView];
    
    
    HomeGetParntersView * partnersView1 = [HomeGetParntersView initFrame:CGRectMake(0,
                                                                                                                                                                                  CGRectGetMaxY(partnersView.frame)+0,
                                                                                                                                                                                  SCREEN_WIDTH,
                                                                                                                                                                                  280)PageContolViewWithTyle:NewRequstStyle];
    partnersView1.delegate = self;
    [self.mainScrollView addSubview:partnersView1];
   
    HomeGetParntersView * partnersView2 = [HomeGetParntersView initFrame:CGRectMake(0,
                                                                                                                                                                                   CGRectGetMaxY(partnersView1.frame)+0,
                                                                                                                                                                                   SCREEN_WIDTH,
                                                                                                                                                                                   290) PageContolViewWithTyle:BigRequstStyle];
    partnersView2.delegate = self;
    [self.mainScrollView addSubview:partnersView2];
    if (kDevice_Is_iPhoneX) {
        [self.mainScrollView setContentSize:CGSizeMake(0,CGRectGetMaxY(partnersView2.frame)+60)];
    }else{
        [self.mainScrollView setContentSize:CGSizeMake(0,CGRectGetMaxY(partnersView2.frame)+40)];
    }
}

// 加载首页分类的本地数据
- (NSArray *)loadBusinessTypeData {
    
    NSArray *dictArr = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"businessType.plist" withExtension:nil]];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:dictArr.count];
    [dictArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [arrayM addObject:[ZFBBusinessType businessTypeWithDict:obj]];
    }];
    return arrayM.copy;
}
    
#pragma mark - HomePageBottomViewDelegate
/** 服务案例详情*/
- (void)gotoServiceExmpleDetail:(ServiceCaseModel *)model{
    
    MBBServiceCaseDetailController * serviceCaseDetial = [[MBBServiceCaseDetailController alloc]init];
    serviceCaseDetial.model = model;
    serviceCaseDetial.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:serviceCaseDetial animated:YES];
}

#pragma mark - HomeGetParntersViewDelegate
/** 约伴详情*/
- (void)gotoGetPartnerDetail:(PartnersTogetherModel *)model{
    
    MinePublishDetailController * detailVC = [[MinePublishDetailController alloc]init];
    detailVC.r_id = model.r_id;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)gotoShareVCDetail:(TacticsShareModel *)model{
    
    TacticsShareDetailController * shareVC = [[TacticsShareDetailController alloc]init];
    shareVC.model = model;
    shareVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shareVC animated:YES];
    
}

/** 加载更多(约伴列表)*/
- (void)loadMoreDataFromServerList{
    /**
    PartnersListController * ListVC = [[PartnersListController alloc]init];
    ListVC.hidesBottomBarWhenPushed = YES;
    [MyControl CheckOutPresentVCLogin:self isLoginToPush:ListVC];
    */
    
    PartnersCollectionController * collectionVC = [[PartnersCollectionController alloc]init];
    collectionVC.hidesBottomBarWhenPushed = YES;
    [MyControl CheckOutPresentVCLogin:self isLoginToPush:collectionVC];

}

-(void)scrollViewScrollToTop{
    [self.mainScrollView scrollToTop];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor whiteColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        getPushControllEnabled = NO;
        self.navigationController.navigationBar.hidden = NO;

        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
    } else {
        getPushControllEnabled = YES;
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        self.navigationController.navigationBar.hidden = YES;
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
