//
//  StudentServiceController.m
//  mybigbrother
//
//  Created by SN on 2017/4/1.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "StudentServiceController.h"
#import "MBBServiceOptionView.h"
#import "ServicesModel.h"
#import "ServiceBannerModel.h"

#import "MBBCustomServiceDetailController.h"
#import "WBMakeCallView.h"
#import "MBBAboutUsController.h"


@interface StudentServiceController ()<MBBServiceOptionViewDelegate,SDCycleScrollViewDelegate>
@property(nonatomic, strong) UIScrollView * mainScrollView;
@property (nonatomic, strong) NSArray * models;
@property (nonatomic, strong) SDCycleScrollView * banner;
@property (nonatomic, strong) NSArray * bannerModels;
@property (nonatomic, strong) BAAlert        *alertView;

@property(nonatomic,strong)JQFMDB *db;

@end

@implementation StudentServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我是学生";
    /** 监测网络情况*/
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(reachabilityChanged:)
     name:kReachabilityChangedNotification
     object:nil];

    
    //主滚动视图
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.backgroundColor = MBBHEXCOLOR(0xf5f5f5);
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_mainScrollView];
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        // 当网络状态改变时调用
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                [self getBanner];
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
        }
    }];
    
    //开始监控
    [manager startMonitoring];
    // 创建数据库
    _db = [JQFMDB shareDatabase];
    [_db jq_createTable:@"BannerModelStudent" dicOrModel:[BannerModel class]];
    [_db jq_createTable:@"ServicesModelStudent" dicOrModel:[ServicesModel class]];
    
    [self setupViews];
    [self fetchDataSourceFromServer];
    
}
-(void)getBanner {
    self.bannerModels = [_db jq_lookupTable:@"BannerModelStudent" dicOrModel:[BannerModel class] whereFormat:nil];
    self.models = [_db jq_lookupTable:@"ServicesModelStudent" dicOrModel:[ServicesModel class] whereFormat:nil];
    
    
    NSMutableArray * images = [NSMutableArray array];
    for (BannerModel * model  in _bannerModels ) {
        [images addObject:model.b_img];
    }
    _banner.imageURLStringsGroup = images;
    BAKit_WeakSelf
    [BAAlert ba_alertShowWithTitle:@"提醒" message:@"您已断开网络连接，请连接后在使用" image:nil buttonTitleArray:@[@"确定"] buttonTitleColorArray:@[BASE_COLOR] configuration:^(BAAlert *tempView) {
        BAKit_StrongSelf
        
        /*! 开启边缘触摸隐藏alertView */
        tempView.isTouchEdgeHide = YES;
        /*! 添加高斯模糊的样式 */
        tempView.blurEffectStyle = BAAlertBlurEffectStyleLight;
        /*! 开启动画 */
        tempView.showAnimate   = YES;
        //        /*! 进出场动画样式 默认为：1 */
        //        tempView.animatingStyle  = 1;
        self.alertView = tempView;
    } actionBlock:^(NSInteger index) {
        BAKit_StrongSelf
        [self.alertView ba_alertHidden];
    }];
}
#pragma mark - 断网处理
- (void)reachabilityChanged:(NSNotification * )notice{
    Reachability *curReach = [notice object];
    NetworkStatus status = [curReach currentReachabilityStatus];
    if (status != NotReachable) {
        [self fetchDataSourceFromServer];
    }
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)setupViews{
    
    SDCycleScrollView * banner = [[SDCycleScrollView alloc]init];
    banner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    banner.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    banner.placeholderImage = [UIImage imageNamed:@"default_big"];
    [_mainScrollView addSubview:banner];
    banner.delegate = self;
    _banner = banner;
    
    /** 计算banner图宽高比*/
    CGFloat scale = (SCREEN_HEIGHT - SCREEN_WIDTH - 64 - 49)/SCREEN_WIDTH;
    
    if (kDevice_Is_iPhoneX) {
        banner.sd_layout
        .topSpaceToView(_mainScrollView,0)
        .widthIs(SCREEN_WIDTH)
        .heightIs(SCREEN_WIDTH * scale - 150)
        .leftSpaceToView(_mainScrollView,0);
    }else{
        banner.sd_layout
        .topSpaceToView(_mainScrollView,0)
        .widthIs(SCREEN_WIDTH)
        .heightIs(SCREEN_WIDTH * scale - 30)
        .leftSpaceToView(_mainScrollView,0);
    }
    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    /*** 跳转(banner详情)*/
    MBBAboutUsController * HTMLVI = [[MBBAboutUsController alloc]init];
    HTMLVI.loadType = @"5";
    HTMLVI.ServiceModel  = self.bannerModels[index];
    HTMLVI.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:HTMLVI animated:YES];
}

- (void)fetchDataSourceFromServer{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"type"] = @(0);
    paramDic[@"sign"] = @"serveservelist";
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    
    [MBBNetworkManager studentAndParentsServicesList:paramDic responseResult:^(YTKBaseRequest *request) {
        
//        NSLog(@"%@",request);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            NSArray * models = [ServicesModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            NSArray * bannerModes = [ServiceBannerModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"other"]];
            self.bannerModels = [NSArray arrayWithArray:bannerModes];
            NSMutableArray * imagesGroup = [NSMutableArray array];
            for ( ServiceBannerModel * model in bannerModes) {
                [imagesGroup addObject:model.b_img];
            }
            
            //删除全部数据
            [_db jq_deleteAllDataFromTable:@"BannerModelStudent"];
             [_db jq_deleteAllDataFromTable:@"ServicesModelStudent"];
            [_db jq_insertTable:@"BannerModelStudent" dicOrModelArray:self.bannerModels];

            [_db jq_insertTable:@"ServicesModelStudent" dicOrModelArray:models];
            
            
            
            _banner.imageURLStringsGroup = imagesGroup;
            self.models = models;
        }else{
            
            
        }
        
    }];
}

-(void)setModels:(NSArray *)models{
    _models = models;
    
    /** 计算banner图宽高比*/
    CGFloat scale;
        scale = (SCREEN_HEIGHT - SCREEN_WIDTH - 64 - 49)/SCREEN_WIDTH;
    if (kDevice_Is_iPhoneX) {
        scale = (SCREEN_HEIGHT - SCREEN_WIDTH - 64 - 168)/SCREEN_WIDTH;
    }
    CGFloat optionW = (SCREEN_WIDTH - 2)/4;
    CGFloat optionH = optionW;
    for (int i = 0; i < models.count; i ++) {
        ServicesModel * model = models[i];
        MBBServiceOptionView * optionView;
        if (kDevice_Is_iPhoneX) {
            optionView = [[MBBServiceOptionView alloc]initWithFrame:CGRectMake(0 + (optionW + 1) * (i%4) ,
                                                                                                      SCREEN_WIDTH * scale - 150 + 0 + (optionH + 1) * (i/4),
                                                                                                      optionW,
                                                                                                      optionH)];
        }
            optionView = [[MBBServiceOptionView alloc]initWithFrame:CGRectMake(0 + (optionW + 1) * (i%4) ,
                                                                                                  SCREEN_WIDTH * scale - 30 + 0 + (optionH + 1) * (i/4),
                                                                                                  optionW,
                                                                                                  optionH)];
        optionView.delegate = self;
        optionView.model = model;
        [_mainScrollView addSubview:optionView];
    }
    
//    WBMakeCallView * callView = [[WBMakeCallView alloc]init];
//    [self.mainScrollView addSubview:callView];
//    callView.frame = CGRectMake(0, SCREEN_WIDTH * 0.42 + 10 + (optionH + 1) * 3 + 30, SCREEN_WIDTH, 100);
    
    _mainScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
    _mainScrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT- 64 - 49 - 48);
   
    
}

- (void)showServiceDetail:(MBBServiceOptionView *)optionView{
    
   
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];

    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    
    if (model.token) {
     
        paramDic[@"token"]= model.token;
    }
    paramDic[@"f_id"] = optionView.model.f_id;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    [manager GET:[NSString stringWithFormat:@"http://api.worldbuddy.cn/home/Serve/serveinfo"] parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MBBCustomServiceDetailController * detailVC = [[MBBCustomServiceDetailController alloc]init];
        detailVC.serviceId =  optionView.model.f_id;
        detailVC.serviceType = @"0";
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        
//        NSLog(@"%@",responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"failure--%@",error);
    }];
    

    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
