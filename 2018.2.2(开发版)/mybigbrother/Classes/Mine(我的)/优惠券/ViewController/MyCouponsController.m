//
//  MyCouponsController.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MyCouponsController.h"
#import "MBBDifferentCouponsHeader.h"
#import "MBBCouponsListDetailController.h"
#import "MBBCouponsConvertController.h"


@interface MyCouponsController ()<UIScrollViewDelegate,MBBDifferentCouponsHeaderDelegate>
@property (nonatomic, assign) int page;
    
@property (nonatomic, assign) int beforePage;
    
@property (nonatomic, assign) int btnIndex;
    
@property (nonatomic, strong) NSMutableArray *IndexAr;
    
/** 头部滚动视图*/
@property (nonatomic, strong) MBBDifferentCouponsHeader * sliderView;
    
/** 内容滚动视图*/
@property (nonatomic, strong) UIScrollView * contentScorllView;


@end

@implementation MyCouponsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的优惠券";
    /** 优惠券兑换*/
    UIButton * seeRuleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 75, 17)];
    [seeRuleBtn setTitle:@"优惠券兑换" forState:UIControlStateNormal];
    [seeRuleBtn setTitleColor:MBBCOLOR(144, 164, 245) forState:UIControlStateNormal];
    [seeRuleBtn.titleLabel setFont:MBBFONT(12)];
    [seeRuleBtn addTarget:self action:@selector(couponsConvert) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * selectBar = [[UIBarButtonItem alloc] initWithCustomView:seeRuleBtn];
    self.navigationItem.rightBarButtonItem = selectBar;

    [self createUI];
    // Do any additional setup after loading the view.
}
- (void)couponsConvert{
    MBBCouponsConvertController * convertVC = [[MBBCouponsConvertController alloc]init];
    [self.navigationController pushViewController:convertVC animated:YES];
}
    
- (void)createUI{
    
    _sliderView = [[MBBDifferentCouponsHeader alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,45)];
    _sliderView.delegate = self;
    _sliderView.showDelegate = self;
    [self.view addSubview:_sliderView];
    
    
    UIScrollView *listScroll = [[UIScrollView alloc] init];
    listScroll.frame = CGRectMake(0, CGRectGetMaxY(_sliderView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-64-45);
    listScroll.pagingEnabled = YES;
    listScroll.bounces = NO;
    listScroll.delegate = self;
    listScroll.backgroundColor = [UIColor clearColor];
    listScroll.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
    listScroll.showsHorizontalScrollIndicator = NO;
    self.contentScorllView = listScroll;
    [self.view addSubview:listScroll];
    
    NSArray *sportArray = @[@(1),@(2),@(3),];
    for (int i = 0; i < sportArray.count; i ++) {
        MBBCouponsListDetailController * couponsListVC = [[MBBCouponsListDetailController alloc]init];
        couponsListVC.couponStatus = sportArray[i];
        couponsListVC.kNavigationController = self.navigationController;
        couponsListVC.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49);
        [self addChildViewController:couponsListVC];
        [listScroll addSubview:couponsListVC.view];
    }
    
    //设置首选项
    [_sliderView publicButtonClicked:[self.orderState integerValue] + 1000];
    self.btnIndex = [self.orderState intValue];
    self.page = self.btnIndex;
    _contentScorllView.contentOffset = CGPointMake(SCREEN_WIDTH * [self.orderState intValue], 0);
    
}
    
#pragma mark - 
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
        for (int i = 0; i < 3 ; i ++) {
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
