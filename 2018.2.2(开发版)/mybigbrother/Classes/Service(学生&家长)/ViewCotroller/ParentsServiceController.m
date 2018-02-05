//
//  ParentsServiceController.m
//  mybigbrother
//
//  Created by SN on 2017/4/1.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ParentsServiceController.h"
#import "MBBServiceOptionView.h"
#import "ServicesModel.h"
#import "MBBCustomServiceDetailController.h"
#import "ServiceBannerModel.h"
#import "WBMakeCallView.h"
#import "MBBAboutUsController.h"

@interface ParentsServiceController ()<MBBServiceOptionViewDelegate,UIScrollViewDelegate,SDCycleScrollViewDelegate>
@property(nonatomic, strong) UIScrollView * mainScrollView;
@property (nonatomic, strong) NSArray * models;
@property (nonatomic, strong) SDCycleScrollView * banner;
@property (nonatomic, strong) NSArray * bannerModels;
@property (nonatomic, strong) BAAlert        *alertView;

@property(nonatomic,strong)JQFMDB *db;

@end

@implementation ParentsServiceController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我是家长";
    
    self.view.backgroundColor = MBBHEXCOLOR(0xf5f5f5);
    /** 监测网络情况*/
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(reachabilityChanged:)
     name:kReachabilityChangedNotification
     object:nil];
    //主滚动视图
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    SCREEN_WIDTH,
                                                                    SCREEN_HEIGHT)];
    _mainScrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 1.1);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.backgroundColor = MBBHEXCOLOR(0xf5f5f5);
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    [self setupViews];
    
    [self fetchDataSourceFromServer];
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
    [_db jq_createTable:@"BannerModelParent" dicOrModel:[BannerModel class]];
    [_db jq_createTable:@"ServicesModelParent" dicOrModel:[ServicesModel class]];
    
    
    
    
}
-(void)getBanner {
    self.bannerModels = [_db jq_lookupTable:@"BannerModelParent" dicOrModel:[BannerModel class] whereFormat:nil];
    self.models = [_db jq_lookupTable:@"ServicesModelParent" dicOrModel:[ServicesModel class] whereFormat:nil];
    
    
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
    banner.delegate = self;
    [_mainScrollView addSubview:banner];
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
    paramDic[@"type"] = @(1);
    paramDic[@"sign"] = @"serveservelist";
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    
    [MBBNetworkManager studentAndParentsServicesList:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            NSArray * models = [ServicesModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            self.models = models;
            
            NSArray * bannerModles = [ServiceBannerModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"other"]];
            self.bannerModels = [NSArray arrayWithArray:bannerModles];
            NSMutableArray * imagesGroup = [NSMutableArray array];
            for ( ServiceBannerModel * model in bannerModles) {
                [imagesGroup addObject:model.b_img];
            }
            _banner.imageURLStringsGroup = imagesGroup;
            
            
            //删除全部数据
            [_db jq_deleteAllDataFromTable:@"BannerModelParent"];
            [_db jq_deleteAllDataFromTable:@"ServicesModelParent"];
            
            [_db jq_insertTable:@"BannerModelParent" dicOrModelArray:self.bannerModels];
            
            [_db jq_insertTable:@"ServicesModelParent" dicOrModelArray:models];
            
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
        //        optionView.layer.borderColor = RGB(245, 245, 245).CGColor;
        //        optionView.layer.borderWidth = 0.5;
        
        
    }
    WBMakeCallView * callView = [[WBMakeCallView alloc]init];
    [self.mainScrollView addSubview:callView];
    
    callView.backgroundColor = [UIColor whiteColor];
    
    callView.frame = CGRectMake(0, SCREEN_WIDTH * scale + 15 + (optionH + 1) * 3, SCREEN_WIDTH, 50);
    _mainScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * scale + 10 + (optionH + 1) * (models.count/3 + 1));
    _mainScrollView.contentSize = CGSizeMake(0, SCREEN_WIDTH * scale + 10 + (optionH + 1) * (models.count/3 + 1));
    
    UIView *topLine = [[UIView alloc]init];
    [callView addSubview:topLine];
    topLine.backgroundColor = RGB(0, 0, 0);
    topLine.alpha = 0.1;
    
    UIView *botLine = [[UIView alloc]init];
    [callView addSubview:botLine];
    botLine.backgroundColor = RGB(0, 0, 0);
    botLine.alpha = 0.1;
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(callView);
        make.height.mas_equalTo(0.5);
        make.left.right.mas_equalTo(0);
    }];
    
    [botLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(callView.mas_bottom);
        make.height.mas_equalTo(0.5);
        make.left.right.mas_equalTo(0);
    }];
}

- (void)showServiceDetail:(MBBServiceOptionView *)optionView{
    
    MBBCustomServiceDetailController * detailVC = [[MBBCustomServiceDetailController alloc]init];
    detailVC.serviceId =  optionView.model.f_id;
    detailVC.serviceType = @"1";
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end

