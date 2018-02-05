//
//  RecommendFriendController.m
//  mybigbrother
//
//  Created by SN on 2017/4/1.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "RecommendFriendController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKUI/SSUIEditorViewStyle.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>


@interface RecommendFriendController ()

/**
 *  面板
 */
@property (nonatomic, strong) UIView *panelView;

/**
 *  加载视图
 */
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property (nonatomic, strong)UIImageView *bgImgView;
@end

@implementation RecommendFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐好友";
    [self setupUI];
    
}

- (void)setupUI{
    
    UIButton * seeRuleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [seeRuleBtn setTitle:@"" forState:UIControlStateNormal];
    [seeRuleBtn setTitleColor:MBBCOLOR(144, 164, 245) forState:UIControlStateNormal];
    [seeRuleBtn.titleLabel setFont:MBBFONT(12)];
    [seeRuleBtn addTarget:self action:@selector(selectRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [seeRuleBtn setBackgroundImage:[UIImage imageNamed:@"share_friends"] forState:UIControlStateNormal];
    UIBarButtonItem * selectBar = [[UIBarButtonItem alloc] initWithCustomView:seeRuleBtn];
    self.navigationItem.rightBarButtonItem = selectBar;

    //加载等待视图
    self.panelView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.panelView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.panelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadingView.frame = CGRectMake((self.view.frame.size.width - self.loadingView.frame.size.width) / 2, (self.view.frame.size.height - self.loadingView.frame.size.height) / 2, self.loadingView.frame.size.width, self.loadingView.frame.size.height);
    self.loadingView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.panelView addSubview:self.loadingView];
    
    _bgImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"recommend_low"]];
    [self.view addSubview:_bgImgView];
    [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

- (void)selectRightButton:(UIButton *)sender
{
    [self showShareActionSheet:sender];
}

#pragma mark -

/**
 *  显示加载动画
 *
 *  @param flag YES 显示，NO 不显示
 */
- (void)showLoadingView:(BOOL)flag
{
    if (flag){
        [self.view addSubview:self.panelView];
        [self.loadingView startAnimating];
    }else{
        [self.panelView removeFromSuperview];
    }
}

#pragma mark 显示分享菜单
/**
 *  显示分享菜单
 *
 *  @param view 容器视图
 */
- (void)showShareActionSheet:(UIView *)view{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    __weak RecommendFriendController *theController = self;
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[[UIImage imageNamed:@"mine_logo.png"]];
    [shareParams SSDKSetupShareParamsByText:@"  World 大师兄App由思能教育咨询（大连）有限公司面向中国有海外教育，移民，置业，投资需求的客户及其子女进行开发，服务区域覆盖整个美国。\n    World大师兄依托发达的海外校友网络和良好的海外商业关系可以为客户及其子女提供专业的移民律师咨询服务和海外投资咨询服务等其他服务，并为客户提供一对一的专业咨询，帮助客户轻松移居海外并实现全球资产配置。"
                                     images:imageArray
                                        url:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/world%E5%A4%A7%E5%B8%88%E5%85%84/id1236644117?mt=8"]
                                      title:@"我的大师兄"
                                       type:SSDKContentTypeAuto];
    
    //2、分享
    [ShareSDK showShareActionSheet:view
                             items:@[@(SSDKPlatformSubTypeWechatSession),@(SSDKPlatformSubTypeWechatTimeline),@(SSDKPlatformSubTypeQQFriend),@(SSDKPlatformSubTypeWechatFav),@(SSDKPlatformSubTypeQZone),@(SSDKPlatformTypeSinaWeibo)]
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   switch (state) {
                       case SSDKResponseStateBegin:{
                           [theController showLoadingView:YES];
                           break;
                       }
                       case SSDKResponseStateSuccess:{
                           //Facebook Messenger、WhatsApp等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                           if (platformType == SSDKPlatformTypeFacebookMessenger){
                               break;
                           }
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:{
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201){
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }else if(platformType == SSDKPlatformTypeMail && [error code] == 201){
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else{
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           break;
                       }
                           
                       default:
                           break;
                   }
                   if (state != SSDKResponseStateBegin){
                       [theController showLoadingView:NO];
                   }
                   
               }];
    
}


@end








