//
//  ZFBBusinessTypeView.m
//  05-商家分类
//
//  Created by LV on 16/8/14.
//  Copyright © 2016年 LV. All rights reserved.
//

#import "ZFBBusinessTypeView.h"
#import "ZFBBusinessType.h"
#import "ZFBBusinessTypeCell.h"
#import "ZFBBusinessTypeLayout.h"
#import "MBBTakeCarController.h"
#import "MBBTakePlaneController.h"
#import "MBBCustomServiceContoller.h"
#import "WYInsuranceController.h"
#import "WYEliteBrotherController.h"
#import "WYCourseGuidanceController.h"
#import "HBBButlerServiceViewController.h"
#import "MBBCrisisHandlingViewController.h"
#import "MBBLoginContoller.h"
#import "MyControl.h"
#import "MBBUserInfoModel.h"


@interface ZFBBusinessTypeView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end
// 重用标识
static NSString *ID = @"businessType";

@implementation ZFBBusinessTypeView
// 加载完xib或sb方向创建完成businessTypeView之的就会来调用此方法
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

// 当用代码方法创建view时会来调用此方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    // 创建自定义的流布局对象
    ZFBBusinessTypeLayout *flowLayout = [[ZFBBusinessTypeLayout alloc] init];
    
    // 1.创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 170) collectionViewLayout:flowLayout];
    // 2.添加到控制器的view上
    [self addSubview:collectionView];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    // 设置数据源
    collectionView.dataSource = self;
    // 设置代理
    collectionView.delegate = self;
 
    
    // 注册cell
    [collectionView registerClass:[ZFBBusinessTypeCell class] forCellWithReuseIdentifier:ID];
    
    
    // 设置分页
    collectionView.pagingEnabled = YES;
    
    // 隐藏水平和垂直滚动条
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    
}

#pragma mark - 数据源方法

// 返回有多少个格子
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _businessTypeData.count;
}

// 返回每一组的每一个格子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建cell
    ZFBBusinessTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 2.设置数据
    cell.businessType = _businessTypeData[indexPath.item];
    
//    NSLog(@"%li---%li",indexPath.section,indexPath.row);
    
    // 3.返回cell
    return cell;
}

// 处理点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSLog(@"VIP包车");
        MBBTakeCarController * charterCar = [[MBBTakeCarController alloc]init];
        charterCar.hidesBottomBarWhenPushed = YES;
        
        MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
        if (!model.token) {
            MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
            [[self viewController].navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                    animated:YES
                                                  completion:nil];
            return;
        }else{

              [[self viewController].navigationController pushViewController:charterCar animated:YES];
        }

    }else if (indexPath.section == 0 && indexPath.row == 1){
        NSLog(@"危机处理");
//        [self showAlert];
        MBBCrisisHandlingViewController * CrisisHandlingVC = [[MBBCrisisHandlingViewController alloc]init];
        CrisisHandlingVC.hidesBottomBarWhenPushed = YES;
        
        MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
        if (!model.token) {
            MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
            [[self viewController].navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                                     animated:YES
                                                                   completion:nil];
            return;
        }else{
            [[self viewController].navigationController pushViewController:CrisisHandlingVC animated:YES];
        }
        
    }else if (indexPath.section == 0 && indexPath.row == 2){
        NSLog(@"管家服务");
        
        HBBButlerServiceViewController * takePlane = [[HBBButlerServiceViewController  alloc]init];
        takePlane.hidesBottomBarWhenPushed = YES;
        MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
        if (!model.token) {
            MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
            [[self viewController].navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                                     animated:YES
                                                                   completion:nil];
            return;
        }else{
            [[self viewController].navigationController pushViewController:takePlane animated:YES];
        }
        
    }else if (indexPath.section == 0 && indexPath.row == 3){
        NSLog(@"名校师兄");
//        [self showAlert];
        
        WYEliteBrotherController *eliteBrother = [[WYEliteBrotherController alloc] init];
        eliteBrother.hidesBottomBarWhenPushed = YES;
        MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
        if (!model.token) {
            MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
            [[self viewController].navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                                     animated:YES
                                                                   completion:nil];
            return;
        }else{
            [[self viewController].navigationController pushViewController:eliteBrother animated:YES];
        }
        
    }else if (indexPath.section == 0 && indexPath.row == 4){
        NSLog(@"入学定制");
        MBBCustomServiceContoller * customService = [[MBBCustomServiceContoller alloc]init];
        customService.hidesBottomBarWhenPushed = YES;
        MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
        if (!model.token) {
            MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
            [[self viewController].navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                                     animated:YES
                                                                   completion:nil];
            return;
        }else{
            [[self viewController].navigationController pushViewController:customService animated:YES];
        }
        
    }else if (indexPath.section == 0 && indexPath.row == 5){
        NSLog(@"留学保险");
        
        WYInsuranceController * InsuranceService = [[WYInsuranceController alloc]init];
        InsuranceService.hidesBottomBarWhenPushed = YES;
        MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
        if (!model.token) {
            MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
            [[self viewController].navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                                     animated:YES
                                                                   completion:nil];
            return;
        }else{
            [[self viewController].navigationController pushViewController:InsuranceService animated:YES];
        }
        
    }else if (indexPath.section == 0 && indexPath.row == 6){
        NSLog(@"课程辅导");
//        [self showAlert];
        WYCourseGuidanceController *CourseGuidance = [[WYCourseGuidanceController alloc]init];
        CourseGuidance.hidesBottomBarWhenPushed = YES;
        MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
        if (!model.token) {
            MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
            [[self viewController].navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                                     animated:YES
                                                                   completion:nil];
            return;
        }else{
            
            [[self viewController].navigationController pushViewController:CourseGuidance animated:YES];
        }
        
    }else if (indexPath.section == 0 && indexPath.row == 7){
        NSLog(@"海外房产");
        [self showAlert];
    }else if (indexPath.section == 0 && indexPath.row == 8){
        NSLog(@"跑步");
    }else if (indexPath.section == 0 && indexPath.row == 9){
        NSLog(@"的士");
    }else if (indexPath.section == 0 && indexPath.row == 10){
        NSLog(@"票务");
    }
}

/**
 *  弹框提示
 */
- (void)showAlert{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"暂未开通，敬请期待！" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    // 2秒后执行
    alert.alpha = 0.5;
    [self performSelector:@selector(dimissAlert:)withObject:alert afterDelay:1.0];
}
/**
 *  移除弹框
 */
- (void) dimissAlert:(UIAlertView *)alert {
    if(alert){
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
    }
}

@end












