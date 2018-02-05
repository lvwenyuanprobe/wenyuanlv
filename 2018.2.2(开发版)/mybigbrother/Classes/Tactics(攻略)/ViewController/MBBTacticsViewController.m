//
//  MBBTacticsViewController.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBTacticsViewController.h"
#import "DifferentTacticsHeader.h"
#import "DifferentTacticsController.h"

@interface MBBTacticsViewController ()<UIScrollViewDelegate,QYQDifferentOrderStateHeaderDelegate,SDCycleScrollViewDelegate>
@property (nonatomic, assign) int page;

@property (nonatomic, assign) int beforePage;

@property (nonatomic, assign) int btnIndex;

@property (nonatomic, strong) NSMutableArray *IndexAr;

/** 头部滚动视图*/
@property (nonatomic, strong) DifferentTacticsHeader * sliderView;

/** 内容滚动视图*/
@property (nonatomic, strong) UIScrollView * contentScorllView;

@end

@implementation MBBTacticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;// 推荐使用
}
- (void)setupViews{
    SDCycleScrollView * banner = [[SDCycleScrollView alloc]init];
    banner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    banner.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    banner.placeholderImage = [UIImage imageNamed:@"default_big"];
    banner.delegate = self;
    [self.view addSubview:banner];

    banner.sd_layout
    .topSpaceToView(self.view,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(160)
    .leftSpaceToView(self.view,0);
    
    _sliderView = [[DifferentTacticsHeader alloc]initWithFrame:CGRectMake(0,160,SCREEN_WIDTH,61)];
    _sliderView.delegate = self;
    _sliderView.showDelegate = self;
    [self.view addSubview:_sliderView];
    
    
    UIScrollView *listScroll = [[UIScrollView alloc] init];
    listScroll.frame = CGRectMake(0, CGRectGetMaxY(_sliderView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-64- 61);
    listScroll.pagingEnabled = YES;
    listScroll.bounces = NO;
    listScroll.delegate = self;
    listScroll.backgroundColor = [UIColor clearColor];
    listScroll.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
    listScroll.showsHorizontalScrollIndicator = NO;
    self.contentScorllView = listScroll;
    [self.view addSubview:listScroll];
    
    NSArray * arr = @[@"newTactics",@"bigbrotherShare"];
    for (int i = 0; i < arr.count; i ++) {
        DifferentTacticsController * orderListVC = [[DifferentTacticsController alloc]init];
        orderListVC.kNavigationController = self.navigationController;
        orderListVC.type = arr[i];
        if(i == 0){
           orderListVC.bannerImagesBlock = ^(NSArray *imageStringGroup) {
               banner.imageURLStringsGroup = imageStringGroup;
           };
        }
        orderListVC.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49-61);
        [self addChildViewController:orderListVC];
        [listScroll addSubview:orderListVC.view];
    }
    
    //设置首选项
    [_sliderView publicButtonClicked:[self.orderState integerValue] + 1000];
    self.btnIndex = [self.orderState intValue];
    self.page = self.btnIndex;
    _contentScorllView.contentOffset = CGPointMake(SCREEN_WIDTH * [self.orderState intValue], 0);
    
}

#pragma mark - QYQDifferentOrderStateHeaderDelegate
-(void)showDifferentOrderListWithState:(KOrderStateType)sportType{
    
    _contentScorllView.contentOffset = CGPointMake(SCREEN_WIDTH * sportType, 0);
    
    self.btnIndex = sportType;
}

#pragma mark - scrollViewDelegate
/** 减速停止*/
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    NSLog(@"滑动结束");
}
/** 开始拖动*/
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    NSLog(@"开始滑动");
}

/** 已经滑动时调用*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算页码
    double ratio = self.contentScorllView.contentOffset.x / SCREEN_WIDTH;
    self.page = (int)(ratio + 0.5);
    for (int i = 0; i < 2 ; i ++) {
        UIButton * btn = _sliderView.buttonArray[i];
        if (self.page == i) {
            self.btnIndex = self.page;
            btn.selected = YES;
            //色块滑动
            [_sliderView publicButtonClicked:btn.tag];
            
        }else{
            btn.selected = NO;
        }
    }
}
/** 减速停止时调用*/
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    double ratio = self.contentScorllView.contentOffset.x / SCREEN_WIDTH;
    int page = (int)(ratio + 0.5);
    for (int i = 0; i < _sliderView.buttonArray.count; i++) {
        if (page == i) {
            self.btnIndex = page;
        }
    }
    if(page == self.beforePage)
        return;
    self.beforePage = page;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    /*** 跳转(banner详情)*/
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
