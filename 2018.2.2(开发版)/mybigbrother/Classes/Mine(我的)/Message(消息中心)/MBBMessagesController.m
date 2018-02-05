//
//  MBBMessagesController.m
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBMessagesController.h"
#import "MessageCell.h"
#import "MessageModel.h"

#import "MBBVCEmptyDefaultView.h"

@interface MBBMessagesController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) NSInteger  begin;
@property (nonatomic, assign) NSInteger  size;
@property (nonatomic, strong) NSMutableArray * publicArray;
@property (nonatomic, strong) MBBVCEmptyDefaultView * defaultView ;

@end

@implementation MBBMessagesController

- (NSMutableArray *)publicArray{
    if (!_publicArray) {
        _publicArray = [NSMutableArray array];
    }
    return _publicArray;
}

- (void)dismissVC{
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@""forKey:@"JPush"];
    [pushJudge synchronize];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
    
    if([[pushJudge objectForKey:@"JPush"]isEqualToString:@"JPush"]) {
        UIImage* image= [UIImage imageNamed:@"nav_back"];
        CGRect backframe= CGRectMake(0, 0, 12, 24);
        UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = backframe;
        [backButton setImage:image forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        backButton.titleLabel.font=[UIFont systemFontOfSize:12];
        [backButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
        //调整位置(设置占位)
        UIBarButtonItem *nagativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        nagativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[nagativeSpacer, someBarButtonItem];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息中心";
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
    self.begin = 1;
    [self getDataSourceFromSever];
    
}
- (void)loadMoreData{
    self.begin = self.begin + 1;
    [self getDataSourceFromSever];
}
- (void)getDataSourceFromSever{
    
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"indexsystem";
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userSystemMessages:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {

            NSArray * models = [MessageModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            
            NSLog(@"%@",request.responseJSONObject[@"data"]);
            
            if (self.begin == 1) {
                
            }
            self.publicArray = [NSMutableArray arrayWithArray:models];
            [self.tableView reloadData];
        }else{
       
            
        }
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
    
    static NSString * ID = @"MessageCell";
    MessageCell *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.publicArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 64;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)addVCDefaultImageViewWithSuperView:(UIView *)faterView{
    MBBVCEmptyDefaultView * defaultView = [[MBBVCEmptyDefaultView alloc]initWithFrame:CGRectMake(0,
                                                                                                 SCREEN_HEIGHT/3,
                                                                                                 SCREEN_WIDTH,
                                                                                                 SCREEN_HEIGHT)
                                                                          centerImage:@"record_default"
                                                                                title:@"您暂时没有系统消息哦"
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
