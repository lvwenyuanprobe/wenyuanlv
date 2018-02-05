//
//  MBBMineViewController.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBMineViewController.h"
#import "MBBMyCenterCell.h"
#import "MyCenterHeader.h"

#import "MyOrderController.h"
#import "MyCouponsController.h"
#import "MBBMineConfigController.h"
#import "DriverDistanceController.h"
#import "DriverWalletController.h"
#import "MinePublishListContrloller.h"
#import "RecommendFriendController.h"
#import "MBBMessagesController.h"

#import "MBBMyJudgeListController.h"
#import "MBBDriverPersonalInfoController.h"
#import "MBBPersonalInfoController.h"
#import "MineCollectionsController.h"
#import"UINavigationBar+Awesome.h"
/** 临时*/
#import "MBBRegisterController.h"
#import "MBBLoginContoller.h"
#define NAVBAR_CHANGE_POINT 50

@interface MBBMineViewController ()<UITableViewDelegate,
UITableViewDataSource,
MyCenterHeaderDelegate,
MBBMyCenterCellDelegate>


@property(nonatomic, strong) NSArray *menuDatas;
@property(nonatomic, strong) NSArray *menuImages;
@property(nonatomic, strong) UITableView * menuTableView;
@property(nonatomic, strong) MyCenterHeader * headerView;
@property(nonatomic, assign) BOOL  isDriver;

@end

@implementation MBBMineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //         self.navBarBgAlpha = @"1.0";
    [self.navigationController setNavigationBarHidden:NO animated:NO];}

- (void)selectRightButton:(UIButton *)sender{
    
    MBBMessagesController * messagesVC = [[MBBMessagesController alloc]init];
    
    messagesVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:messagesVC animated:YES];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout=UIRectEdgeNone ;
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    _menuDatas  = [NSArray array];
    _menuImages = [NSArray array];
    
    /** 创建表格*/
    [self createUI];
    
    
    //    /** 登陆成功刷新数据*/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(initTableViewDataSource) name:MBB_LOGIN_IN object:nil];
    
    /** 登出刷新*/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(initTableViewDataSource) name:MBB_LOGIN_OUT object:nil];
    
    /** 初始化表格数据*/
    [self initTableViewDataSource];
    
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTableViewDataSource{
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    
    if (model.user.type == 3) {
        _isDriver = YES;
        
    }else{
        _isDriver = NO;
    }
    if (_isDriver == YES) {
        _menuDatas  = @[@[@"我的行程",
                          @"我的钱包",
                          @"我的评价",
                          @"消息中心",],
                        @[@"设置"]
                        ];
        _menuImages = @[@[@"mine_distance",
                          @"mine_wallet",
                          @"mine_comment",
                          @"mine_messages",
                          ],
                        @[@"mine_set",]
                        ];
    }else{
        _menuDatas  = @[@[@"我的订单",
                          @"我的发布",
                          @"我的收藏",
                          @"推荐好友",
                          @"我的优惠券",
                          ],
                        @[@"设置",@"联系客服",]
                        ];
        _menuImages = @[@[@"wd_dd",
                          @"wd_fb",
                          @"wd_sc",
                          @"wd_hy",
                          @"wd_yh"
                          ],
                        @[@"wd_sz",@"wd_kf"]
                        ];
        
    }
    
    [self.menuTableView reloadData];
}

- (void)createUI{
    
        _menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,-20, SCREEN_WIDTH, self.view.height+20)style:UITableViewStyleGrouped];
    if (kDevice_Is_iPhoneX) {
        _menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,-49, SCREEN_WIDTH, self.view.height+49)style:UITableViewStyleGrouped];
    }
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _menuTableView.separatorColor = MBBHEXCOLOR(0xdddddd);
    [self.view addSubview:_menuTableView];
    
    MyCenterHeader * headerView = [[MyCenterHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];

    UIButton * seeRuleBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width-40, 45, 20, 20)];
    [seeRuleBtn setTitle:@"" forState:UIControlStateNormal];
    [seeRuleBtn setTitleColor:MBBCOLOR(144, 164, 245) forState:UIControlStateNormal];
    [seeRuleBtn.titleLabel setFont:MBBFONT(12)];
    [seeRuleBtn addTarget:self action:@selector(selectRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [seeRuleBtn setBackgroundImage:[UIImage imageNamed:@"mine_messagecenter"] forState:UIControlStateNormal];
    
    [headerView addSubview:seeRuleBtn];
    
    headerView.delegate = self;
    _headerView = headerView;
    self.menuTableView.tableHeaderView = headerView;
    
}

#pragma mark - myCenterHeaderDelegate
- (void)MyCenterIconTap{
    
    if(_isDriver == YES){
        MBBDriverPersonalInfoController * personalInfo = [[MBBDriverPersonalInfoController alloc]init];
        personalInfo.hidesBottomBarWhenPushed = YES;
        [MyControl CheckOutPresentVCLogin:self isLoginToPush:personalInfo];
        
    }else{
        MBBPersonalInfoController * personalInfo = [[MBBPersonalInfoController alloc]init];
        personalInfo.hidesBottomBarWhenPushed = YES;
        [MyControl CheckOutPresentVCLogin:self isLoginToPush:personalInfo];
    }
    
}

#pragma mark - TabViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.menuDatas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_menuDatas[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"QYQMyCenterCell";
    
    MBBMyCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MBBMyCenterCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString * string  = _menuDatas[indexPath.section][indexPath.row];
    NSString * imageStr =_menuImages[indexPath.section][indexPath.row];
    cell.menuLabel.text = string;
    cell.leftView.image = [UIImage  imageNamed:imageStr];
    if(_isDriver == NO){
//        if (indexPath.row == 5) {
//            cell.indexPath = indexPath;
//            cell.rightLabel.text = @"联系境外客服6";
//            cell.rightImage.image = [UIImage imageNamed:imageStr];
//            cell.rightImage.hidden = NO;
//            cell.rightLabel.hidden = NO;
//            cell.delegate = self;
//        }
        /** 及时隐藏,防止复用问题*/
    }else{
        cell.delegate = nil;
        cell.rightImage.hidden = YES;
        cell.rightLabel.hidden = YES;
    }
    return cell;
}
#pragma mark - delegate
- (void)inSideCustomService{

    /* 部分机型系统无提示(5S iOsS 9.3.5)
     * [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel:168"]];
     */
    NSMutableString *str =[[NSMutableString alloc] initWithFormat:@"telprompt://%@", @"010-56617246"];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];

}
- (void)outSideCustomService{

    NSMutableString *str =[[NSMutableString alloc] initWithFormat:@"telprompt://%@", @"010-56617246"];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /** 区分司机or用户*/
    
    if(_isDriver == YES){
        
        if (indexPath.section == 0 && indexPath.row == 0){
            /** 我的行程*/
            DriverDistanceController * distance = [[DriverDistanceController alloc]init];
            distance.hidesBottomBarWhenPushed = YES;
            [MyControl CheckOutPresentVCLogin:self isLoginToPush:distance];
            
        }
        if (indexPath.section == 0 && indexPath.row == 1){
            /** 我的钱包*/
            DriverWalletController * walletVC = [[DriverWalletController alloc]init];
            walletVC.hidesBottomBarWhenPushed = YES;
            [MyControl CheckOutPresentVCLogin:self isLoginToPush:walletVC];
        }
        if (indexPath.section == 0 && indexPath.row == 2){
            /** 我的评价*/
            MBBMyJudgeListController * JudgeVC = [[MBBMyJudgeListController alloc]init];
            JudgeVC.hidesBottomBarWhenPushed = YES;
            [MyControl CheckOutPresentVCLogin:self isLoginToPush:JudgeVC];
            
        }
        
        if (indexPath.section == 0 && indexPath.row == 3){
            /** 消息中心*/
            MBBMessagesController * messagesVC = [[MBBMessagesController alloc]init];
            messagesVC.hidesBottomBarWhenPushed = YES;
            [MyControl CheckOutPresentVCLogin:self isLoginToPush:messagesVC];
            
        }
        
    }else{
        if (indexPath.section == 0 && indexPath.row == 0){
            /** 我的订单*/
            MyOrderController * orderVC = [[MyOrderController alloc]init];
            orderVC.hidesBottomBarWhenPushed = YES;
            [MyControl CheckOutPresentVCLogin:self isLoginToPush:orderVC];
        }
        if (indexPath.section == 0 && indexPath.row == 1){
            /** 我的发布*/
            MinePublishListContrloller * couponsVC = [[MinePublishListContrloller alloc]init];
            couponsVC.hidesBottomBarWhenPushed = YES;
            [MyControl CheckOutPresentVCLogin:self isLoginToPush:couponsVC];
        }
        if (indexPath.section == 0 && indexPath.row == 2){
            /** 我的收藏*/
            MineCollectionsController * collectVC = [[MineCollectionsController alloc]init];
            collectVC.hidesBottomBarWhenPushed = YES;
            [MyControl CheckOutPresentVCLogin:self isLoginToPush:collectVC];
        }
        if (indexPath.section == 0 && indexPath.row == 3){
            /** 推荐好友*/
            RecommendFriendController * recomendVC = [[RecommendFriendController alloc]init];
            recomendVC.hidesBottomBarWhenPushed = YES;
            [MyControl CheckOutPresentVCLogin:self isLoginToPush:recomendVC];
            
        }
        if (indexPath.section == 0 && indexPath.row == 4){
            /** 我的优惠券*/
            MyCouponsController * couponsVC = [[MyCouponsController alloc]init];
            couponsVC.hidesBottomBarWhenPushed = YES;
            [MyControl CheckOutPresentVCLogin:self isLoginToPush:couponsVC];
            
        }
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 0){
        /** 设置*/
        MBBMineConfigController * mineConfig = [[MBBMineConfigController alloc]init];
        mineConfig.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mineConfig animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1){
        
        NSLog(@"8888");
        [self inSideCustomService];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


/**
 *  tableView线条顶到头的方法
 */
-(void)viewDidLayoutSubviews
{
    if ([self.menuTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.menuTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.menuTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.menuTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 返回你所需要的状态栏样式
    return UIStatusBarStyleLightContent;
}

@end

