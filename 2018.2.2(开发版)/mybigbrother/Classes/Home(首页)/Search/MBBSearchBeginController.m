//
//  MBBSearchBeginController.m
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBSearchBeginController.h"
#import "HotSearchView.h"
#import "MBBSearchResultListController.h"
#import "UIView+Utils.h"

@interface MBBSearchBeginController ()<UISearchBarDelegate,HotSearchViewDelegate>
@property (nonatomic, strong) UISearchBar * searchBar ;
@end

@implementation MBBSearchBeginController

/** 自定义导航栏*/
- (void)setNav{
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60, 34)];
    for (UIView *subView in [[_searchBar.subviews lastObject] subviews]) {
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subView removeFromSuperview];
//            _searchBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
    }
    _searchBar.layer.cornerRadius = 20;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.delegate = self;
//    _searchBar.barTintColor = [UIColor colorWithHexValue:0xf1f1f1 alpha:1];
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [_searchBar setContentMode:UIViewContentModeCenter];
    
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 34)];
    searchView.backgroundColor = [UIColor whiteColor];
    [searchView addSubview:_searchBar];
    self.navigationItem.titleView = searchView;
    
    // 切搜索框圆角
    UIView* backgroundView = [_searchBar subViewOfClassName:@"_UISearchBarSearchFieldBackgroundView"];
    backgroundView.layer.cornerRadius = 18.0f;
    backgroundView.clipsToBounds = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    
    HotSearchView * hotSearchView = [[HotSearchView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 200)];
    hotSearchView.delegate = self;
    [self.view addSubview:hotSearchView];
}

- (void)hotSearchResultList:(UIButton *)button{
    MBBSearchResultListController * resultVC = [[MBBSearchResultListController alloc]init];
    resultVC.searchString = button.titleLabel.text;
    [MyControl CheckOutPresentVCLogin:self isLoginToPush:resultVC];
}
#pragma mark - serachDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
    MBBSearchResultListController * resultVC = [[MBBSearchResultListController alloc]init];
    resultVC.searchString = searchBar.text;
    [MyControl CheckOutPresentVCLogin:self isLoginToPush:resultVC];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
