//
//  CollectionViewController.h
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBBaseUIViewController.h"

@interface CollectionViewController : MBBBaseUIViewController
/** 集合视图*/
@property (nonatomic, strong) UICollectionView * collectionView;
    
/** 载入数据*/
- (void)loadData;
/** 加载更多数据*/
- (void)loadMoreData;
    
/** 建立集合视图UI*/
- (void)setupUI;
/** 开始刷新*/
- (void)beginRefreshAnimation;
/* 结束刷新*/
- (void)endRefreshAnimation;

@end
