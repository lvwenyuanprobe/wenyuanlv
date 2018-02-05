//
//  MBBNavigationController.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBNavigationController.h"

@interface MBBNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic,strong) id popDelegate;
@end

@implementation MBBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    // 修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar * bar = [UINavigationBar appearance];
    // 2.导航栏背景颜色
    bar.barTintColor = [UIColor whiteColor];
    //3.设置导航栏文字的主题:白色
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(102, 102, 102)}];
    [self.navigationBar setTranslucent:NO];
    //4.设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    /** 侧滑手势返回*/
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
    
-(void)popself{
    [self popViewControllerAnimated:YES];
}
    
-(UIBarButtonItem*)createBackButton{
    
    UIImage* image= [UIImage imageNamed:@"backLeft"];
    CGRect backframe= CGRectMake(0, 0, 15, 24);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [backButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的 UIBarButtonItem
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1){
        viewController.hidesBottomBarWhenPushed = YES;
        //调整位置(设置占位)
        UIBarButtonItem *nagativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        nagativeSpacer.width = -10;
        viewController.navigationItem.leftBarButtonItems = @[nagativeSpacer, [self createBackButton]];
        }
}
#pragma UINavigationControllerDelegate方法
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //实现滑动返回功能
    //清空滑动返回手势的代理就能实现
    self.interactivePopGestureRecognizer.delegate =  viewController == self.viewControllers[0]? self.popDelegate : nil;
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
