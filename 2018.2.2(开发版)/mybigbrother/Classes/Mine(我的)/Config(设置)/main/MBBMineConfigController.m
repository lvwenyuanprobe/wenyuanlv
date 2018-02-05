//
//  MBBMineConfigController.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBMineConfigController.h"
#import "MBBChangePasswordController.h"
#import "MBBFeedBackController.h"
#import "ConfigCell.h"
#import "MBBAboutUsController.h"
#import "MBBLoginContoller.h"
#import "GYLClearCacheCell.h"

static NSString * const GYLClearCacheCellID = @"ClearCache";

@interface MBBMineConfigController ()<UITableViewDelegate,UITableViewDataSource>
    
@property(nonatomic, strong) NSArray *menuDatas;
@property(nonatomic, strong) UITableView * menuTableView;


@end

@implementation MBBMineConfigController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData) name:MBB_LOGIN_IN object:nil];

    [self createUI];
    // Do any additional setup after loading the view.
}
- (void)createUI{
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT - 64)style:UITableViewStyleGrouped];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.sectionHeaderHeight = 0.0;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _menuTableView.separatorColor = MBBHEXCOLOR(0xdddddd);
    self.menuTableView.tableFooterView =[[UIView alloc]init];
    [self.view addSubview:_menuTableView];
    self.menuTableView.tableHeaderView = [[UIView alloc]init];
    
//    // iOS11默认开启Self-Sizing，关闭Self-Sizing即可。
//    _menuTableView.estimatedRowHeight = 0.01;
//    _menuTableView.sectionHeaderHeight = 0.01;
//    _menuTableView.sectionFooterHeight = 0.01;
    
    [self loadData];
    
    

}
- (void)loadData{
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    if (model.token) {
        _menuDatas = @[@[@"修改密码",
                         @"清除缓存",
                         @"意见反馈",
                         @"关于我们"],
                       @[@"退出登录"]];
    }else{
        _menuDatas = @[@[@"修改密码",
                         @"清除缓存",
                         @"意见反馈",
                         @"关于我们"],
                       @[@"重新登录"]];
    }
    [self.menuTableView reloadData];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - TabViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_menuDatas[section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.menuDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"configCell";
    ConfigCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ConfigCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *string = _menuDatas[indexPath.section][indexPath.row];
    cell.configLabel.text = string;

/////////////////////////////清除应用缓存///////////////////////////////////////
    if (indexPath.row == 1) {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        return [[GYLClearCacheCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:GYLClearCacheCellID];
    }
/////////////////////////////////////////////////////////////////////////////////////////////////
    
    if (indexPath.row == 0 && indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.configLabel.textAlignment = NSTextAlignmentCenter;
        cell.configLabel.textColor = [UIColor blackColor];
        cell.configLabel.sd_layout.leftSpaceToView(cell.contentView, SCREEN_WIDTH/4);
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.menuTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0 && indexPath.section == 0 ) {
        /** 修改密码*/
        MBBChangePasswordController * changePassword = [[MBBChangePasswordController alloc]init];
        changePassword.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changePassword animated:YES];
    }
    if (indexPath.row == 2 ) {
        /** 意见反馈*/
        MBBFeedBackController * feedBackVC = [[MBBFeedBackController alloc]init];
        feedBackVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feedBackVC animated:YES];
    }
    if (indexPath.row == 3 ) {
        /** 关于我们*/
        MBBAboutUsController * aboutUsVC = [[MBBAboutUsController alloc]init];
        aboutUsVC.loadType = @"0";
        aboutUsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }

    if (indexPath.row == 1) {
        [[YYImageCache sharedCache].diskCache removeAllObjects];
        [tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
    }
    
    if (indexPath.row == 0 && indexPath.section == 1) {
        /** 退登*/
        if ([_menuDatas[indexPath.section][indexPath.row] isEqualToString:@"退出登录"]) {
            LCActionSheet * sheet = [[LCActionSheet alloc]initWithTitle:@"退出后不影响任何历史数据" cancelButtonTitle:@"取消" clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    [MBBToolMethod cleanUserInfoLogOut];
                    [[NSNotificationCenter defaultCenter]postNotificationName:MBB_LOGIN_OUT object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } otherButtonTitles:@"退出登录", nil];
            sheet.destructiveButtonIndexSet = [NSSet setWithObject:@(1)];
            sheet.destructiveButtonColor = [UIColor redColor];
            [sheet show];
        }
        if ([_menuDatas[indexPath.section][indexPath.row] isEqualToString:@"重新登录"]) {
            MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
            [self.navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                         animated:YES
                                                       completion:nil];
            return;        
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
