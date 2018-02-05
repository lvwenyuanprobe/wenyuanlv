//
//  WelcomeController.m
//  mybigbrother
//
//  Created by SN on 2017/4/24.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WelcomeController.h"

@interface WelcomeController ()<UIScrollViewDelegate>

@property(strong, nonatomic) UIPageControl * pageControl;

@end

@implementation WelcomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
    [self createWelcomeView];
}

- (void)createWelcomeView {
    //欢迎页面的滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT);
    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    // This is the starting point of the ScrollView
    CGPoint scrollPoint = CGPointMake(0, 0);
    [scrollView setContentOffset:scrollPoint animated:YES];
    // yes 则发送一个可以touchesCancelled:withEvent:
    // 然后把这个事件当作一次滚动赖实现
    [scrollView setCanCancelContentTouches:YES];
    
    // 当值是NO 立即调用 touchesShouldBegin:withEvent:inContentView 看是否滚动
    // scroll
    [scrollView setDelaysContentTouches:NO];
    //循环创建scroller里面的内容
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"welcome_home%d", i + 1]];
        [scrollView addSubview:imageView];
        if (i == 2) {
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startButtonAction)];
            [imageView addGestureRecognizer:tap];
            
            /** 开启*/
            UILabel * begin = [[UILabel alloc]init];
            begin.text = @"立即体验";
            begin.textColor = [UIColor whiteColor];
            begin.font = MBBFONT(16);
            begin.textAlignment = NSTextAlignmentCenter;
            [imageView addSubview:begin];
            
//            begin.sd_layout
//            .bottomSpaceToView(imageView, SCREEN_HEIGHT * 0.15)
//            .leftSpaceToView(imageView, SCREEN_WIDTH/2 - 80)
//            .widthIs(135)
//            .heightIs(43);
            [begin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(imageView.mas_bottom).offset(-80);
                make.centerX.equalTo(imageView);
                make.width.mas_equalTo(140);
                make.height.mas_equalTo(43);
            }];
            
            begin.clipsToBounds = YES;
            begin.layer.cornerRadius = 20;
            begin.backgroundColor = RGB(28, 154, 244);
        }
        
        [scrollView addSubview:imageView];
    }
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,
                                                                      self.view.frame.size.height * .96,
                                                                      self.view.frame.size.width,
                                                                      [UIView setWidth:10])];
    self.pageControl.pageIndicatorTintColor = FONT_LIGHT;
    self.pageControl.currentPageIndicatorTintColor = BASE_YELLOW;
    [self.view addSubview:self.pageControl];
    /** 引导页个数设置*/
    self.pageControl.numberOfPages = 3;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.view.bounds);
    CGFloat pageFraction = scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
}

- (void)startButtonAction {
    
    NSNotification *notification = [NSNotification notificationWithName:MBB_RECREATE_ROOT
                                                                 object:nil
                                                               userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
@end
