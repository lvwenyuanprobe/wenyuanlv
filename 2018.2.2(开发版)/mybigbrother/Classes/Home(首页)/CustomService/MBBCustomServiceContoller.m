//
//  MBBCustomServiceContoller.m
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBCustomServiceContoller.h"
#import "CustomServiceCell.h"
#import "CustomServiceFooter.h"
#import "MBBMakeServiceDetailController.h"

#import "CustomServiceCellModel.h"

@interface MBBCustomServiceContoller ()<UITableViewDataSource,UITableViewDelegate,CustomServiceFooterDelegate>
@property (nonatomic, assign) NSInteger  begin;
@property (nonatomic, assign) NSInteger  size;
@property (nonatomic, strong) NSMutableArray * publicArray;
@property (nonatomic, strong) CustomServiceFooter * footer;
@end

@implementation MBBCustomServiceContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"入学服务定制";
    [self updateData];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
    [super viewWillDisappear:animated];
}
- (void)updateData{
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - H(64));
    CustomServiceFooter * footer;
    footer = [[CustomServiceFooter alloc]initWithFrame:CGRectMake(0,
                                                                                        SCREEN_HEIGHT - 64 - 50,
                                                                                        SCREEN_WIDTH,
                                                                                          300)];
    if (kDevice_Is_iPhoneX) {
    footer = [[CustomServiceFooter alloc]initWithFrame:CGRectMake(0,
                                                                                            SCREEN_HEIGHT - 64 - 70,
                                                                                            SCREEN_WIDTH,
                                                                                            300)];
    }
    footer.delegate = self;
    _footer =footer;
    [self.view addSubview:footer];
}
- (void)loadData{
    self.begin = 0;
    self.size  = 10;
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
    paramDic[@"data"] = @"zxd";
    paramDic[@"sign"] = @"mademadelist";
//    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager getCustomServiceList:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"status"] integerValue] > 0) {
            
            NSArray * models = [CustomServiceCellModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            
            if (self.begin == 0) {
                self.publicArray = [NSMutableArray arrayWithArray:models];
            }else{
                
//                [self.publicArray  addObjectsFromArray:models];
            }
            
            [self.tableView reloadData];
        }else{
        
        
        }
    }];
}
#pragma mark - CustomServiceFooterDelegate
- (void)customTap{
    
    [self sliderViewAnimation:CGRectMake(0,
                                         SCREEN_HEIGHT - 64 - 300,
                                         SCREEN_WIDTH,
                                         300)];

}
- (void)submitInformationDic:(NSDictionary *)dic{
   
    if (kDevice_Is_iPhoneX) {
        [self sliderViewAnimation:CGRectMake(0,
                                             SCREEN_HEIGHT - 64 - 70,
                                             SCREEN_WIDTH,
                                             300)];
    }
    [self sliderViewAnimation:CGRectMake(0,
                                         SCREEN_HEIGHT - 64 - 50,
                                         SCREEN_WIDTH,
                                         300)];
}
- (void)dismissBottomView{
    if (kDevice_Is_iPhoneX) {
        [self sliderViewAnimation:CGRectMake(0,
                                             SCREEN_HEIGHT - 64 - 70,
                                             SCREEN_WIDTH,
                                             300)];
    }
    [self sliderViewAnimation:CGRectMake(0,
                                         SCREEN_HEIGHT - 64 - 50,
                                         SCREEN_WIDTH,
                                         300)];
}

-(BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}
/** 动画*/
- (void)sliderViewAnimation:(CGRect)rect{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    _footer.frame = rect;
    [UIView commitAnimations];
}

#pragma mark - UITableViewDelegate - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"CustomServiceCell";
    CustomServiceCell *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[CustomServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.publicArray[indexPath.row];
    return cell;
}
    
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    MBBMakeServiceDetailController * detailVC = [[MBBMakeServiceDetailController alloc]init];
    CustomServiceCellModel * model = self.publicArray[indexPath.row];
    detailVC.navTitle = model.ma_title;
    detailVC.serviceId = model.ma_id;
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - 拖拽弹回
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self dismissBottomView];
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
