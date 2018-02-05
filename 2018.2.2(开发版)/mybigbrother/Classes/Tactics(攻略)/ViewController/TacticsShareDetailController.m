//
//  TacticsShareDetailController.m
//  mybigbrother
//
//  Created by SN on 2017/4/18.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "TacticsShareDetailController.h"
#import "CollectCommentShareView.h"
#import "MBBInviteFriendView.h"
#import "LSThirdShareLoginManager.h"
#import "MBBLoginContoller.h"

@interface TacticsShareDetailController ()<CollectCommentShareViewDelegate,MBBInviteFriendViewDelegate>
@property (nonatomic, strong) UIWebView * webview ;
@property (nonatomic, strong) CollectCommentShareView * bottomView;
@property (nonatomic, strong) UIScrollView * contentScorllView ;
@property (nonatomic, strong) NSString * shareUrl;
@end

@implementation TacticsShareDetailController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.model.ra_title) {
        self.navigationItem.title = self.model.ra_title;
    }
    if (self.collectModel.title) {
        self.navigationItem.title = self.collectModel.title;
    }

    [self fetchDataFromServer];
    
    UIScrollView *listScroll = [[UIScrollView alloc] init];
    listScroll.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    listScroll.pagingEnabled = YES;
    listScroll.bounces = NO;
    listScroll.backgroundColor = [UIColor clearColor];
    listScroll.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
    listScroll.showsHorizontalScrollIndicator = NO;
    listScroll.scrollEnabled = NO;
    self.contentScorllView = listScroll;
    [self.view addSubview:listScroll];

    /** webView*/
    UIWebView * webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 -44)];
    webview.scrollView.bounces = NO;
    webview.scrollView.showsVerticalScrollIndicator = NO;
    webview.scrollView.showsHorizontalScrollIndicator = NO;
    webview.backgroundColor = [UIColor whiteColor];
    _webview = webview;
    [self.contentScorllView addSubview:webview];
    
    CollectCommentShareView * bottomView = [[CollectCommentShareView alloc]init];
//    bottomView.backgroundColor = [UIColor redColor];
    bottomView.frame = CGRectMake(0,
                                  SCREEN_HEIGHT - 64 - 45,
                                  SCREEN_WIDTH,
                                  45);
    if (kDevice_Is_iPhoneX) {
        bottomView.frame = CGRectMake(0,
                                      SCREEN_HEIGHT - 64 - 68,
                                      SCREEN_WIDTH,
                                      45);
    }
    bottomView.delegate = self;
    _bottomView = bottomView;
    [self.contentScorllView addSubview:bottomView];

}

// iPhone X 特性
-(BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}

#pragma mark - CollectCommentShareViewDelegate
- (void)bottomViewOperation:(KBottomOpreationType)type{
    if (type == KBottomFav) {
        /** 点赞*/
        [self userFavTheTactic];
    }
    if (type == KBottomCollect) {
        /** 收藏*/

        [self userCollectTactics];
        
    }
    if (type == KBottomShare) {
        /** 分享*/
        MBBInviteFriendView * shareView =[[MBBInviteFriendView alloc]init];
        [self.view addSubview:shareView];
        shareView.delegate = self;
        [shareView showInviteView];
    }
}
- (void)userCollectTactics{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"Collectionkeep";
     MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    if (!model.token) {
        MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
        [self.navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                animated:YES
                                              completion:nil];
        return;
    }

    paramDic[@"token"] = model.token;
    if (self.model.ra_id) {
        paramDic[@"c_id"] = @(self.model.ra_id);
    }
    if (self.collectModel.c_id) {
        paramDic[@"c_id"] = @(self.collectModel.c_id);
    }
    paramDic[@"type"] = @(2);/* 攻略*/
    paramDic[@"mold"] = @(1);/* 攻略*/

    [MBBNetworkManager userCollectKeep:paramDic responseResult:^(YTKBaseRequest *request) {
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
        
        }else{
        
            
        }
    }];

}
/** 点赞*/
- (void)userFavTheTactic{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"raiderfabulous";
    if (self.model.ra_id) {
        paramDic[@"id"] = @(self.model.ra_id);
    }
    if (self.collectModel.c_id) {
        paramDic[@"id"] = @(self.collectModel.c_id);
    }

    paramDic[@"type"] = @(1);
    [MBBNetworkManager userFavContent:paramDic responseResult:^(YTKBaseRequest *request) {
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
        }else{
        
        }
    }];

}
#pragma mark -MBBInviteFriendViewDelegate 
- (void)immediatelyInviteFriends:(KFriendType)friendType{
    
    /** 分享链接*/
    if(KFriendWeibo != friendType){
        [LSThirdShareLoginManager shareInfomationToFriends:(LSSDKPlatform)friendType
                                                    images:@[[UIImage imageNamed:@"AppIcon29x29"]]
                                                    urlStr:(self.shareUrl?self.shareUrl:@"")
                                                     title:@"邀伴同行即可获得优惠券"
                                                      text:@"World 大师兄 留学海外 求助神器 一站式解决新生入学 海外留学各种问题"];
    }else{
        
        [LSThirdShareLoginManager shareInfomationToFriends:(LSSDKPlatform)friendType
                                                    images:@[[UIImage imageNamed:@"AppIcon29x29"]]
                                                    urlStr:nil
                                                     title:@"邀伴同行即可获得优惠券"
                                                      text:[NSString
                                                            stringWithFormat:@"World 大师兄 留学海外 求助神器 一站式解决新生入学 海外留学各种问题,%@",self.shareUrl]];
    }
}
#pragma mark - InputTextViewDelegate
/** 确定要发送的内容*/
- (void)makeSureInputContentText:(NSString *)content{
    /** */
     MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    if (!model.token) {
        MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
        [self.navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                animated:YES
                                              completion:nil];
        return;
    }
    
    [MBProgressHUD showSuccess:@"评论成功,审核后展示" toView:self.view];

}
#pragma mark - Network
- (void)fetchDataFromServer{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    if (self.model.ra_id) {
        paramDic[@"ra_id"] = @(self.model.ra_id);
    }
    if (self.collectModel.c_id) {
        paramDic[@"ra_id"] = @(self.collectModel.c_id);
    }

    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager getTacticsShareDetail:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"status"] integerValue] > 0) {
            [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:request.responseJSONObject[@"data"][@"ra_content"]]]];
            self.shareUrl = [NSString stringWithFormat:@"%@",request.responseJSONObject[@"data"][@"ra_content"]];
        }else{
            
        }
    }];
}
@end
