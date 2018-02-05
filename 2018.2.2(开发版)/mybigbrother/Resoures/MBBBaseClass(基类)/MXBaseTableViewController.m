//
//  MXBaseTableViewController.m
//  mybigbrother
//
//  Created by SN on 2017/4/20.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MXBaseTableViewController.h"

@interface MXBaseTableViewController ()

@end

@implementation MXBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
