//
//  MBBGetFriendTogetherController.m
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBGetFriendTogetherController.h"
#import "MBBInviteFriendView.h"
#import "MBBInviteRecordViewController.h"
#import "LSThirdShareLoginManager.h"
#import "MBBAboutUsController.h"
@interface MBBGetFriendTogetherController ()<MBBInviteFriendViewDelegate>
@property(nonatomic, strong)UIScrollView * mainScrollView;

/** 分享链接*/
@property (nonatomic, strong) NSString * inviteLink;

/** 活动图片*/
@property (nonatomic, strong) UIImageView * activityPicture;

@end

@implementation MBBGetFriendTogetherController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"邀请好友";
    
    self.inviteLink = [NSString string];
    
    [self getInvitationLinkFromServer];
    [self getActivityPicture];
    
    /** 查看规则*/
    UIButton * seeRuleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, W(60), H(17))];
    [seeRuleBtn setTitle:@"查看规则" forState:UIControlStateNormal];
    [seeRuleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [seeRuleBtn.titleLabel setFont:MBBFONT(15)];
    [seeRuleBtn addTarget:self action:@selector(seeRuleClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * selectBar = [[UIBarButtonItem alloc] initWithCustomView:seeRuleBtn];
    self.navigationItem.rightBarButtonItem = selectBar;
    /*主滚动视图*/
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    SCREEN_WIDTH,
                                                                    SCREEN_HEIGHT)];
    _mainScrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 1.2);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    _mainScrollView.backgroundColor = BASE_VC_COLOR;
    [self setupViews];

}
- (void)setupViews{
    UIImageView * header = [[UIImageView alloc]init];
    header.image = [UIImage imageNamed:@"default_big"];
    _activityPicture = header;
    [_mainScrollView addSubview:header];
        
   
    /** 立即邀请*/
    UIButton * quickBtn = [[UIButton alloc] init];
    [quickBtn setTitle:@"立即邀请" forState:UIControlStateNormal];
    [quickBtn setBackgroundImage:[UIImage imageWithColor:BUTTON_COLOR] forState:UIControlStateNormal];
    [quickBtn addTarget:self action:@selector(getFrindTogether) forControlEvents:UIControlEventTouchUpInside];
    quickBtn.clipsToBounds = YES;
    quickBtn.layer.cornerRadius = 3;
    [_mainScrollView addSubview:quickBtn];

    
    UILabel * agreementLabel = [[UILabel alloc]init];
    agreementLabel.text = @"查看邀请记录>>";
    agreementLabel.font = MBBFONT(13);
    agreementLabel.textColor = FONT_LIGHT;
    agreementLabel.textAlignment = NSTextAlignmentCenter;
    [_mainScrollView addSubview:agreementLabel];
    
    header.sd_layout
    .topSpaceToView(_mainScrollView, 0)
    .leftSpaceToView(_mainScrollView, 10)
    .widthIs(SCREEN_WIDTH - 20)
    .bottomSpaceToView(_mainScrollView, 44 + 44 + 20 + 60);
    
    
    quickBtn.sd_layout
    .topSpaceToView(header,40)
    .leftSpaceToView(_mainScrollView,40)
    .widthIs(SCREEN_WIDTH - 80)
    .heightIs(44);
    
    agreementLabel.sd_layout
    .topSpaceToView(quickBtn,10)
    .leftSpaceToView(_mainScrollView,40)
    .widthIs(SCREEN_WIDTH - 80)
    .heightIs(44);
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkRecord)];
    agreementLabel.userInteractionEnabled = YES;
    [agreementLabel addGestureRecognizer:tap];
}
/** 立即邀请*/
- (void)getFrindTogether{
    
    MBBInviteFriendView * inviteView =[[MBBInviteFriendView alloc]init];
    [self.view addSubview:inviteView];
    inviteView.delegate = self;
    [inviteView showInviteView];
}
/** 查看规则*/
- (void)seeRuleClicked{
    
    MBBAboutUsController * ruleVC = [[MBBAboutUsController alloc]init];
    ruleVC.loadType = @"1";
    ruleVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ruleVC animated:YES];
    
    
}
/** 查看记录*/
- (void)checkRecord{
    MBBInviteRecordViewController * records = [[MBBInviteRecordViewController alloc]init];
    records.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:records animated:YES];
    
}

#pragma mark -MBBInviteFriendViewDelegate
- (void)immediatelyInviteFriends:(KFriendType)friendType{
    
    
    
    /** 分享链接*/
    if(KFriendWeibo != friendType){
        [LSThirdShareLoginManager shareInfomationToFriends:(LSSDKPlatform)friendType
                                                    images:@[[UIImage imageNamed:@"AppIcon29x29"]]
                                                    urlStr:(self.inviteLink?self.inviteLink:@"")
                                                     title:@"邀伴同行即可获得优惠券"
                                                      text:@"World 大师兄 留学海外 求助神器 一站式解决新生入学 海外留学各种问题"];
    }else{
        
        [LSThirdShareLoginManager shareInfomationToFriends:(LSSDKPlatform)friendType
                                                    images:@[[UIImage imageNamed:@"AppIcon29x29"]]
                                                    urlStr:nil
                                                     title:@"邀伴同行即可获得优惠券"
                                                      text:[NSString stringWithFormat:@"World 大师兄 留学海外 求助神器 一站式解决新生入学 海外留学各种问题,%@",self.inviteLink]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 获取活动图片

- (void)getActivityPicture{
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"indexactivity";
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userGetActivityPicture:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            [_activityPicture setImageWithURL: [NSURL URLWithString:request.responseJSONObject[@"data"]] placeholder:[UIImage imageNamed:@"default_big"]];
        
        }else{
        
        
        }
    }];

    
    
}

#pragma mark - 获取分享链接
- (void)getInvitationLinkFromServer{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"invitationinvitelink";
     MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"token"] = model.token;
   
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userGetInvitelink:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            self.inviteLink = request.responseJSONObject[@"data"];
        
        }else{
            
        }
    }];
}

@end
