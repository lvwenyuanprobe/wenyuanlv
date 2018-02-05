//
//  DriverDistanceController.m
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "DriverDistanceController.h"
#import "DriverDistanceHeader.h"
#import "DifferentDistanceController.h"

@interface DriverDistanceController ()<UIScrollViewDelegate,QYQDifferentOrderStateHeaderDelegate>
@property (nonatomic, assign) int page;

@property (nonatomic, assign) int beforePage;

@property (nonatomic, assign) int btnIndex;

@property (nonatomic, strong) NSMutableArray *IndexAr;

/** 头部滚动视图*/
@property (nonatomic, strong) DriverDistanceHeader * sliderView;

/** 内容滚动视图*/
@property (nonatomic, strong) UIScrollView * contentScorllView;

@end

@implementation DriverDistanceController

- (void)dismissVC{
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@""forKey:@"JPush"];
    [pushJudge synchronize];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
    
    if([[pushJudge objectForKey:@"JPush"]isEqualToString:@"JPush"]) {
        UIImage* image= [UIImage imageNamed:@"nav_back"];
        CGRect backframe= CGRectMake(0, 0, 12, 24);
        UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = backframe;
        [backButton setImage:image forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        backButton.titleLabel.font=[UIFont systemFontOfSize:12];
        [backButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
        //调整位置(设置占位)
        UIBarButtonItem *nagativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        nagativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[nagativeSpacer, someBarButtonItem];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的行程";
    // Do any additional setup after loading the view.
    [self setupViews];
}
- (void)setupViews{
    
    _sliderView = [[DriverDistanceHeader alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,45)];
    _sliderView.delegate = self;
    _sliderView.showDelegate = self;
    [self.view addSubview:_sliderView];
    
    
    UIScrollView *listScroll = [[UIScrollView alloc] init];
    listScroll.frame = CGRectMake(0, CGRectGetMaxY(_sliderView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-64-45);
    listScroll.pagingEnabled = YES;
    listScroll.bounces = NO;
    listScroll.delegate = self;
    listScroll.backgroundColor = [UIColor clearColor];
    listScroll.contentSize = CGSizeMake(SCREEN_WIDTH * 4, 0);
    listScroll.showsHorizontalScrollIndicator = NO;
    self.contentScorllView = listScroll;
    [self.view addSubview:listScroll];
    
    /** 订单状态: 0 未预约 1 已预约 2 进行中 3 已完成 */
    NSArray * sportArray = @[@"0",@"1",@"2",@"3"];
    for (int i = 0; i < sportArray.count; i ++) {
        DifferentDistanceController * orderListVC = [[DifferentDistanceController alloc]init];
        orderListVC.orderState = sportArray[i];
        orderListVC.kNavigationController = self.navigationController;
        orderListVC.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49);
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
    for (int i = 0; i < 4 ; i ++) {
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


@end
