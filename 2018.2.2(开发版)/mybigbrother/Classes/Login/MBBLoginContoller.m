//
//  MBBLoginContoller.m
//  mybigbrother
//
//  Created by apple on 2017/12/17.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBLoginContoller.h"
#import "MBBFastLoginView.h"
#import "MBBRegisterController.h"
#import "ForgetPasswordSetController.h"
#import "MBBUserInfoModel.h"
#import "LSThirdShareLoginManager.h"

@interface MBBLoginContoller ()<MBBFastLoginViewDelegate,UITextFieldDelegate>

@property (nonatomic , strong) UIScrollView * mainScrollView;
@property (nonatomic , strong) UIButton *backbtn;

@property (nonatomic , strong) UILabel *loginLabel;
@property (nonatomic , strong) UILabel *inputTelLabel1;
@property (nonatomic , strong) UILabel *inputTelLabel2;
// 手机号
@property (nonatomic , strong) UIView *telView;
@property (nonatomic , strong) UILabel *areaNumLabel;
@property (nonatomic , strong) UITextField *phoneTextField;
@property (nonatomic , strong) UITextField *phoneText;
// 密码
@property (nonatomic , strong) UIView *passWView;
@property (nonatomic , strong) UILabel *passWLabel;
@property (nonatomic , strong) UITextField *passTextField;
@property (nonatomic , strong) UITextField * passwordText;
// 登录
@property (nonatomic , strong) UIButton * loginBtn;

@property (nonatomic , strong) UILabel * forgetLabel;
@property (nonatomic , strong) UILabel * registerLabel;
@property (nonatomic , strong) UIView *botView;

@end

@implementation MBBLoginContoller

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 登陆成功弹回*/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissVC) name:MBB_LOGIN_IN object:nil];
    
    [self backBtn];
    [self setupUI];
    
}

- (void)setupUI{
    
    _loginLabel = [[UILabel alloc]init];
    [self.view addSubview:_loginLabel];
    _loginLabel.text = @"登录";
    _loginLabel.font = [UIFont systemFontOfSize:30];
    _loginLabel.textColor = RGB(18, 18, 18);
    _loginLabel.font = [UIFont boldSystemFontOfSize:30];
    
    _inputTelLabel1 = [[UILabel alloc]init];
    [self.view addSubview:_inputTelLabel1];
    _inputTelLabel1.text = @"请输入您的手机号码";
    _inputTelLabel1.textColor = RGB(102, 102, 102);
    _inputTelLabel1.font = [UIFont systemFontOfSize:14];
    
    _inputTelLabel2 = [[UILabel alloc]init];
    [self.view addSubview:_inputTelLabel2];
    _inputTelLabel2.text = @"登录您的账号";
    _inputTelLabel2.textColor = RGB(102, 102, 102);
    _inputTelLabel2.font = [UIFont systemFontOfSize:14];
    
  /** 手机号*/
    
    _telView = [[UIView alloc] init];
    [self.view addSubview:_telView];
    _telView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _areaNumLabel = [[UILabel alloc]init];
    [_telView addSubview:_areaNumLabel];
    _areaNumLabel.textColor = RGB(18, 18, 18);
    _areaNumLabel.font = [UIFont systemFontOfSize:15];
    _areaNumLabel.text = @"+ 86";
    
    _phoneText = [[UITextField alloc]init];
    _phoneText.placeholder = @"请输入手机号";
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    _phoneText.clearButtonMode = UITextFieldViewModeAlways;
    _phoneText.font = [UIFont systemFontOfSize:15];
    [_telView addSubview:_phoneText];
    _phoneTextField = _phoneText;
    
    [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_telView);
        make.left.equalTo(_areaNumLabel.mas_right).offset(40);
        make.right.equalTo(_telView);
        make.top.equalTo(_telView);
        make.bottom.equalTo(_telView);
    }];
    
// 密码
    _passWView = [[UIView alloc] init];
    [self.view addSubview:_passWView];
    _passWView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _passWLabel = [[UILabel alloc]init];
    [_passWView addSubview:_passWLabel];
    _passWLabel.textColor = RGB(18, 18, 18);
    _passWLabel.font = [UIFont systemFontOfSize:15];
    _passWLabel.text = @"密码";
    
    _passwordText = [[UITextField alloc]init];
    _passwordText.placeholder = @"请输入密码(6~16位数字、字母)";
    _passwordText.secureTextEntry = YES;
    _passwordText.clearButtonMode = UITextFieldViewModeAlways;
    _passwordText.font = [UIFont systemFontOfSize:15];
    [_passWView addSubview:_passwordText];
    _passTextField = _passwordText;
    
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_passWView);
        make.left.equalTo(_passWLabel.mas_right).offset(40);
        make.right.equalTo(_passWView);
        make.top.equalTo(_passWView);
        make.bottom.equalTo(_passWView);
    }];
    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn.titleLabel setFont:MBBFONT(17)];
    [_loginBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    _loginBtn.backgroundColor = RGB(209, 209, 209);
    [_loginBtn addTarget:self action:@selector(loginClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    /** 忘记密码*/
    _forgetLabel = [[UILabel alloc]init];
    _forgetLabel.text = @"忘记密码?";
    _forgetLabel.font = MBBFONT(13);
    _forgetLabel.textColor = MBBHEXCOLOR(0x999999);
    _forgetLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_forgetLabel];
    
    /** 免费注册*/
    _registerLabel = [[UILabel alloc]init];
    _registerLabel.text = @"没有账号? 免费注册";
    _registerLabel.font = MBBFONT(13);
    _registerLabel.textColor = MBBHEXCOLOR(0xfb6030);
    NSMutableAttributedString * registerStr  = [MyControl originalStr:_registerLabel.text position:5 color:FONT_LIGHT];
    _registerLabel.attributedText = registerStr;
    _registerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_registerLabel];
    
    /** 快捷登陆 */
    MBBFastLoginView * fastView = [[MBBFastLoginView alloc]init];
    [self.view addSubview:fastView];
    fastView.delegate = self;
    [fastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(150);
    }];
    
    UITapGestureRecognizer * forgetPasswordTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forgetPasswordTap)];
    _forgetLabel.userInteractionEnabled = YES;
    [_forgetLabel addGestureRecognizer:forgetPasswordTap];
    
    UITapGestureRecognizer * freeRegister = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(freeRegisterTap)];
    _registerLabel.userInteractionEnabled = YES;
    [_registerLabel addGestureRecognizer:freeRegister];
    
    
#pragma mark - 设置代理 -
    _phoneTextField.delegate = self;
    _passTextField.delegate = self;
    _loginBtn.enabled = NO;
    _loginBtn.backgroundColor = RGB(209, 209, 209);
    
    [self addSubContrains];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    BOOL isOK = YES;//记录用户输入是否合法
    if (textField!=self.phoneText&&self.phoneText.text.length==0) {
        isOK = NO;
    }else if(textField!=self.passwordText&&self.passwordText.text.length==0){
        isOK = NO;
    }else if(range.location == 0&&[string isEqualToString:@""]&&string == nil&&string == NULL){
        isOK = NO;
    }
    
    if (isOK) {
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"zc_anniu"] forState:UIControlStateNormal];
        self.loginBtn.enabled = YES;
    }else{
        _loginBtn.backgroundColor = RGB(209, 209, 209);
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.loginBtn.enabled = NO;
    }
    
    return YES;
}

- (void)loginClicked{
    
    if(self.phoneTextField.text.length==0)
    {
        [MyControl alertShow:@"请输入手机号"];
        return;
    }
    if (![MyControl isPhoneNumber:self.phoneTextField.text]) {
        
        [MyControl alertShow:@"请输入正确的手机号码"];
        
        return;
    }
    if(self.passTextField.text.length==0)
    {
        [MyControl alertShow:@"请输入密码"];
        return;
    }
    
    if(self.passTextField.text.length<6||self.passTextField.text.length>16)
    {
        [MyControl alertShow:@"请输入6-16位字母或数字"];
        return;
    }
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"registerlogin";
    paramDic[@"phone"] = self.phoneTextField.text;
    paramDic[@"pwd"] = self.passTextField.text;
    paramDic[@"registration_id"] = [MBBToolMethod getJPushRegistrationID];
    
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userLogin:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"登陆成功" toView:self.view];
            /** 建立映射模型*/
            MBBUserInfoModel * model =  [[MBBUserInfoModel alloc]initWithDictionary:request.responseJSONObject];
            NSDictionary * infoDic = [model toDictionary];
            /** 写入本地(不能有null)*/
            [MBBToolMethod setUserInfo:infoDic];
            ZXLog(@"%@",model.token);
            /** 登陆成功通知*/
            [[NSNotificationCenter defaultCenter]postNotificationName:MBB_LOGIN_IN object:nil];
            
        }else{
            
            [MBProgressHUD showError:request.responseJSONObject[@"other"]?request.responseJSONObject[@"other"]:@"登陆失败..重新登陆" toView:self.view];
        }
    }];
}

#pragma mark - MBBFastLoginViewDelegate
- (void)fastLoginWith:(KLoginMethodType)method{
    
    [LSThirdShareLoginManager thirdAuthorizeLogin:(LSSDKPlatform)method];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)dismissVC{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view  endEditing:YES];
}


/** 免费注册*/
- (void)freeRegisterTap{
    MBBRegisterController * registerVC = [[MBBRegisterController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
/** 忘记密码*/
- (void)forgetPasswordTap{
    ForgetPasswordSetController * resetPasswordVC = [[ForgetPasswordSetController alloc]init];
    [self.navigationController pushViewController:resetPasswordVC animated:YES];
}

- (void)addSubContrains{
    
    [_loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backbtn);
        make.top.equalTo(_backbtn.mas_bottom).offset(25);
    }];
    [_inputTelLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_loginLabel);
        make.top.equalTo(_loginLabel.mas_bottom).offset(15);
    }];
    [_inputTelLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_inputTelLabel1);
        make.top.equalTo(_inputTelLabel1.mas_bottom).offset(5);
    }];
    [_telView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(45);
        make.top.equalTo(_inputTelLabel2.mas_bottom).offset(25);
    }];
    [_areaNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(21.5);
        make.centerY.equalTo(_telView);
        make.width.mas_equalTo(35);
    }];
    [_passWView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(45);
        make.top.equalTo(_telView.mas_bottom).offset(10);
    }];
    [_passWLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(21.5);
        make.centerY.equalTo(_passWView);
        make.width.mas_equalTo(35);
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(45);
        make.top.equalTo(_passWView.mas_bottom).offset(20);
    }];
    [_forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_loginBtn);
        make.top.equalTo(_loginBtn.mas_bottom).offset(10);
    }];
    [_registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_loginBtn);
        make.centerY.equalTo(_forgetLabel);
    }];
    
}

#pragma mark - 返回按钮 -
- (void)backBtn{
    
    _backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backbtn setImage:[UIImage imageNamed:@"cz_gb"] forState:UIControlStateNormal];
//    _backbtn.frame = CGRectMake(20, 45, 45, 45);
    [_backbtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backbtn];
    [_backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(45);
    }];
}
- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
