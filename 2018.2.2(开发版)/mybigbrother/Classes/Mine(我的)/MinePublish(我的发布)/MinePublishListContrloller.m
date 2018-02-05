//
//  MinePublishListContrloller.m
//  mybigbrother
//
//  Created by SN on 2017/4/1.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MinePublishListContrloller.h"
#import "MinePublishCell.h"
#import "MinePublishDetailPayController.h"
#import "PublishPartnersTogetherController.h"

#import "MinePublishCellModel.h"

#import "MBBVCEmptyDefaultView.h"


@interface MinePublishListContrloller ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) NSInteger  begin;
@property (nonatomic, assign) NSInteger  size;
@property (nonatomic, strong) NSMutableArray * publicArray;
@property (nonatomic, strong) MBBVCEmptyDefaultView * defaultView ;

@end

@implementation MinePublishListContrloller

- (NSMutableArray *)publicArray{
    if (!_publicArray) {
        _publicArray = [NSMutableArray array];
    }
    return _publicArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的发布";
    
    /** 发布*/
    UIButton * seeRuleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
    [seeRuleBtn setImage:[UIImage imageNamed:@"mine_publish"] forState:UIControlStateNormal];
    [seeRuleBtn setImage:[UIImage imageNamed:@"mine_publish"] forState:UIControlStateSelected];
    [seeRuleBtn addTarget:self action:@selector(publishPartnersTogether) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * selectBar = [[UIBarButtonItem alloc] initWithCustomView:seeRuleBtn];
    self.navigationItem.rightBarButtonItem = selectBar;
    [self updateData];
}
- (void)publishPartnersTogether{
    PublishPartnersTogetherController * publish = [[PublishPartnersTogetherController alloc]init];
    [self.navigationController pushViewController:publish animated:YES];
    
}
- (void)updateData{
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - H(49));
}
- (void)loadData{
    self.begin = 1;
    self.size  = 1;
    [self getDataSourceFromSever];
    
}
- (void)loadMoreData{
    self.begin = self.begin + self.size;
    [self getDataSourceFromSever];
}
- (void)getDataSourceFromSever{
    
    [self fetchDataSourceFromServer];
    [self endRefreshAnimation];
}
- (void)fetchDataSourceFromServer{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"releasereleaselist";
    paramDic[@"deviation"] = @(self.begin);
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager getMyPublishList:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"加载成功" toView:self.view];
            NSArray * models = [MinePublishCellModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            if (self.begin == 1) {
                self.publicArray = [NSMutableArray arrayWithArray:models];
                
            }else{
                [self.publicArray addObjectsFromArray:models];
            }
            [self.tableView reloadData];
            
            if (self.begin == [request.responseJSONObject[@"other"][@"countpage"] integerValue]) {
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            
            [self addVCDefaultImageViewWithSuperView:self.tableView];
            if (self.publicArray.count == 0) {
                [self showVCDefaultImageView];
                self.tableView.mj_footer.hidden = YES;
            }else{
                [self hideVCDefaultImageView];
                self.tableView.mj_footer.hidden = NO;
            }
            
        }else{
            [MBProgressHUD showError:@"请重试..." toView:self.view];
        }
        
    }];

}
#pragma mark - UITableViewDelegate - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"MinePublishCell";
    MinePublishCell *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[MinePublishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.publicArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return H(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    MinePublishDetailPayController * detail = [[MinePublishDetailPayController alloc]init];
    MinePublishCellModel * model = self.publicArray[indexPath.row];
    detail.model= model;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark - 可编辑表
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MinePublishCellModel * model = self.publicArray[indexPath.row];
    /** 状态*/
    if([model.r_status isEqualToString:@"1"]){
        return UITableViewCellEditingStyleNone;

    }else{
        return UITableViewCellEditingStyleDelete;
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        

        NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
        paramDic[@"sign"] = @"releasereleasedel";
        MBBUserInfoModel * userModel = [MBBToolMethod fetchUserInfo];
        paramDic[@"token"] = userModel.token;
        MinePublishCellModel * model = self.publicArray[indexPath.row];
        paramDic[@"r_id"] = @(model.r_id);
        [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
        [MBBNetworkManager userRemovePublishNoPay:paramDic responseResult:^(YTKBaseRequest *request) {
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

- (void)addVCDefaultImageViewWithSuperView:(UIView *)faterView{
    MBBVCEmptyDefaultView * defaultView = [[MBBVCEmptyDefaultView alloc]initWithFrame:CGRectMake(0,
                                                                                                 SCREEN_HEIGHT/3,
                                                                                                 SCREEN_WIDTH,
                                                                                                 SCREEN_HEIGHT)
                                                                          centerImage:@"record_default"
                                                                                title:@"您还没有发布约伴"
                                                                             subTitle:@"快来发布一条吧"];
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
