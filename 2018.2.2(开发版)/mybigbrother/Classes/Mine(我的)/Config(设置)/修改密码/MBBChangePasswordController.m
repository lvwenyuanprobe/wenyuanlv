//
//  MBBChangePasswordController.m
//  mybigbrother
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBChangePasswordController.h"
#import "SetPasswordInputTextView.h"

@interface MBBChangePasswordController ()
@property (nonatomic, strong) SetPasswordInputTextView * originalPasswordView ;
@property (nonatomic, strong) SetPasswordInputTextView * freshPasswordView;
@property (nonatomic, strong) SetPasswordInputTextView * makesurePasswordView;
@property (nonatomic , strong) UIButton *backbtn;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic , strong) UILabel *inputTelLabel1;
@property (nonatomic , strong) UILabel *inputTelLabel2;

@property (nonatomic,strong) UIView *prePassWView;
@property (nonatomic,strong) UILabel *prePassWLabel;
@property (nonatomic,strong) UIView *oldPassWView;
@property (nonatomic,strong) UILabel *oldPassWLabel;
@property (nonatomic,strong) UIView *surePassWView;
@property (nonatomic,strong) UILabel *surePassWLabel;
@property (nonatomic,strong) UIButton * changeButton;

@end

@implementation MBBChangePasswordController

//视图将要显示时隐藏
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

//视图将要消失时取消隐藏
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"";
    
    [self setupUI];
}

- (void)setupUI{
    
    _titleLabel = [[UILabel alloc]init];
    [self.view addSubview:_titleLabel];
    _titleLabel.text = @"修改密码";
    _titleLabel.font = [UIFont systemFontOfSize:30];
    _titleLabel.textColor = RGB(18, 18, 18);
    _titleLabel.font = [UIFont boldSystemFontOfSize:30];
    
    _inputTelLabel1 = [[UILabel alloc]init];
    [self.view addSubview:_inputTelLabel1];
    _inputTelLabel1.text = @"请输入您的密码信息";
    _inputTelLabel1.textColor = RGB(102, 102, 102);
    _inputTelLabel1.font = [UIFont systemFontOfSize:14];
//
    _inputTelLabel2 = [[UILabel alloc]init];
    [self.view addSubview:_inputTelLabel2];
    _inputTelLabel2.text = @"修改您的密码";
    _inputTelLabel2.textColor = RGB(102, 102, 102);
    _inputTelLabel2.font = [UIFont systemFontOfSize:14];
    
    _prePassWView = [[UIView alloc]init];
    [self.view addSubview:_prePassWView];
    _prePassWView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _prePassWLabel = [[UILabel alloc]init];
    [_prePassWView addSubview:_prePassWLabel];
    _prePassWLabel.textColor = RGB(18, 18, 18);
    _prePassWLabel.font = [UIFont systemFontOfSize:15];
    _prePassWLabel.text = @"原密码";
    
    SetPasswordInputTextView * originalPasswordView = [[SetPasswordInputTextView alloc]init];
    originalPasswordView.passwordText.placeholder = @"请输入原密码";
    originalPasswordView.passwordText.secureTextEntry = YES;
    originalPasswordView.passwordText.clearButtonMode = UITextFieldViewModeAlways;
    [originalPasswordView.passwordText addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    [_prePassWView addSubview:originalPasswordView];
     _originalPasswordView = originalPasswordView;
    
    _oldPassWView = [[UIView alloc]init];
    [self.view addSubview:_oldPassWView];
    _oldPassWView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _oldPassWLabel = [[UILabel alloc]init];
    [_oldPassWView addSubview:_oldPassWLabel];
    _oldPassWLabel.textColor = RGB(18, 18, 18);
    _oldPassWLabel.font = [UIFont systemFontOfSize:15];
    _oldPassWLabel.text = @"新密码";
    
    SetPasswordInputTextView * newPasswordView = [[SetPasswordInputTextView alloc]init];
    [_oldPassWView addSubview:newPasswordView];
    newPasswordView.passwordText.placeholder = @"请输入新密码(6~18位数字、字母)";
    newPasswordView.passwordText.secureTextEntry = YES;
    newPasswordView.passwordText.clearButtonMode = UITextFieldViewModeAlways;
    [newPasswordView.passwordText addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    _freshPasswordView  = newPasswordView;
    
    _surePassWView = [[UIView alloc]init];
    [self.view addSubview:_surePassWView];
    _surePassWView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _surePassWLabel = [[UILabel alloc]init];
    [_surePassWView addSubview:_surePassWLabel];
    _surePassWLabel.textColor = RGB(18, 18, 18);
    _surePassWLabel.font = [UIFont systemFontOfSize:15];
    _surePassWLabel.text = @"确认密码";
    
    SetPasswordInputTextView * makesurePasswordView = [[SetPasswordInputTextView alloc]init];
    [_surePassWView addSubview:makesurePasswordView];
    makesurePasswordView.passwordText.placeholder = @"请再次确认新密码";
    makesurePasswordView.passwordText.secureTextEntry = YES;
    makesurePasswordView.passwordText.clearButtonMode = UITextFieldViewModeAlways;
    [makesurePasswordView.passwordText addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    _makesurePasswordView = makesurePasswordView;
    
    //修改密码
    UIButton * changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:changeButton];
    _changeButton = changeButton;
    [changeButton setTitle:@"修改密码" forState:UIControlStateNormal];
    [changeButton.titleLabel setFont:MBBFONT(17)];
    [changeButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    changeButton.backgroundColor = RGB(209, 209, 209);
    [changeButton addTarget:self
                     action:@selector(makeSureChangePassword:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubContrains];

}

/** 修改密码*/
- (void)makeSureChangePassword:(UIButton *)button{
    
    if (_originalPasswordView.passwordText.text.length == 0) {
        [MyControl alertShow:@"请输入原密码"];
        return;
    }
    
    if (_freshPasswordView.passwordText.text.length == 0) {
        [MyControl alertShow:@"请输入新密码"];
        return;
        
    }
    if (_makesurePasswordView.passwordText.text.length == 0) {
        [MyControl alertShow:@"请确认密码"];
        return;
        
    }
    
    if(_originalPasswordView.passwordText.text.length<6||_originalPasswordView.passwordText.text.length>18)
    {
        [MyControl alertShow:@"请输入6-18位字母或数字"];
        return;
    }
    
    if(_freshPasswordView.passwordText.text.length<6||_freshPasswordView.passwordText.text.length>18)
    {
        [MyControl alertShow:@"请输入6-18位字母或数字"];
        return;
    }
    
    if(_makesurePasswordView.passwordText.text.length<6||_makesurePasswordView.passwordText.text.length>18)
    {
        [MyControl alertShow:@"请输入6-18位字母或数字"];
        return;
    }
    
    
    if(![MyControl checkPassword:self.freshPasswordView.passwordText.text]){
        [MyControl alertShow:@"请输入6-18位字母或数字"];
        return;
    }
    
    if (![_makesurePasswordView.passwordText.text isEqualToString:_freshPasswordView.passwordText.text]) {
        [MyControl alertShow:@"确认密码错误,请重新确认密码..."];
        return;
    }
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"registerprivacy";
    paramDic[@"used_pdw"] =_originalPasswordView.passwordText.text;
    paramDic[@"new_pdw"] = _makesurePasswordView.passwordText.text;
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"token"] = model.token;
    
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userChangePassword:paramDic responseResult:^(YTKBaseRequest *request) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
            
        }else{
            [MBProgressHUD showError:@"修改失败" toView:self.view];
        }
        
    }];
}

// -  监听输入改变登录按钮颜色 -
-(void)textValueChanged{
    
    if (_originalPasswordView.passwordText.text.length != 0 && _freshPasswordView.passwordText.text.length != 0 && _makesurePasswordView.passwordText.text.length != 0) {
        // 输入完成之后的颜色
        [_changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_changeButton setBackgroundImage:[UIImage imageNamed:@"zc_anniu"] forState:UIControlStateNormal];
    }else{
        // 没有字符时的颜色
        [_changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _changeButton.backgroundColor = RGB(209, 209, 209);
    }
}

- (void)addSubContrains{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(20);
    }];
    [_inputTelLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(15);
    }];
    [_inputTelLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_inputTelLabel1);
        make.top.equalTo(_inputTelLabel1.mas_bottom).offset(10);
    }];
    [_prePassWView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(_inputTelLabel2.mas_bottom).offset(25);
        make.height.mas_equalTo(45);
    }];
    [_prePassWLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_prePassWView);
        make.left.mas_equalTo(21.5);
    }];
    [_originalPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_prePassWView);
        make.left.equalTo(_prePassWLabel.mas_right).offset(40);
        make.top.bottom.right.equalTo(_prePassWView);
    }];
    [_oldPassWView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_prePassWView);
        make.right.equalTo(_prePassWView);
        make.height.mas_equalTo(45);
        make.top.equalTo(_prePassWView.mas_bottom).offset(10);
    }];
    [_oldPassWLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(21.5);
        make.centerY.equalTo(_oldPassWView);
    }];
    [_freshPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_oldPassWLabel.mas_right).offset(40);
        make.centerY.equalTo(_oldPassWView);
        make.top.bottom.right.equalTo(_oldPassWView);
    }];
    [_surePassWView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_oldPassWView);
        make.height.mas_equalTo(45);
        make.top.equalTo(_oldPassWView.mas_bottom).offset(10);
    }];
    [_surePassWLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_surePassWView);
        make.left.equalTo(_oldPassWLabel);
//        make.width.mas_equalTo(35);
    }];
    [_makesurePasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_freshPasswordView);
        make.top.bottom.right.equalTo(_surePassWView);
        make.centerY.equalTo(_surePassWView);
    }];
    [_changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_oldPassWView);
        make.height.mas_equalTo(45);
        make.top.equalTo(_surePassWView.mas_bottom).offset(20);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end



































