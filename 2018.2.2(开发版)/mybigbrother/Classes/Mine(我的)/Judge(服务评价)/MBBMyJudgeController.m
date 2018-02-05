//
//  MBBMyJudgeController.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBMyJudgeController.h"
#import "MyJudgeTopView.h"
#import "MyJudeMiddleView.h"
#import "MyJudgeBottomView.h"
#import "MyCommitJudgeView.h"
#import "MyJudgeStarsScoreView.h"

@interface MBBMyJudgeController ()<MyCommitJudgeViewDelegate>
@property(nonatomic, strong) UIScrollView * mainScrollView;
@property(nonatomic, strong) MyJudgeBottomView * bottomView;
@property(nonatomic, strong) MyJudeMiddleView * middleView;
@property (nonatomic,strong) MyCommitJudgeView * commitJudge;
@end

@implementation MBBMyJudgeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我要评价";
    //主滚动视图
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    SCREEN_WIDTH,
                                                                    SCREEN_HEIGHT - 44 - 64)];
    _mainScrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 1.5);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    _mainScrollView.backgroundColor = BASE_VC_COLOR;
    
    MyCommitJudgeView * commitJudge = [[MyCommitJudgeView alloc]init];
    commitJudge.frame = CGRectMake(0,
                                   SCREEN_HEIGHT - 64 - 44,
                                   SCREEN_WIDTH,
                                   44);
    commitJudge.delegate = self;
    _commitJudge = commitJudge;
    
    [self.view addSubview:commitJudge];
    [self setupSubViews];
}
- (void)setupSubViews{
    MyJudgeTopView * topView = [[MyJudgeTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    topView.judgeModel = self.model;
    [_mainScrollView addSubview:topView];
    
    MyJudeMiddleView * middleView = [[MyJudeMiddleView alloc]initWithFrame:CGRectMake(0,
                                                                                      CGRectGetMaxY(topView.frame),
                                                                                      SCREEN_WIDTH,
                                                                                      44 * 3 + 15)];
    [_mainScrollView addSubview:middleView];
    
    MyJudgeBottomView * bottomView = [[MyJudgeBottomView alloc]initWithFrame:CGRectMake(0,
                                                                                        CGRectGetMaxY(middleView.frame)+5,
                                                                                        SCREEN_WIDTH,
                                                                                        170)];
    [_mainScrollView addSubview:bottomView];
    _mainScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(bottomView.frame));
    _middleView = middleView;
    _bottomView = bottomView;
}

#pragma mark - MyCommitJudgeViewDelegate
- (void)publishMyComment{
    
    if (_bottomView.judge.scoreInt <= 2) {
        
        if(!_bottomView.feedBackTextView.text||[_bottomView.feedBackTextView.text isEqualToString:@""]){
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"请您填写宝贵意见" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [self presentViewController:alert animated:YES completion:^{
            }];
            return;
        }
        
    }
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"orderevaluate";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    if (_commitJudge.leftBtn.selected == NO) {
        paramDic[@"token"] = model.token;
    }
    paramDic[@"th_bewrite"] = @(_middleView.discrib.scoreInt);
    paramDic[@"th_quality"] = @(_middleView.quality.scoreInt);
    paramDic[@"th_price"] = @(_middleView.price.scoreInt);
    paramDic[@"th_total"] = @(_bottomView.judge.scoreInt);
    paramDic[@"th_con"] = _bottomView.feedBackTextView.text;
    paramDic[@"th_order"] = self.model.or_id;
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userOrdeEevaluation:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"评价成功" toView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
       
        }else{
            [MBProgressHUD showSuccess:@"评价失败了亲" toView:self.view];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
