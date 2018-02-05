//
//  WYPostTypeView.m
//  mybigbrother
//
//  Created by Loren on 2018/1/23.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYPostTypeView.h"
#import "WYPostType.h"
#import "WYPostTypeCell.h"
#import "WYPostTypeLayout.h"
#import "PublishPartnersTogetherController.h"
#import "WYBrotherHelpController.h"

@interface WYPostTypeView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

// 重用标识
static NSString *ID = @"postType";

@implementation WYPostTypeView
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
    WYPostTypeLayout *flowLayout = [[WYPostTypeLayout alloc] init];
    
    // 1.创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 150) collectionViewLayout:flowLayout];
    // 2.添加到控制器的view上
    [self addSubview:collectionView];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    // 设置数据源
    collectionView.dataSource = self;
    // 设置代理
    collectionView.delegate = self;
    
    
    // 注册cell
    [collectionView registerClass:[WYPostTypeCell class] forCellWithReuseIdentifier:ID];
    
    
    // 设置分页
    collectionView.pagingEnabled = YES;
    
    // 隐藏水平和垂直滚动条
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    
}

#pragma mark - 数据源方法

// 返回有多少个格子
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _postTypeData.count;
}

// 返回每一组的每一个格子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建cell
    WYPostTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 2.设置数据
    cell.PostType = _postTypeData[indexPath.item];
    
    //    NSLog(@"%li---%li",indexPath.section,indexPath.row);
    
    // 3.返回cell
    return cell;
}

// 处理点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSLog(@"学长帮忙");
        WYBrotherHelpController *brotherHelpVC = [[WYBrotherHelpController alloc] init];
        brotherHelpVC.hidesBottomBarWhenPushed = YES;
        [[self viewController].navigationController pushViewController:brotherHelpVC animated:YES];
        
    }else if (indexPath.section == 0 && indexPath.row == 1){
        NSLog(@"租房服务");
        
    }else if (indexPath.section == 0 && indexPath.row == 2){
        NSLog(@"海外房产");
        
    }else if (indexPath.section == 0 && indexPath.row == 6){
        NSLog(@"课程辅导");
        
    }else if (indexPath.section == 0 && indexPath.row == 4){
        
        NSLog(@"约伴同行");
        PublishPartnersTogetherController *togetherVC = [[PublishPartnersTogetherController alloc] init];
        togetherVC.hidesBottomBarWhenPushed = YES;
        [[self viewController].navigationController pushViewController:togetherVC animated:YES];

    }
}

@end










