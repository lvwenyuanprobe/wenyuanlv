//
//  MinePublishDetailPayController.m
//  mybigbrother
//
//  Created by SN on 2017/6/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MinePublishDetailPayController.h"

#import "DetailReplyCell.h"
#import "GetPartnerDetailHeader.h"
#import "CommentModel.h"
#import "InputTextView.h"
#import "MBBInviteFriendView.h"

#import "LSThirdShareLoginManager.h"
#import "MBBLoginContoller.h"
#import "MBBPersonalInfoShowController.h"

#import "CustomServiceDetailBottomView.h"
#import "MBBCollectMoneyController.h"
#import "PublishPartnersTogetherController.h"


@interface MinePublishDetailPayController ()<UITableViewDataSource,
UITableViewDelegate,
CustomServiceDetailBottomViewDelegate,
InputTextViewDelegate,
DetailReplyCellDelegate,
MBBInviteFriendViewDelegate>

@property (nonatomic, assign) NSInteger  devation;
@property (nonatomic, strong) NSMutableArray * publicArray;

@property (nonatomic, strong) GetPartnerDetailHeader  *  headerView;
@property (nonatomic, strong) CustomServiceDetailBottomView * bottomView;
@property (nonatomic, strong) InputTextView * inputView;
@property (nonatomic, strong) CommentModel * commentModel;

/** 分享链接*/
@property (nonatomic, strong) NSString * inviteLink;


@end

@implementation MinePublishDetailPayController

#pragma mark - 重写loadView() 重置self.view 解决IQkeyBoard导航栏漂移
-(void)loadView{
    UIScrollView * scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scr.backgroundColor = [UIColor whiteColor];
    self.view = scr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 发布*/
    UIButton * seeRuleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
    [seeRuleBtn setImage:[UIImage imageNamed:@"mine_publish"] forState:UIControlStateNormal];
    [seeRuleBtn setImage:[UIImage imageNamed:@"mine_publish"] forState:UIControlStateSelected];
    [seeRuleBtn addTarget:self action:@selector(publishPartnersTogether) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * selectBar = [[UIBarButtonItem alloc] initWithCustomView:seeRuleBtn];
    self.navigationItem.rightBarButtonItem = selectBar;

    /** 键盘回收通知*/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    [self updateData];
    // Do any additional setup after loading the view.
}
- (void)publishPartnersTogether{
    PublishPartnersTogetherController * publish = [[PublishPartnersTogetherController alloc]init];
    [self.navigationController pushViewController:publish animated:YES];
    
}

- (void)updateData{
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 45);
    
    
    InputTextView * inputView = [[InputTextView alloc]initWithFrame:CGRectMake(0,
                                                                               SCREEN_HEIGHT - 64 - 55,
                                                                               SCREEN_WIDTH,
                                                                               55)];
    inputView.delegate = self;
    inputView.hidden = YES;
    _inputView = inputView;
    
    GetPartnerDetailHeader * headerView = [[GetPartnerDetailHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 480 + 44)];
    headerView.KNavgationController = self.navigationController;
    _headerView = headerView;
    headerView.didFinishAutoLayoutBlock = ^(CGRect frame) {
        /** 布局完成表头重置frame并刷新表才可展示表头实际高度*/
        _headerView.frame = frame;
        [self.tableView reloadData];
    };
    
    [self.view addSubview:_inputView];
    [self.view addSubview:_bottomView];

}
- (void)setModel:(MinePublishCellModel *)model{
    _model = model;
    NSString * rightStr = [NSString string];
    if (model.r_price) {
        rightStr = @"支付";
    }else{
        rightStr = @"待匹配";
    }
    CustomServiceDetailBottomView * bottomView = [[CustomServiceDetailBottomView alloc]initWithFrame:CGRectMake(0,
                                                                                                                SCREEN_HEIGHT - 64 - 45,
                                                                                                                SCREEN_WIDTH,
                                                                                                                44)
                                                  
                                                                                          rightTitle:rightStr];
    bottomView.delegate = self;
    _bottomView = bottomView;
    _bottomView.servicePrice = [NSString stringWithFormat:@"总价:$ %@",model.r_price?model.r_price:@"0"];
}
#pragma mark - CustomServiceDetailBottomView
/** 付款*/
- (void)rihgtButtonClicked{
    if (!self.model.r_price) {
        [MyControl alertShow:@"系统分配中,请等待..."];
        return;
    }
    if (!self.model.r_order) {
        [MyControl alertShow:@"系统分配中,请等待..."];
        return;
    }

    MBBCollectMoneyController * commitOrderVC = [[MBBCollectMoneyController alloc]init];
    commitOrderVC.serviceId = self.model.r_order;
    commitOrderVC.orderPrice = self.model.r_price;
    [self.navigationController pushViewController:commitOrderVC animated:YES];
}
#pragma mark - 加载...
- (void)loadData{
    self.devation = 1;
    [self getDataSourceFromSever];
    
}
- (void)loadMoreData{
    self.devation = self.devation + 1;
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)getDataSourceFromSever{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"releasehomeinfo";
    paramDic[@"r_id"] = @(self.model.r_id);
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    
    [MBBNetworkManager getPartnersTogetherDetail:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            NSArray * TopModels = [PartnersTogetherModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            PartnersTogetherModel * topModel = [TopModels firstObject];
            _headerView.model = topModel;
            if ([topModel.r_status isEqualToString:@"0"]) {
                self.navigationItem.title = @"未约伴";
            }else{
                self.navigationItem.title = @"已约伴";
            }
            self.tableView.tableHeaderView = _headerView;
            NSArray * modelArray = [CommentModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"other"]];
            self.publicArray = [NSMutableArray arrayWithArray:modelArray];
            [self.tableView reloadData];
        }else{
            
        }
    }];
    [self endRefreshAnimation];
}
#pragma mark - 键盘回收处理
- (void)keyboardWillBeHidden:(NSNotification*)notification{
    [self.view bringSubviewToFront:_bottomView];
    _inputView.hidden = YES;
}
/** 注销通知*/
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - InputTextViewDelegate
/** 确定要发送的内容*/
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
    if (self.commentModel) {
        paramDic[@"reply_id"] = @(self.commentModel.put);
    }else{
        paramDic[@"reply_id"] = @(0);
    }
    paramDic[@"art_id"] = @(self.model.r_id);
    /** 约伴详情评论type*/
    paramDic[@"type_id"] = @(1);
    
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager putCommentOrReply:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"评论成功" toView:self.view];
            /** 刷新*/
            [self loadData];
        }else{
            [MBProgressHUD showError:@"评论失败" toView:self.view];
        }
        
    }];
    
    
}

#pragma mark - DetailReplyCellDelegate
- (void)operationReply:(CommentModel *)model{
    self.commentModel = model;
    _inputView.hidden = NO;
    [self.view bringSubviewToFront:_inputView];
    [_inputView.textView becomeFirstResponder];
}

- (void)reportUserContent:(CommentModel *)model{
    
    
}

- (void)scanReplyUserPersonInfo:(CommentModel *)model{
    MBBPersonalInfoShowController * personInfoShow = [[MBBPersonalInfoShowController alloc]init];
    personInfoShow.u_id = [NSString stringWithFormat:@"%ld",(long)model.put];
    [self.navigationController pushViewController:personInfoShow animated:YES];
    
}
#pragma mark - MBBInviteFriendViewDelegate
- (void)immediatelyInviteFriends:(KFriendType)friendType{
    
    
    /** 分享下载链接*/
    if(KFriendWeibo != friendType){
        [LSThirdShareLoginManager shareInfomationToFriends:(LSSDKPlatform)friendType
                                                    images:@[[UIImage imageNamed:@"AppIcon29x29"]]
                                                    urlStr:(self.inviteLink?self.inviteLink:@"https://itunes.apple.com/app/id1236644117?mt=8")
                                                     title:@"邀伴同行即可获得优惠券"
                                                      text:@"World 大师兄 留学海外 求助神器 一站式解决新生入学 海外留学各种问题"];
    }else{
        
        [LSThirdShareLoginManager shareInfomationToFriends:(LSSDKPlatform)friendType
                                                    images:@[[UIImage imageNamed:@"AppIcon29x29"]]
                                                    urlStr:nil
                                                     title:@"邀伴同行即可获得优惠券"
                                                      text:[NSString stringWithFormat:@"World 大师兄 留学海外 求助神器 一站式解决新生入学 海外留学各种问题,%@",self.inviteLink?self.inviteLink:@"https://itunes.apple.com/app/id1236644117?mt=8"]];
    }
    
}
#pragma mark - UITableViewDelegate - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.publicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"MBBPublicOrderCell";
    DetailReplyCell *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[DetailReplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.publicArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    LCActionSheet * sheet = [[LCActionSheet alloc] initWithTitle:nil cancelButtonTitle:@"取消" clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            /** 举报*/
            [MBProgressHUD showSuccess:@"我们将及时审核你提供的内容" toView:self.view];
        }
    } otherButtonTitles:@"举报", nil];
    sheet.destructiveButtonIndexSet = [NSSet setWithObject:@(1)];
    sheet.destructiveButtonColor = [UIColor redColor];
    [sheet show];
    
}

#pragma mark - 获取分享链接
- (void)getInvitationLinkFromServer{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"invitationinvitelink";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    if (!model.token) {
        MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
        [self.navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                animated:YES
                                              completion:nil];
        return;
    }
    
    paramDic[@"token"] = model.token;
    [MBBNetworkManager userGetInvitelink:paramDic responseResult:^(YTKBaseRequest *request) {
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            self.inviteLink = request.responseJSONObject[@"data"];
            
        }else{
            
        }
    }];
}

#pragma mark - 拖拽弹回
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.inputView.textView resignFirstResponder];
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
