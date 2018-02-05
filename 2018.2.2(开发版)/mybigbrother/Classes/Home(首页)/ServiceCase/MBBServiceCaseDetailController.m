//
//  MBBServiceCaseDetailController.m
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBServiceCaseDetailController.h"
#import "CollectCommentShareView.h"
#import "MBBInviteFriendView.h"
#import "LSThirdShareLoginManager.h"
#import "InputTextView.h"
#import "MBBLoginContoller.h"

@interface MBBServiceCaseDetailController ()<CollectCommentShareViewDelegate,
MBBInviteFriendViewDelegate,InputTextViewDelegate>
@property (nonatomic, strong) UIWebView * webview;
@property (nonatomic, strong) CollectCommentShareView * bottomView ;
@property (nonatomic, strong) NSString * shareUrl;

@end

@implementation MBBServiceCaseDetailController
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
    if (self.model.trip) {
        self.navigationItem.title = self.model.trip;
    }
    if (self.cellModel.title) {
        self.navigationItem.title = self.cellModel.title;
    }

    [self fetchDataFromServer];
    
    /** webView*/
    UIWebView * webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 64 - 55)];
    webview.scrollView.bounces = NO;
    webview.scrollView.showsHorizontalScrollIndicator = NO;
    webview.scrollView.showsVerticalScrollIndicator = NO;
    
    _webview = webview;
    [self.view addSubview:webview];

    CollectCommentShareView * bottomView = [[CollectCommentShareView alloc]init];
    
    if (kDevice_Is_iPhoneX) {
        bottomView.frame = CGRectMake(0,
                                      SCREEN_HEIGHT - 64 - 55 - 20,
                                      SCREEN_WIDTH,
                                      55);
    }else{
        bottomView.frame = CGRectMake(0,
                                      SCREEN_HEIGHT - 64 - 55,
                                      SCREEN_WIDTH,
                                      55);
    }
    bottomView.delegate = self;
    _bottomView = bottomView;
    
    
    
    [self.view addSubview:bottomView];

}
-(BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}
#pragma mark - CollectCommentShareViewDelegate
- (void)bottomViewOperation:(KBottomOpreationType)type{
    if (type == KBottomFav) {
        /** 点赞*/
        [self userFavGetTheCase];
    }
    if (type == KBottomCollect) {
        /** 收藏*/
        [self userCollectServiceCase];
    }
    if (type == KBottomShare) {
        /** 分享*/
        MBBInviteFriendView * shareView =[[MBBInviteFriendView alloc]init];
        [self.view addSubview:shareView];
        shareView.delegate = self;
        [shareView showInviteView];
    }
}
- (void)userFavGetTheCase{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"raiderfabulous";
    
    if (self.model.case_id) {
        paramDic[@"id"] = @(self.model.case_id);
    }
    if (self.cellModel.c_id) {
        paramDic[@"id"] = @(self.cellModel.c_id);
    }
    
    paramDic[@"type"] = @(2);
    [MBBNetworkManager userFavContent:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
        }else{
            
        }
    }];
    
}
- (void)userCollectServiceCase{
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
    
    
    paramDic[@"c_id"] = @(self.model.case_id);
    
    if (self.model.case_id) {
        paramDic[@"c_id"] = @(self.model.case_id);
    }
    if (self.cellModel.c_id) {
        paramDic[@"c_id"] = @(self.cellModel.c_id);
    }

    paramDic[@"type"] = @(1);/* 案例*/
    paramDic[@"mold"] = @(1);/* 收藏动作*/
    [MBBNetworkManager userCollectKeep:paramDic responseResult:^(YTKBaseRequest *request) {
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            
        }else{
            
            
        }
    }];
    
}
#pragma mark -   InputTextViewDelegate
- (void)makeSureInputContentText:(NSString *)content{
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"releasediscuss";
    paramDic[@"content"] = content;
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    
    if (!model.token) {
        MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
        [self.navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                     animated:YES
                                                   completion:nil];
        return;
    }
    paramDic[@"token"] = model.token;
    /** 约伴详情评论type*/
    paramDic[@"type_id"] = @(1);
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager putCommentOrReply:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"评论成功,审核后展示" toView:self.view];
            /** 刷新*/
        
        }else{
        
        }
        
    }];

    
}

#pragma mark - MBBInviteFriendViewDelegate
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
                                                      text:[NSString stringWithFormat:@"World 大师兄 留学海外 求助神器 一站式解决新生入学 海外留学各种问题%@",self.shareUrl]];
    }
    
}
- (void)fetchDataFromServer{
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    if (self.model.case_id) {
        paramDic[@"case_id"] = @(self.model.case_id);
    }
    if (self.cellModel.c_id) {
        paramDic[@"case_id"] = @(self.cellModel.c_id);
    }

    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager getServiceCaseDetail:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:request.responseJSONObject[@"data"][@"case_content"]]]];
            self.shareUrl = [NSString stringWithFormat:@"%@",request.responseJSONObject[@"data"][@"case_content"]];

        }else{
            
            
        }
        
    }];
    
}
#pragma mark - 赋值

- (void)setModel:(ServiceCaseModel *)model{
    
    _model = model;
}
- (void)setCellModel:(MineCollectCellModel *)cellModel{
    _cellModel = cellModel;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
