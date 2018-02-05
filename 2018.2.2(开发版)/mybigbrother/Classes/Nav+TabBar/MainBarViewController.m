//
//  MainBarViewController.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MainBarViewController.h"

#import "MBBNavigationController.h"
#import "MBBHomeViewController.h"
#import "MBBServiceViewController.h"
#import "MBBTacticsViewController.h"
#import "MBBMineViewController.h"
#import "ParentsServiceController.h"
#import "StudentServiceController.h"
#import "PostViewController.h"

#import <AudioToolbox/AudioToolbox.h>

#import "LBTabBar.h"
#import "UIImage+Image.h"


#define SafeAreaBottomHeight (kWJScreenHeight == 812.0 ? 34 : 0)

@interface MainBarViewController ()<LBTabBarDelegate>
{
    
    MBBHomeViewController * HomeVC;
    MBBServiceViewController * ServiceVC;
    MBBTacticsViewController * TacticsVC;
    MBBMineViewController * MineVC;
    ParentsServiceController * parentsVC;
    StudentServiceController * studentVC;
    
}
@property(nonatomic, assign) BOOL isFirstCheckNetStatus;
@property (nonatomic,assign) NSInteger  indexFlag;
@property (nonatomic,strong) UIWindow *window;
@end

@implementation MainBarViewController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 添加所有的子控制器*/
    [self addAllChildViewController];
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    LBTabBar *tabbar = [[LBTabBar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    /** 监测网络情况*/
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(reachabilityChanged:)
     name:kReachabilityChangedNotification
     object:nil];
    
    _isFirstCheckNetStatus = NO;
    self.indexFlag = 0;
    
    
    
}
#pragma mark - tabBar点击事件
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if ([item.title isEqualToString:@"首页"]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:TABHOMEPAGE_NOTIFA object:nil];
    }
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self animationWithIndex:index];//动画
    [self playSound];//音效
}

- (void)reachabilityChanged:(NSNotification * )notice{
    Reachability *curReach = [notice object];
    NetworkStatus status = [curReach currentReachabilityStatus];
    if (_isFirstCheckNetStatus == NO) {
        _isFirstCheckNetStatus = YES;
        return;
    }
    switch (status) {
            
        case NotReachable:
            [MBProgressHUD showError:@"无网络链接" toView:self.view];
            break;
            
        case ReachableViaWiFi:
            [MBProgressHUD showSuccess:@"当前为WiFi网络环境" toView:self.view];
            break;
        case ReachableViaWWAN:
            [MBProgressHUD showSuccess:@"当前为非WiFi网络环境" toView:self.view];
            
            break;
        default:
            [MBProgressHUD showSuccess:@"当前为非WiFi网络环境" toView:self.view];
            break;
    }
}
- (void)addAllChildViewController{
    
    /** 首页*/
    HomeVC = [[MBBHomeViewController alloc] init];
    [self addOneChlildVc:HomeVC
                   title:@"首页"
               imageName:@"dh_shouye"
       selectedImageName:@"dh_shouye_xz"];
    
    /** 学生*/
    studentVC = [[StudentServiceController alloc] init];
    [self addOneChlildVc:studentVC
                   title:@"学生"
               imageName:@"dh_xuesheng"
       selectedImageName:@"dh_xuesheng_xz"];
    
    /** 家长*/
    parentsVC = [[ParentsServiceController alloc] init];
    [self addOneChlildVc:parentsVC
                   title:@"家长"
               imageName:@"dh_jiazhang"
       selectedImageName:@"dh_jiazhang_xz"];
    
    
    /** 我的*/
    MineVC = [[MBBMineViewController alloc] init];
    [self addOneChlildVc:MineVC
                   title:@"我的"
               imageName:@"dh_wode"
       selectedImageName:@"dh_wode_xz"];
    
}

/** 添加子视图控制器*/
- (void)addOneChlildVc:(UIViewController *)childVC
                 title:(NSString *)title
             imageName:(NSString *)imageName
     selectedImageName:(NSString *)selectedImageName {
    // 设置标题
    childVC.tabBarItem.title = title;
    childVC.navigationItem.title = title;
    [childVC.tabBarItem setTitleTextAttributes:@{
                                                 NSForegroundColorAttributeName : RGB(251, 96, 48)
                                                 }
                                      forState:UIControlStateSelected];
    
    [childVC.tabBarItem setTitleTextAttributes:@{
                                                 NSForegroundColorAttributeName : RGB(121, 121, 121)
                                                 }
                                      forState:UIControlStateNormal];
    
    // 设置图标
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage =[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = selectedImage;
    
    self.mainBarNav = [[MBBNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController: self.mainBarNav];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar
{
    PostViewController *plusVC = [[PostViewController alloc] init];
    self.definesPresentationContext = YES;
    plusVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    MBBNavigationController *navVc = [[MBBNavigationController alloc] initWithRootViewController:plusVC];
    navVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    navVc.view.backgroundColor = [UIColor clearColor];
    [self presentViewController:navVc animated:YES completion:nil];
    
}

#pragma mark - tabBar特效动画 -
- (void)playSound{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"like" ofType:@"caf"];
    SystemSoundID soundID;
    NSURL *soundURL = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&soundID);
    AudioServicesPlaySystemSound(soundID);
}

- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
}

/*
 
 NSInteger index = [self.tabBar.items indexOfObject:item];
 if (index != self.indexFlag) {
 //执行动画
 NSMutableArray *arry = [NSMutableArray array];
 for (UIView *btn in self.tabBar.subviews) {
 if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
 [arry addObject:btn];
 }
 }
 //添加动画
 //放大效果，并回到原位
 CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
 //速度控制函数，控制动画运行的节奏
 animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 animation.duration = 0.2;       //执行时间
 animation.repeatCount = 1;      //执行次数
 animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
 animation.fromValue = [NSNumber numberWithFloat:0.7];   //初始伸缩倍数
 animation.toValue = [NSNumber numberWithFloat:1.3];     //结束伸缩倍数
 [[arry[index] layer] addAnimation:animation forKey:nil];
 
 self.indexFlag = index;
 }
 
 */


@end











