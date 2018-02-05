//
//  HomePageTopView.m
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "HomePageTopView.h"
#import "BannerModel.h"
#import "MBBAboutUsController.h"

@interface  HomePageTopView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) NSArray * bannerModels;
@property (nonatomic, strong) UIButton *   leftBtn;
@property (nonatomic, strong) UIButton *   rightTopBtn;
@property (nonatomic, strong) UIButton *   rightBottomBtn;
@property(nonatomic, strong)  UIView * middleLine;
@property(nonatomic, strong)  UIView * rightLine;

@property(nonatomic,strong)JQFMDB *db;
@property (nonatomic, strong) BAAlert *alertView1;
// 底部图片
@property (nonatomic,strong) UIImageView *botImageView;

@end

@implementation HomePageTopView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    path = [path stringByAppendingString:@"GDATA.db"];
//    self.database = [GDataBase databaseWithPath:path];
    
    
    self.backgroundColor = [UIColor whiteColor];
    SDCycleScrollView * banner = [[SDCycleScrollView alloc]init];
    banner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    banner.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    banner.placeholderImage = [UIImage imageNamed:@"default_big"];
    banner.currentPageDotColor = MBBHEXCOLOR(0xe24e2b);
    banner.delegate = self;
    [self addSubview:banner];
    _banner = banner;
    
    [self layoutAllViews];

}
    

- (void)layoutAllViews{
    
    NSInteger offset;
    if (kScreenWidth == 320) {
        offset = 10;
    }else if (kScreenWidth == 375){
        offset = 30;
    }else {
        offset = 50;
    }
    
    _banner.sd_layout
    .topSpaceToView(self, 0)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(275);
    
    [_botImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_banner.mas_bottom).offset(10);
    }];
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_botImageView);
        if (offset == 10) {
            make.right.mas_equalTo(-9);
            make.width.mas_equalTo(95);
        }else if (offset == 30){
            make.right.mas_equalTo(-15);
        }else{
            make.right.mas_equalTo(-25);
        }
        
    }];
    
    [_rightBottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_botImageView);
        
        if (offset == 10) {
            make.left.mas_equalTo(9);
            make.width.mas_equalTo(95);
        }else if (offset == 30){
            make.left.mas_equalTo(15);
        }else{
            make.left.mas_equalTo(25);
        }
    }];
    
    [_rightTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_botImageView);
        make.centerX.equalTo(_botImageView);
        if (offset == 10) {
            make.width.mas_equalTo(95);
        }else{
            
        }
    }];

    /** 监测网络情况*/
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(reachabilityChanged:)
     name:kReachabilityChangedNotification
     object:nil];

    [self getCycleBannerImage];

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
    [_db jq_createTable:@"BannerModel" dicOrModel:[BannerModel class]];
    
}

// 请求banner数据
-(void)getBanner {
    
    self.bannerModels = [_db jq_lookupTable:@"BannerModel" dicOrModel:[BannerModel class] whereFormat:nil];
   
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
        self.alertView1 = tempView;
    } actionBlock:^(NSInteger index) {
        BAKit_StrongSelf
        [self.alertView1 ba_alertHidden];
       
    }];

    
}
#pragma mark - 断网处理
- (void)reachabilityChanged:(NSNotification * )notice{
    Reachability * curReach = [notice object];
    NetworkStatus status = [curReach currentReachabilityStatus];
    if (status != NotReachable) {
        [self getCycleBannerImage];
    }else {
       
    }
    
}
- (void)getCycleBannerImage{
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"indexindexbanner";
    [MBBNetworkManager getHomePageBannerImages:paramDic responseResult:^(YTKBaseRequest *request) {
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            NSArray *  modelArray = [BannerModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            self.bannerModels = [NSArray arrayWithArray:modelArray];
            NSMutableArray * images = [NSMutableArray array];
            for (BannerModel * model  in modelArray ) {
                [images addObject:model.b_img];
                
            }
            //删除全部数据
            [_db jq_deleteAllDataFromTable:@"BannerModel"];
            [_db jq_insertTable:@"BannerModel" dicOrModelArray:self.bannerModels];
          
            _banner.imageURLStringsGroup = images;
            
        }else{
            /** 次网络状态下处理*/
            
            
        
        }
    }];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    /*** 跳转(banner详情)*/
    MBBAboutUsController * HTMLVI = [[MBBAboutUsController alloc]init];
    HTMLVI.loadType = @"5";
    HTMLVI.HomeModel  = self.bannerModels[index];
    HTMLVI.hidesBottomBarWhenPushed = YES;
    [self.KNavgationController pushViewController:HTMLVI animated:YES];

}

- (void)clicked:(UIButton*)button{
    if ([self.delegate respondsToSelector:@selector(homepageTopViewButtonClicked:)]) {
        [self.delegate homepageTopViewButtonClicked:button.tag];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
