//
//  DifferentTacticsController.m
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "DifferentTacticsController.h"
#import "TacticsCell.h"
#import "TacticsShareModel.h"
#import "TacticsShareDetailController.h"
#import "TacticsBannerModel.h"

@interface DifferentTacticsController ()<UITableViewDataSource,UITableViewDelegate,UIViewControllerPreviewingDelegate>
@property (nonatomic, assign) NSInteger  begin;
@property (nonatomic, assign) NSInteger  size;
@property (nonatomic, strong) NSMutableArray * publicArray;
@property (nonatomic, assign) BOOL fingerIsTouch;

@end

@implementation DifferentTacticsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stop) name:@"mainScrollView" object:nil];
    
    /** 监测网络情况*/
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(reachabilityChanged:)
     name:kReachabilityChangedNotification
     object:nil];

    
    [self updateData];
    self.publicArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
}
-(void)stop {
    self.tableView.scrollEnabled = YES;
}
#pragma mark - 断网处理
- (void)reachabilityChanged:(NSNotification * )notice{
    Reachability *curReach = [notice object];
    NetworkStatus status = [curReach currentReachabilityStatus];
    if (status != NotReachable) {
        [self loadData];
    }
}

- (void)updateData{
//    self.tableView.scrollEnabled = NO;
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 69);
}

- (void)loadData{
    self.begin = 0;
    self.size  = 10;
    [self getDataSourceFromSever];
    
}
- (void)loadMoreData{
    self.begin = self.begin + self.size;
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}
- (void)getDataSourceFromSever{
    if ([self.type isEqualToString:@"newTactics"]) {
        [self fetchDataSourceFromServerTacticsList];
    }
    if ([self.type isEqualToString:@"bigbrotherShare"]) {
        [self fetchDataSourceFromServerShareList];

    }

    [self endRefreshAnimation];
}

- (void)fetchDataSourceFromServerTacticsList{
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager getStudentTacticsList:nil responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"status"] integerValue] >  0) {
            if (self.begin == 0) {
                NSArray * arr = [TacticsShareModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
                self.publicArray = [NSMutableArray arrayWithArray:arr];
                [self.tableView reloadData];
                
                NSArray * models = [TacticsBannerModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"other"]];
                NSMutableArray * blockArr = [NSMutableArray array];
                for (TacticsBannerModel * model  in models) {
                    [blockArr addObject:model.b_img];
                }
//                self.bannerImagesBlock(blockArr);
            }
        }else{
            [MBProgressHUD showError:@"加载失败..." toView:self.view];
        }
        
    }];

}

- (void)fetchDataSourceFromServerShareList{
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager getBigBrotherShareList:nil responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"status"] integerValue] > 0) {
            NSArray * arr = [TacticsShareModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            self.publicArray = [NSMutableArray arrayWithArray:arr];
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:@"加载失败..." toView:self.view];
        }
        
    }];
    
}

#pragma mark - UITableViewDelegate - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"MBBPublicOrderCell";
    TacticsCell *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[TacticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }else{
        
    }
    cell.model = self.publicArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TacticsShareDetailController * shareVC = [[TacticsShareDetailController alloc]init];
    TacticsShareModel *model = self.publicArray[indexPath.row];
    shareVC.model = model;
    shareVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shareVC animated:YES];
}

#pragma mark - 3D touch
//peek(预览)
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    //获取按压的cell所在行，[previewingContext sourceView]就是按压的那个视图
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    //设定预览的界面
    TacticsShareDetailController * shareVC = [[TacticsShareDetailController alloc]init];
    shareVC.preferredContentSize = CGSizeMake(0.0f,500.0f);
    TacticsShareModel *model = self.publicArray[indexPath.row];
    shareVC.model = model;
    //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width,90);
    previewingContext.sourceRect = rect;
    
    //返回预览界面
    return shareVC;
}
//pop（按用点力进入）
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    viewControllerToCommit.hidesBottomBarWhenPushed = YES;
    [self showViewController:viewControllerToCommit sender:self];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
