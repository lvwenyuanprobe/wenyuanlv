//
//  MBBSearchPartnersController.m
//  mybigbrother
//
//  Created by SN on 2017/7/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBSearchPartnersController.h"

@interface MBBSearchPartnersController ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar * searchBar ;
@end

@implementation MBBSearchPartnersController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60, 34)];
    for (UIView *subView in [[_searchBar.subviews lastObject] subviews]) {
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subView removeFromSuperview];
            _searchBar.backgroundColor = BASE_COLOR;
        }
    }
    _searchBar.layer.cornerRadius = 17;
    _searchBar.placeholder = @"请输入搜索内容(学校等)";
    _searchBar.delegate = self;
    _searchBar.barTintColor = [UIColor colorWithHexValue:0xf1f1f1 alpha:1];
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 34)];
    searchView.backgroundColor = BASE_COLOR;
    [searchView addSubview:_searchBar];
    self.navigationItem.titleView = searchView;
    // Do any additional setup after loading the view.
}
#pragma mark - serachDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
    self.searchText(searchBar.text?searchBar.text:@"");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
