//
//  HomepageTacticView.m
//  mybigbrother
//
//  Created by SN on 2017/6/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "HomepageTacticView.h"
#import "DifferentTacticsHeader.h"
#import "DifferentTacticsController.h"

@interface HomepageTacticView ()<UIScrollViewDelegate,QYQDifferentOrderStateHeaderDelegate>

/** 头部滚动视图*/
@property (nonatomic, strong) DifferentTacticsHeader * sliderView;

/** 内容滚动视图*/
@property (nonatomic, strong) UIScrollView * contentScorllView;


@property (nonatomic, assign) int page;

@property (nonatomic, assign) int beforePage;

@property (nonatomic, assign) int btnIndex;

@property (nonatomic, strong) NSMutableArray *IndexAr;

@end

@implementation HomepageTacticView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
    }
    
    return self;
}

- (void)setUpUI{
    
    _sliderView = [[DifferentTacticsHeader alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,61)];
    _sliderView.delegate = self;
    _sliderView.showDelegate = self;
    [self addSubview:_sliderView];
    
    UIScrollView *listScroll = [[UIScrollView alloc] init];
    listScroll.frame = CGRectMake(0, CGRectGetMaxY(_sliderView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-61-49);
    listScroll.pagingEnabled = YES;
    listScroll.bounces = NO;
    listScroll.delegate = self;
    listScroll.backgroundColor = [UIColor clearColor];
    listScroll.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
    listScroll.showsHorizontalScrollIndicator = NO;
    self.contentScorllView = listScroll;
    [self addSubview:listScroll];
    
}

- (void)setKNavigationController:(UINavigationController *)kNavigationController{
    _kNavigationController = kNavigationController;
}

-(void)setPresentController:(UIViewController *)presentController{
    _presentController = presentController;
    NSArray * arr = @[@"newTactics",@"bigbrotherShare"];
    for (int i = 0; i < arr.count; i ++) {
        DifferentTacticsController * orderListVC = [[DifferentTacticsController alloc]init];
        
        orderListVC.kNavigationController = self.kNavigationController;
        orderListVC.type = arr[i];
        orderListVC.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-61-49);
        [self.contentScorllView addSubview:orderListVC.view];
        [self.presentController addChildViewController:orderListVC];
    }
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

@end
