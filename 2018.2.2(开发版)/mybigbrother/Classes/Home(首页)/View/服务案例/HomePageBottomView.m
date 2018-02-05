//
//  HomePageBottomView.m
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "HomePageBottomView.h"
#import "HomeServiceExmpleView.h"
#import "ServiceCaseModel.h"
@interface  HomePageBottomView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIImageView *   titleImage;
@property (nonatomic, strong) UILabel *   title;
@property (nonatomic, strong) UILabel * reloadLabel ;

/** 横向tableView*/
@property (nonatomic, strong) UITableView * horizontalTableView;

@property (nonatomic, strong) NSMutableArray * publicArray ;
@end

@implementation HomePageBottomView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}

- (void)moreAction
{
//    NSLog(@"8888888");

//    PartnersCollectionController *vc = [[PartnersCollectionController alloc]init];
//    [[self viewController].navigationController pushViewController:vc animated:YES];
    
}

- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    self.publicArray  = [NSMutableArray array];
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = RGB(0, 0, 0);
    titleLabel.font = MBBFONT(20);
    titleLabel.text = @"服务案例";
    [self addSubview:titleLabel];
    _title = titleLabel;
    
    UIView *botView = [[UIView alloc]init];
    [self addSubview:botView];
    botView.userInteractionEnabled = YES;
    botView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreAction)];
    [botView addGestureRecognizer:labelTapGestureRecognizer];
    [botView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(titleLabel);
        make.right.mas_equalTo(0);
    }];
    
    UIImageView *moreImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shouye_jt"]];
    [botView addSubview:moreImg];
    [moreImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.right.mas_equalTo(-10);
    }];
    
    UILabel *moreLabel = [[UILabel alloc]init];
    [botView addSubview:moreLabel];
    moreLabel.text = @"更多";
    moreLabel.font = [UIFont systemFontOfSize:15];
    moreLabel.alpha = 0.7;
    moreLabel.textColor = RGB(0, 0, 0);
    [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.right.equalTo(moreImg.mas_left).offset(-10);
    }];

    _horizontalTableView = [[UITableView alloc]initWithFrame:CGRectMake(-(180 - SCREEN_WIDTH)*0.5,(180 - SCREEN_WIDTH)*0.5 + 80 , 180, SCREEN_WIDTH) style:UITableViewStylePlain];
    _horizontalTableView.delegate = self;
    _horizontalTableView.dataSource = self;
    _horizontalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //tableview逆时针旋转90度。
    _horizontalTableView.transform = CGAffineTransformMakeRotation(-M_PI/ 2);
    _horizontalTableView.showsVerticalScrollIndicator = NO;
    
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    View.backgroundColor = [UIColor whiteColor];
    _horizontalTableView.tableHeaderView = View;
    
    [self addSubview:_horizontalTableView];

    [self fetchDataSoureFromServer];
    
    [self layoutAllSubviews];
}    
- (void)layoutAllSubviews{
 
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(20);
    }];
    
    
    /** 监测网络情况*/
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(reachabilityChanged:)
     name:kReachabilityChangedNotification
     object:nil];
    
}
#pragma mark - 断网处理
- (void)reachabilityChanged:(NSNotification * )notice{
    Reachability *curReach = [notice object];
    NetworkStatus status = [curReach currentReachabilityStatus];
    if (status != NotReachable) {
        [self fetchDataSoureFromServer];
    }
}
#pragma mark - UITableViewDelegate - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.publicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"HomeServiceExmpleView";
    HomeServiceExmpleView *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[HomeServiceExmpleView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.publicArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 158;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.horizontalTableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(gotoServiceExmpleDetail:)]) {
        [self.delegate gotoServiceExmpleDetail:self.publicArray[indexPath.row]];
    }
}
- (void)fetchDataSoureFromServer{
    if (self.reloadLabel) {
        [self.reloadLabel removeFromSuperview];
    }
    [MBProgressHUD showMessage:@"请稍后..." toView:self];
    [MBBNetworkManager getServiceCaseList:nil responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            NSArray * arr =  [ServiceCaseModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            self.publicArray = [NSMutableArray arrayWithArray:arr];
            [self.horizontalTableView reloadData];

        }else{
            [MBProgressHUD showError:@"网络不给力..." toView:self];
        }
        /** 联网请求失败 或 未能请求到数据*/
        if (self.publicArray.count == 0) {
            self.horizontalTableView.backgroundColor = [UIColor whiteColor];
            UILabel * reload = [[UILabel alloc]init];
            reload.text = @"点击重新加载...";
            reload.textColor = FONT_LIGHT;
            reload.font = MBBFONT(15);
            reload.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
            reload.center = CGPointMake(115/2,SCREEN_WIDTH/2);
            reload.textAlignment = NSTextAlignmentCenter;
            reload.transform = CGAffineTransformMakeRotation(M_PI/ 2);
            [self.horizontalTableView addSubview:reload];
            _reloadLabel = reload;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fetchDataSoureFromServer)];
            reload.userInteractionEnabled = YES;
            [reload addGestureRecognizer:tap];
        }
        
    }];
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
