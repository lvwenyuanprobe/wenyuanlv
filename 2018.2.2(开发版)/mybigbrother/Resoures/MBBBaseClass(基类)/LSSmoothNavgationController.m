//
//  LSSmoothNavgationController.m
//  mybigbrother
//
//  Created by SN on 2017/5/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "LSSmoothNavgationController.h"

/** 滑动多少高度开始出现*/
static CGFloat const startH = 0;
/** 渐变范围(一般设置为图片高度:alpha从0到1)*/
#define  imageH  136

@interface LSSmoothNavgationController ()<UIScrollViewDelegate>

/** 导航条*/
@property (nonatomic, strong,readwrite) UIView * navgationBarView;

@end

@implementation LSSmoothNavgationController

- (UIView *)navBarView {
    if (!_navgationBarView) {
        UIView * navgationBarView = [[UIView alloc] init];
        navgationBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        [self.view addSubview:navgationBarView];
        self.navgationBarView = navgationBarView;
    }
    return _navgationBarView;
}
- (void)setTitleView:(UIView *)titleView{
    _titleView = titleView;
    if (!self.navgationBarView) {
        UIView * navgationBarView = [[UIView alloc] init];
        navgationBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        [self.view addSubview:navgationBarView];
        self.navgationBarView = navgationBarView;
    }
    [self.navgationBarView addSubview:self.titleView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    /** 设置导航栏(首页子控制器数组为1)*/
    if(self.navigationController.childViewControllers.count > 1){
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    /** 去掉分割线*/
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[MyControl createImageWithColor:MBBCOLOR_ALPHA(26, 25, 30, 0.1)] forBarMetrics:UIBarMetricsDefault];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //主滚动视图
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    SCREEN_WIDTH,
                                                                    SCREEN_HEIGHT)];
    _mainScrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 1.5);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.delegate = self;
    /**contentInset:即内边距,contentInset = 在内容周围增加的间距(粘着内容),
     contentInset的单位是UIEdgeInsets,默认值为UIEdgeInsetsZero。
     在有UITabBar存在时，系统为了防止UIScrollView被遮挡，
     其contentInset和scrollIndicatorInsets属性都会被设置为UIEdgeInsetsMake(0, 0, 49, 0)
     */
    _mainScrollView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    _mainScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 49, 0);
    _mainScrollView.backgroundColor = BASE_VC_COLOR;
    [self.view addSubview:_mainScrollView];

    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.titleView) {
        [self.navgationBarView addSubview:self.titleView];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat alpha = (offsetY * 1 - startH)/ imageH;
    if (alpha <= 0.0) {
        alpha = 0.1;
    }
    if (alpha >= 1.0) {
        alpha = 0.99;
    }
    self.navBarView.backgroundColor = MBBCOLOR_ALPHA(26, 25, 30, alpha);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
