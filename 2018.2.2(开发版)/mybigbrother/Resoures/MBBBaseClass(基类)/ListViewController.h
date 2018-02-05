//
//  ListViewController.h
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBBaseUIViewController.h"

@interface ListViewController : MBBBaseUIViewController
@property (nonatomic ,strong) UITableView  *tableView;
    
/** 刷新*/
- (void)loadData;
/** 加载更多*/
- (void)loadMoreData;
/** 停止刷新*/
- (void)endRefreshAnimation;
/** 创建UI*/
- (void)updateUI;
/** 开始刷新*/
- (void)beginRefreshAnimation;
    
@end
