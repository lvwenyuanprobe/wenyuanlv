//
//  MineCollectionsController.m
//  mybigbrother
//
//  Created by SN on 2017/6/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MineCollectionsController.h"
#import "MBBVCEmptyDefaultView.h"
#import "MineCollectCell.h"
#import "MineCollectCellModel.h"
#import "MBBServiceCaseDetailController.h"
#import "TacticsShareDetailController.h"

@interface MineCollectionsController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * publicArray;

@property (nonatomic, strong) MBBVCEmptyDefaultView * defaultView ;

@property (nonatomic, assign) NSInteger  page;


@end

@implementation MineCollectionsController

- (NSMutableArray *)publicArray{
    if (!_publicArray) {
        _publicArray = [NSMutableArray array];
    }
    return _publicArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    [self updateData];
    // Do any additional setup after loading the view.
}

- (void)updateData{
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - H(49));
    
}
- (void)loadData{
    
    self.page = 1;
    [self getDataSourceFromSever];
    
}
- (void)loadMoreData{
    self.page = self.page + 1;
    [self getDataSourceFromSever];
    
}
- (void)getDataSourceFromSever{
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"collectioncollection";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"token"] = model.token;
    paramDic[@"page"] = @(self.page);

    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userCollectionKeepList:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            NSArray * models = [MineCollectCellModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            if (self.page == 1) {
                
                self.publicArray = [NSMutableArray arrayWithArray:models];
 
            }else{
                [self.publicArray addObjectsFromArray:models];
            }            
            [self.tableView reloadData];
            
        }else{
//            [MBProgressHUD showError:@"" toView:self.view];
        }
        
        //
        [self addVCDefaultImageViewWithSuperView:self.tableView];
        if (self.publicArray.count == 0) {
            [self showVCDefaultImageView];
            self.tableView.mj_footer.hidden = YES;
        }else{
            [self hideVCDefaultImageView];
            self.tableView.mj_footer.hidden = NO;
        }        
    }];
    
    [self endRefreshAnimation];
}
#pragma mark - UITableViewDelegate - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"MineCollectCell";
    MineCollectCell *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[MineCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.publicArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 170;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    MineCollectCellModel * model = self.publicArray[indexPath.row];
    /** 案例*/
    if ([model.c_type isEqualToString:@"1"]) {
        MBBServiceCaseDetailController * serviceCaseDetial = [[MBBServiceCaseDetailController alloc]init];
        serviceCaseDetial.cellModel = model;
        serviceCaseDetial.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:serviceCaseDetial animated:YES];
    }
    /** 攻略*/
    if ([model.c_type isEqualToString:@"2"]) {
        TacticsShareDetailController * shareVC = [[TacticsShareDetailController alloc]init];
        shareVC.hidesBottomBarWhenPushed = YES;
        shareVC.collectModel = model;
        [self.navigationController pushViewController:shareVC animated:YES];
    }
    
}
#pragma mark - 可编辑表
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;

}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
        MBBUserInfoModel * userModel = [MBBToolMethod fetchUserInfo];
        paramDic[@"sign"] = @"collectionkeep";
        paramDic[@"token"] = userModel.token;
        MineCollectCellModel * model = self.publicArray[indexPath.row];
        paramDic[@"mold"] = @(0);
        paramDic[@"col_id"] = @(model.col_id);
        [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
        [MBBNetworkManager userCollectKeep:paramDic responseResult:^(YTKBaseRequest *request) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            /** 请求成功*/
            if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
                
            }else{
           
            }
        }];
        [self.publicArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
#pragma mark - 默认图
- (void)addVCDefaultImageViewWithSuperView:(UIView *)faterView{
    MBBVCEmptyDefaultView * defaultView = [[MBBVCEmptyDefaultView alloc]initWithFrame:CGRectMake(0,
                                                                                                 100,
                                                                                                 SCREEN_WIDTH,
                                                                                                 SCREEN_HEIGHT)
                                                                          centerImage:@"record_default"
                                                                                title:@"您还没有收藏哦~"
                                                                             subTitle:nil];
    [faterView addSubview:defaultView];
    _defaultView = defaultView;
    [_defaultView setHidden:YES];
}

- (void)showVCDefaultImageView{
    [_defaultView setHidden:NO];
}

- (void)hideVCDefaultImageView{
    [_defaultView setHidden:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
