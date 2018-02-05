//
//  MBBInviteRecordViewController.m
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBInviteRecordViewController.h"
#import "MBBVCEmptyDefaultView.h"
#import "InviteRecordCell.h"
#import "MineInviteRecordModel.h"

@interface MBBInviteRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) NSInteger  begin;
@property (nonatomic, assign) NSInteger  size;
@property (nonatomic, strong) NSMutableArray * publicArray;
@property (nonatomic, strong) MBBVCEmptyDefaultView * defaultView ;


@property (nonatomic, strong) UILabel * personCount;
@property (nonatomic, strong) UILabel * money;

@end

@implementation MBBInviteRecordViewController


- (NSMutableArray *)publicArray{
    if (!_publicArray) {
        _publicArray = [NSMutableArray array];
    }
    return _publicArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"邀请记录";
    [self updateData];
}
- (void)updateData{
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - H(49));
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
    
    UILabel * personCount = [[UILabel alloc]init];
    personCount.textAlignment = NSTextAlignmentCenter;
    personCount.textColor = FONT_DARK;
    personCount.font = MBBFONT(15);
    personCount.text = @"0人";
    [headerView addSubview:personCount];
    _personCount = personCount;
    
    
    UILabel * personT = [[UILabel alloc]init];
    personT.textAlignment = NSTextAlignmentCenter;
    personT.text = @"已成功邀请";
    personT.textColor = FONT_DARK;
    personT.font = MBBFONT(15);
    [headerView addSubview:personT];

    UILabel * moneny = [[UILabel alloc]init];
    moneny.textAlignment = NSTextAlignmentCenter;
    moneny.text = @"0元";
    moneny.textColor = FONT_DARK;
    moneny.font = MBBFONT(15);
    [headerView addSubview:moneny];
    _money = moneny;

    UILabel * monenyT = [[UILabel alloc]init];
    monenyT.textAlignment = NSTextAlignmentCenter;
    monenyT.text = @"已获奖励";
    monenyT.textColor = FONT_DARK;
    monenyT.font = MBBFONT(15);
    [headerView addSubview:monenyT];

    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [headerView addSubview:line];
    
    UIView * bgView = [[UIView alloc]init];
    bgView.backgroundColor = BASE_VC_COLOR;
    [headerView addSubview:bgView];
    
    personCount.sd_layout
    .topSpaceToView(headerView,40)
    .leftSpaceToView(headerView,0)
    .widthIs(SCREEN_WIDTH/2)
    .heightIs(20);
    
    personT.sd_layout
    .topSpaceToView(personCount,5)
    .leftSpaceToView(headerView,0)
    .widthIs(SCREEN_WIDTH/2)
    .heightIs(20);
    
    moneny.sd_layout
    .topSpaceToView(headerView,40)
    .leftSpaceToView(personT,0)
    .widthIs(SCREEN_WIDTH/2)
    .heightIs(20);
    
    monenyT.sd_layout
    .topSpaceToView(personCount,5)
    .leftSpaceToView(personT,0)
    .widthIs(SCREEN_WIDTH/2)
    .heightIs(20);
    
    line.sd_layout
    .topSpaceToView(headerView,30)
    .leftSpaceToView(headerView,SCREEN_WIDTH/2)
    .widthIs(1)
    .heightIs(150 - 60);
    
    
    bgView.sd_layout
    .bottomSpaceToView(headerView,5)
    .leftSpaceToView(headerView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(5);

    self.tableView.tableHeaderView = headerView;
}
- (void)loadData{
    self.begin = 1;
    [self getDataSourceFromServer];
    
}
- (void)loadMoreData{
    self.begin = self.begin + 1;
    [self getDataSourceFromServer];
}

- (void)getDataSourceFromServer{
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"invitationrecord";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"token"] = model.token;
    paramDic[@"page"] = @(self.begin);
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userGetInviteRecord:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            NSArray * models = [MineInviteRecordModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];

            if (self.begin ==  1) {
                self.publicArray = [NSMutableArray arrayWithArray:models];
                
            }else{
               
                [self.publicArray addObjectsFromArray:models];
            
            }
            _personCount.text = [NSString stringWithFormat:@"%@人",request.responseJSONObject[@"other"][@"count"]];
            _money.text =  [NSString stringWithFormat:@"%@",request.responseJSONObject[@"other"][@"jl"]];
            
        }else{
        
        
        }
        [self.tableView reloadData];
        
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
    
    static NSString * ID = @"InviteRecordCell";
    InviteRecordCell *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[InviteRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.publicArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 默认图
- (void)addVCDefaultImageViewWithSuperView:(UIView *)faterView{
    MBBVCEmptyDefaultView * defaultView = [[MBBVCEmptyDefaultView alloc]initWithFrame:CGRectMake(0,
                                                                                                 SCREEN_HEIGHT/3,
                                                                                                 SCREEN_WIDTH,
                                                                                                 SCREEN_HEIGHT)
                                                                          centerImage:@"record_default"
                                                                                title:@"还没有好友贡献奖励"
                                                                             subTitle:@"快去邀请他们吧"];
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
}

@end
