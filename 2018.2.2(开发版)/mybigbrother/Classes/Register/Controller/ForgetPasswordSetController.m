//
//  ForgetPasswordSetController.m
//  mybigbrother
//
//  Created by apple on 2017/12/19.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ForgetPasswordSetController.h"
#import "SetPasswordInputTextView.h"
#import "CountryChooseView.h"
#import "LSCountryTableController.h"
#import <CommonCrypto/CommonDigest.h>
#import "MBBLoginContoller.h"

@interface ForgetPasswordSetController ()<CountryChooseViewDelegate>

@property (nonatomic, strong) UIButton * getCodeBtn ;
@property (nonatomic, strong) SetPasswordInputTextView * phoneView;
@property (nonatomic, strong) SetPasswordInputTextView * codeView ;
@property (nonatomic, strong) SetPasswordInputTextView * freshPasswordView;
@property (nonatomic, strong) CountryChooseView * country;

@property (nonatomic , strong) UIButton *backbtn;
@property (nonatomic , strong) UILabel *forgetLabel;
@property (nonatomic , strong) UILabel *inputTelLabel1;
@property (nonatomic , strong) UILabel *inputTelLabel2;
@property (nonatomic,strong) UIView *telView;
@property (nonatomic , strong) UILabel *areaNumLabel;
@property (nonatomic,strong) UIView *inputVerView;
@property (nonatomic,strong) UILabel *verLabel;
@property (nonatomic,strong) UIView *passWView;
@property (nonatomic,strong) UILabel *passWLabel;
@property (nonatomic,strong) UIButton * reLoginBtn;
@end

@implementation ForgetPasswordSetController

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
    // Do any additional setup after loading the view.
    
    /** 地理区号*/
    UIView * CTBgView =[[UIView alloc]init];
    CTBgView.backgroundColor = [UIColor whiteColor];
    
    CountryChooseView * country = [[CountryChooseView alloc]init];
    country.delegate = self;
    country.countryNum = @"+86";
    _country = country;
    
    [self backBtn];
    [self setupUI];
}

- (void)setupUI{
    
    _forgetLabel = [[UILabel alloc]init];
    [self.view addSubview:_forgetLabel];
    _forgetLabel.text = @"忘记密码";
    _forgetLabel.font = [UIFont systemFontOfSize:30];
    _forgetLabel.textColor = RGB(18, 18, 18);
    _forgetLabel.font = [UIFont boldSystemFontOfSize:30];
    
    _inputTelLabel1 = [[UILabel alloc]init];
    [self.view addSubview:_inputTelLabel1];
    _inputTelLabel1.text = @"请输入您的手机号码";
    _inputTelLabel1.textColor = RGB(102, 102, 102);
    _inputTelLabel1.font = [UIFont systemFontOfSize:14];
    
    _inputTelLabel2 = [[UILabel alloc]init];
    [self.view addSubview:_inputTelLabel2];
    _inputTelLabel2.text = @"来设置新的密码";
    _inputTelLabel2.textColor = RGB(102, 102, 102);
    _inputTelLabel2.font = [UIFont systemFontOfSize:14];
    
    _telView = [[UIView alloc]init];
    [self.view addSubview:_telView];
    _telView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _areaNumLabel = [[UILabel alloc]init];
    [_telView addSubview:_areaNumLabel];
    _areaNumLabel.textColor = RGB(18, 18, 18);
    _areaNumLabel.font = [UIFont systemFontOfSize:15];
    _areaNumLabel.text = @"+ 86";
    
    SetPasswordInputTextView * phoneView = [[SetPasswordInputTextView alloc]init];
    [_telView addSubview:phoneView];
    phoneView.passwordText.placeholder = @"请输入手机号";
    phoneView.passwordText.font = [UIFont systemFontOfSize:15];
    phoneView.passwordText.keyboardType = UIKeyboardTypeNumberPad;
//    phoneView.passwordText.clearButtonMode = UITextFieldViewModeAlways;
    [phoneView.passwordText addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    _phoneView = phoneView;
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_areaNumLabel.mas_right).offset(50);
        make.right.top.bottom.equalTo(_telView);
    }];
    
    _inputVerView = [[UIView alloc]init];
    [self.view addSubview:_inputVerView];
    _inputVerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _verLabel = [[UILabel alloc]init];
    [self.inputVerView addSubview:_verLabel];
    _verLabel.font = [UIFont systemFontOfSize:15];
    _verLabel.textColor = RGB(18, 18, 18);
    _verLabel.text = @"验证码";
    
    SetPasswordInputTextView * codeView = [[SetPasswordInputTextView alloc]init];
    codeView.passwordText.placeholder = @"请输入验证码";
    codeView.passwordText.font = [UIFont systemFontOfSize:15];
    codeView.passwordText.keyboardType = UIKeyboardTypeNumberPad;
//    codeView.passwordText.clearButtonMode = UITextFieldViewModeAlways;
    [codeView.passwordText addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    [_inputVerView addSubview:codeView];
//    codeView.backgroundColor = [UIColor greenColor];
    _codeView = codeView;
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_verLabel.mas_right).offset(40);
        make.right.top.bottom.equalTo(_inputVerView);
        make.height.mas_equalTo(45);
    }];
    
    UIButton * getCode = [[UIButton alloc] init];
    [getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCode.titleLabel setFont:MBBFONT(15)];
    [getCode setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    getCode.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [getCode addTarget:self action:@selector(getCodeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _getCodeBtn = getCode;
    [self.view addSubview:getCode];
    
    _passWView = [[UIView alloc]init];
    [self.view addSubview:_passWView];
    _passWView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _passWLabel = [[UILabel alloc]init];
    [_passWView addSubview:_passWLabel];
    _passWLabel.font = [UIFont systemFontOfSize:15];
    _passWLabel.text = @"密码";
    _passWLabel.textColor = RGB(18, 18, 18);
    
    SetPasswordInputTextView * freshPasswordView = [[SetPasswordInputTextView alloc]init];
    [_passWView addSubview:freshPasswordView];
    freshPasswordView.passwordText.placeholder = @"请输入新密码(6~18位字母、数字)";
    freshPasswordView.passwordText.secureTextEntry = YES;
    freshPasswordView.passwordText.font = [UIFont systemFontOfSize:15];
    [freshPasswordView.passwordText addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    _freshPasswordView = freshPasswordView;
    [freshPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_passWLabel.mas_right).offset(50);
        make.right.equalTo(_passWView);
        make.top.bottom.equalTo(_passWView);
    }];
    
    UIButton * reLoginBtn = [[UIButton alloc] init];
    [self.view addSubview:reLoginBtn];
    [reLoginBtn setTitle:@"重新登录" forState:UIControlStateNormal];
    [reLoginBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    reLoginBtn.backgroundColor = RGB(209, 209, 209);
    reLoginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [reLoginBtn addTarget:self action:@selector(reloginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _reLoginBtn = reLoginBtn;
    
    
    [self addSubContrains];
}

// -  监听输入改变登录按钮颜色 -
-(void)textValueChanged{
    
    if (_phoneView.passwordText.text.length != 0 && _codeView.passwordText.text.length != 0 && _freshPasswordView.passwordText.text.length != 0) {
        // 输入完成之后的颜色
        [_reLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_reLoginBtn setBackgroundImage:[UIImage imageNamed:@"zc_anniu"] forState:UIControlStateNormal];
    }else if (_phoneView.passwordText.text.length != 0){
        // 输入完成之后的颜色
        [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"zc_anniu"] forState:UIControlStateNormal];
    }
    else{
        // 没有字符时的颜色
        [_reLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _reLoginBtn.backgroundColor = RGB(209, 209, 209);
    }
}

#pragma mark - CountryChooseViewDelegate
- (void)makeChoiceCountry:(CountryChooseView *)countryCodeView{
    LSCountryTableController * country =[[LSCountryTableController alloc]init];
    country.countryBlock = ^(CountryNameModel *model) {
        _country.countryNum = [NSString stringWithFormat:@"+%@",model.code];
    };
    [self.navigationController pushViewController:country animated:YES];
}

/** 重新登陆*/
- (void)reloginButtonClicked{
    
    if(self.freshPasswordView.passwordText.text.length<6||self.freshPasswordView.passwordText.text.length>18)
    {
        [MyControl alertShow:@"请输入6-18位字母或数字"];
        return;
    }
    if(![MyControl checkPassword:self.freshPasswordView.passwordText.text]){
        [MyControl alertShow:@"请输入6-18位字母或数字"];
        return;
    }
    
    if (!_codeView.passwordText.text) {
        [MyControl alertShow:@"输入验证码"];
        return;
    }
    if (!_phoneView.passwordText.text) {
        [MyControl alertShow:@"请输入手机号码"];
        return;
    }
    /** 国内号码判断*/
    if ([_country.countryNum isEqualToString:@"+86"]) {
        if(_phoneView.passwordText.text.length != 0 && ![MyControl isPhoneNumber:_phoneView.passwordText.text]){
            [MyControl alertShow:@"请输入正确的手机号"];
            return;
        }
    }
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"registerforgetpwd";
    paramDic[@"phone"] = _phoneView.passwordText.text;
    paramDic[@"pwd"] = _freshPasswordView.passwordText.text;
    paramDic[@"code"] = _codeView.passwordText.text;
    paramDic[@"areacode"] = [_country.countryNum substringFromIndex:1]?[_country.countryNum substringFromIndex:1]:@"";
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userForgetPassword:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [MBProgressHUD showError:@"发送失败" toView:self.view];
        }
        
    }];
}

/** 获取验证码*/
- (void)getCodeButtonClicked{
    
    if (_phoneView.passwordText.text.length == 0) {
        [MyControl alertShow:@"请输入原手机号"];
        return;
    }
    /** 国内号码判断*/
    if ([_country.countryNum isEqualToString:@"+86"]) {
        if(_phoneView.passwordText.text.length != 0 && ![MyControl isPhoneNumber:_phoneView.passwordText.text]){
            [MyControl alertShow:@"请输入正确的手机号"];
            return;
        }
    }
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    NSString * str = @"abcdefghijkabcdefg";
    NSString * key = @"@#$%";
    NSString * signStr =[self withPhonerNum:_phoneView.passwordText.text signStr:str keyStr:key];
    
    
    
    paramDic[@"phone"] = _phoneView.passwordText.text;
    paramDic[@"sign"] = signStr;
    
    [MBProgressHUD showMessage:@"发送中...请稍后" toView:self.view];
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    [manager GET:[NSString stringWithFormat:@"http://api.worldbuddy.cn/home/register/obtaincode?phone=%@&sign=%@",_phoneView.passwordText.text,signStr] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"msg"] integerValue] == 200) {
            [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
            
            
        }else {
            
            [MBProgressHUD showError:@"发送失败" toView:self.view];
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"failure--%@",error);
    }];
    

    //    [MBBNetworkManager userRegisterPhoneMessage:paramDic responseResult:^(YTKBaseRequest *request) {
    //        [MBProgressHUD hideHUDForView:self.view animated:YES];
    //        /** 请求成功*/
    //        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
    //            [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
    //
    //        }else{
    //            [MBProgressHUD showError:@"发送失败" toView:self.view];
    //        }
    //
    //    }];
    /** 前置判断(手机号 验证码的输入)*/
    [MyControl countDownSeconds:^(NSString *resultStr) {
        [_getCodeBtn setTitle:resultStr forState:UIControlStateNormal];
    }];
}
-(NSString*)withPhonerNum:(NSString*)num signStr:(NSString*)signStr keyStr:(NSString*)keyStr {
    NSString * sign = @"";
    
    
    for (int i = 0; i < num.length; i++) {
        
        
        
        sign= [sign stringByAppendingString:[NSString stringWithFormat:@"%@%@",[num substringWithRange:NSMakeRange(i, 1)],[signStr substringWithRange:NSMakeRange(i, 1)]]];
        
    }
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",sign,keyStr]);
    NSLog(@"%@",[self MD5ForLower32Bate:[NSString stringWithFormat:@"%@%@",sign,keyStr]]);
    return [self MD5ForLower32Bate:[NSString stringWithFormat:@"%@%@",sign,keyStr]];
}
/**
 *  MD5加密, 16位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
-(NSString *)MD5ForLower16Bate:(NSString *)str{
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
-(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addSubContrains{
    
    [_forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backbtn);
        make.top.equalTo(_backbtn.mas_bottom).offset(25);
    }];
    [_inputTelLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_forgetLabel);
        make.top.equalTo(_forgetLabel.mas_bottom).offset(15);
    }];
    [_inputTelLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_inputTelLabel1);
        make.top.equalTo(_inputTelLabel1.mas_bottom).offset(5);
    }];
    [_telView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(_inputTelLabel2.mas_bottom).offset(25);
        make.height.mas_equalTo(45);
    }];
    [_areaNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(21.5);
        make.centerY.equalTo(_telView);
        make.width.mas_equalTo(35);
    }];
    [_inputVerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_telView);
        make.height.mas_equalTo(45);
        make.top.equalTo(_telView.mas_bottom).offset(10);
        make.width.mas_equalTo(230);
    }];
    [_verLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_inputVerView);
        make.left.mas_equalTo(21.5);
    }];
    [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.right.equalTo(_telView);
        make.left.equalTo(_inputVerView.mas_right).offset(10);
        make.centerY.equalTo(_inputVerView);
    }];
    [_passWView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_telView);
        make.height.mas_equalTo(45);
        make.top.equalTo(_inputVerView.mas_bottom).offset(10);
    }];
    [_passWLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_passWView);
        make.left.equalTo(_verLabel);
    }];
    [_reLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.top.equalTo(_passWView.mas_bottom).offset(20);
        make.left.right.equalTo(_passWView);
    }];

}

#pragma mark - 返回按钮 -
- (void)backBtn{
    
    _backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backbtn setImage:[UIImage imageNamed:@"cz_gb"] forState:UIControlStateNormal];
    [_backbtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backbtn];
    [_backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(45);
    }];
}
- (void)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end







