//
//  MBBPersonalInfoShowController.m
//  mybigbrother
//
//  Created by SN on 2017/6/2.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBPersonalInfoShowController.h"

#import "PersonalInfoCell.h"
#import "PersonalHeaderView.h"
#import "PersonalInfoShowModel.h"

@interface MBBPersonalInfoShowController ()<UITableViewDelegate,
UITableViewDataSource,
LCActionSheetDelegate,
PersonalHeaderViewDelegate>
@property(nonatomic, strong) UITableView * menuTableView;
@property(nonatomic, strong) NSArray *menuDatas;
/** 已有数据*/
@property(nonatomic, strong) NSArray *rightDatas;
@property(nonatomic, strong) PersonalHeaderView * Header;

@end

@implementation MBBPersonalInfoShowController
- (NSArray *)rightDatas{
    if (!_rightDatas) {
        _rightDatas = [NSArray array];
    }
    return _rightDatas;
}
- (NSArray *)menuDatas{
    if (!_menuDatas) {
        _menuDatas = [NSArray array];
    }
    return _menuDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";//展示
    _menuDatas  = @[@"昵称",
                    @"个性签名",
                    @"性别",
                    ];
    _menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)style:UITableViewStylePlain];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _menuTableView.separatorColor = MBBHEXCOLOR(0xdddddd);
    [self.view addSubview:_menuTableView];
    self.menuTableView.tableFooterView = [[UIView alloc]init];
    
    PersonalHeaderView * Header = [[PersonalHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    Header.delegate = self;
    _Header = Header;
    self.menuTableView.tableHeaderView = Header;
    [self FetchPersonalInfomation];
    
}
- (void)FetchPersonalInfomation{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"releaseuserinfo";
    paramDic[@"u_id"] = self.u_id;
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userPersonalInfoShow:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            PersonalInfoShowModel * model = [PersonalInfoShowModel mj_objectWithKeyValues:request.responseJSONObject[@"data"]];
            [_Header.icon setImageWithURL: [NSURL URLWithString:model.u_img] placeholder:[UIImage imageNamed:@"default_icon"]];
            NSString * sex = [NSString string];
            if ([model.u_sex isEqualToString:@"0"]){
                sex = @"保密";
                
            }else{
                if ([model.u_sex isEqualToString:@"1"]) {
                    sex  = @"男";
                }else{
                    sex  = @"女";
                }
            }
            _rightDatas = @[model.u_nickname?model.u_nickname:@"保密",
                            model.u_autograph?model.u_autograph:@"没有签名哦",
                            sex,
                            ];
            [self.menuTableView reloadData];
        }else{
        
        }
    }];
}
#pragma mark - delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"PersonalInfoCell";
    
    PersonalInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PersonalInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.left.text = _menuDatas[indexPath.row];
    cell.right.text =_rightDatas[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
