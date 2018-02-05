//
//  ChangePersonalInfoController.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ChangePersonalInfoController.h"
#import "MBBCustomTextView.h"

@interface ChangePersonalInfoController ()
@property (nonatomic, strong) MBBCustomTextView * changeInfo;
@end

@implementation ChangePersonalInfoController

-(void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    self.navigationItem.title = _navTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    /** 保存*/
    UIButton * seeRuleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 17)];
    [seeRuleBtn setTitle:@"保存" forState:UIControlStateNormal];
    [seeRuleBtn setTitleColor:[UIColor colorWithHexString:@"#fb6030"] forState:UIControlStateNormal];
    [seeRuleBtn.titleLabel setFont:MBBFONT(15)];
    [seeRuleBtn addTarget:self action:@selector(keepInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * selectBar = [[UIBarButtonItem alloc] initWithCustomView:seeRuleBtn];
    self.navigationItem.rightBarButtonItem = selectBar;

    UIView * mainView =[[UIView alloc]initWithFrame:CGRectMake(0,
                                                               20,
                                                               SCREEN_WIDTH,
                                                               60)];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainView];
    mainView.layer.borderColor = [UIColor colorWithHexString:@"#d6d6d6"].CGColor;
    mainView.layer.borderWidth = 0.5;
   
    MBBCustomTextView * changeInfo = [[MBBCustomTextView alloc]initWithFrame:CGRectMake(20,
                                                                     10,
                                                                     SCREEN_WIDTH - 30,
                                                                     50)
                                           andPlaceholder:@"请输入..."
                                      andPlaceholderColor:FONT_LIGHT];
    [mainView addSubview:changeInfo];
    if ([self.changeKey isEqualToString:@"u_passport"]) {
        changeInfo.keyboardType = UIKeyboardTypeNumberPad;
    }
    [changeInfo becomeFirstResponder];
    _changeInfo = changeInfo;
    changeInfo.placeholderLabel.text = _placeholder?_placeholder:@"请输入...";
    
}
/*** 保存*/
- (void)keepInfo{
    
    [self.view endEditing:YES];
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    
    paramDic[@"sign"] = @"registerpersonaldata";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"u_id"] = @(model.user.uid);
    paramDic[@"u_type"] = @(model.user.type);
    paramDic[@"token"] = model.token;

    NSString * changeKey = _changeKey;
    if (_changeInfo.text != nil) {
        paramDic[changeKey] = _changeInfo.text;
    }else{
        return;
    }
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userChangePersonalData:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"成功" toView:self.view];
            
            self.changeStrBlock(_changeInfo.text);
            MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
            if ([changeKey isEqualToString:@"u_nickname"]) {
                model.user.nickName = _changeInfo.text;
                /** 刷新个人中心表头*/
                [[NSNotificationCenter defaultCenter]postNotificationName:MBB_LOGIN_IN object:nil];
            }
            if ([changeKey isEqualToString:@"u_name"]) {
                model.user.name = _changeInfo.text;
            }
            if ([changeKey isEqualToString:@"x_passport"]) {
                model.user.passportNum = _changeInfo.text;
            }
            if ([changeKey isEqualToString:@"x_school"]) {
                model.user.school = _changeInfo.text;
            }
            if ([changeKey isEqualToString:@"x_grade"]) {
                model.user.grade = _changeInfo.text;
            }
            if ([changeKey isEqualToString:@"u_urgent"]) {
                model.user.urgent = _changeInfo.text;
            }
            if ([changeKey isEqualToString:@"u_autograph"]) {
                model.user.autograph = _changeInfo.text;
                /** 刷新个人中心表头*/
                [[NSNotificationCenter defaultCenter]postNotificationName:MBB_LOGIN_IN object:nil];

            }
            /** 更新本地*/
            NSDictionary * infoDic = [model toDictionary];
            [MBBToolMethod setUserInfo:infoDic];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [MBProgressHUD showError:@"好像失败啦,请重试" toView:self.view];
        }
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
