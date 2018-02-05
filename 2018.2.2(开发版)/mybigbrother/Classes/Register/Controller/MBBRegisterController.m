//
//  MBBRegisterController.m
//  mybigbrother
//
//  Created by apple on 2017/12/18.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBRegisterController.h"
#import "MBBFastLoginView.h"
#import "LSThirdShareLoginManager.h"
#import "MBBAboutUsController.h"
#import "CountryChooseView.h"
#import "LSCountryTableController.h"
#import<CommonCrypto/CommonDigest.h>
@interface MBBRegisterController ()<UITextFieldDelegate,MBBFastLoginViewDelegate,CountryChooseViewDelegate>
@property (nonatomic, strong) UITextField * passTextField;

@property (nonatomic, strong) UIButton * getCodeBtn ;
@property (nonatomic, strong) CountryChooseView * country;
@property (nonatomic , strong) UIButton *backbtn;

@property (nonatomic , strong) UILabel *registerLabel;
@property (nonatomic , strong) UILabel *inputTelLabel1;
@property (nonatomic , strong) UILabel *inputTelLabel2;

@property (nonatomic,strong) UIView *telView;
@property (nonatomic,strong) UIView *VerificationView;
@property (nonatomic,strong) UILabel *verLabel;

@property (nonatomic,strong) UIView *passWView;
@property (nonatomic,strong) UILabel *passWLabel;
@property (nonatomic,strong) UILabel * agreementLabel;

@property (nonatomic,strong) UIButton * registerBtn;
@property (nonatomic , strong) UILabel *areaNumLabel;

@end

@implementation MBBRegisterController

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
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWasShown:)
     name:UIKeyboardWillShowNotification
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillBeHidden:)
     name:UIKeyboardWillHideNotification
     object:nil];
    
    // Do any additional setup after loading the view.
    
    [self backBtn];
    [self setupUI];
}

#pragma mark - 键盘
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWasShown:(NSNotification *)aNotification {

    [self.view setFrame:CGRectMake(0, -[UIView setWidth:50], SCREEN_WIDTH,
                                   self.view.size.height)];
}
- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.size.height)];
}

- (void)setupUI{
    
    _registerLabel = [[UILabel alloc]init];
    [self.view addSubview:_registerLabel];
    _registerLabel.text = @"注册";
    _registerLabel.font = [UIFont systemFontOfSize:30];
    _registerLabel.textColor = RGB(18, 18, 18);
    _registerLabel.font = [UIFont boldSystemFontOfSize:30];
    
    _inputTelLabel1 = [[UILabel alloc]init];
    [self.view addSubview:_inputTelLabel1];
    _inputTelLabel1.text = @"请输入您的手机号码";
    _inputTelLabel1.textColor = RGB(102, 102, 102);
    _inputTelLabel1.font = [UIFont systemFontOfSize:14];
    
    _inputTelLabel2 = [[UILabel alloc]init];
    [self.view addSubview:_inputTelLabel2];
    _inputTelLabel2.text = @"注册您的账号";
    _inputTelLabel2.textColor = RGB(102, 102, 102);
    _inputTelLabel2.font = [UIFont systemFontOfSize:14];
    
    _telView = [[UIView alloc]init];
    [self.view addSubview:_telView];
    _telView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    /** 地理区号*/
//    _country = [[CountryChooseView alloc]init];
//    [self.telView addSubview:_country];
//    _country.delegate = self;
//    _country.backgroundColor = MBBCOLOR(246, 246, 246);
//    /** 初始值*/
//    _country.countryNum = @"+ 86";
//    _country.delegate = self;
    
    // 暂时写死，后期更改
    _areaNumLabel = [[UILabel alloc]init];
    [_telView addSubview:_areaNumLabel];
    _areaNumLabel.textColor = RGB(18, 18, 18);
    _areaNumLabel.font = [UIFont systemFontOfSize:15];
    _areaNumLabel.text = @"+ 86";
    
    // 手机号
    UITextField * phoneText = [[UITextField alloc]init];
    phoneText.placeholder = @"请输入手机号";
    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    [phoneText addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    [self.telView addSubview:phoneText];
    _phoneTextField = phoneText;
    phoneText.font = [UIFont systemFontOfSize:15];
    phoneText.clearButtonMode = UITextFieldViewModeAlways;
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_telView);
        make.left.equalTo(_areaNumLabel.mas_right).offset(50);
        make.right.equalTo(_telView);
        make.top.equalTo(_telView);
        make.bottom.equalTo(_telView);
    }];
    
    /** 验证码*/
    _VerificationView = [[UIView alloc]init];
    [self.view addSubview:_VerificationView];
    _VerificationView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _verLabel = [[UILabel alloc]init];
    [_VerificationView addSubview:_verLabel];
    _verLabel.text = @"验证码";
    _verLabel.font = [UIFont systemFontOfSize:15];
    _verLabel.textColor = RGB(18, 18, 18);
    
    UITextField * vetifyCodeText = [[UITextField alloc]init];
    [self.VerificationView addSubview:vetifyCodeText];
    vetifyCodeText.placeholder = @"请输入验证码";
    vetifyCodeText.font = [UIFont systemFontOfSize:15];
    vetifyCodeText.keyboardType = UIKeyboardTypeNumberPad;
    vetifyCodeText.clearButtonMode = UITextFieldViewModeAlways;
    [vetifyCodeText addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    _vetifyCodeTextField = vetifyCodeText;
    [vetifyCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_VerificationView);
        make.left.equalTo(_verLabel.mas_right).offset(40);
        make.right.equalTo(_VerificationView);
    }];
    
    /** 获取验证码*/
    UIButton * getCode = [[UIButton alloc] init];
    [getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCode.titleLabel setFont:MBBFONT(15)];
    [getCode setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    getCode.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:getCode];
    [getCode addTarget:self action:@selector(getCodeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _getCodeBtn = getCode;
    [getCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.right.mas_equalTo(-10);
        make.left.equalTo(_VerificationView.mas_right).offset(10);
        make.centerY.equalTo(_VerificationView);
    }];
    
    //登录密码
    _passWView = [[UIView alloc]init];
    [self.view addSubview:_passWView];
    _passWView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _passWLabel = [[UILabel alloc]init];
    [_passWView addSubview:_passWLabel];
    _passWLabel.text = @"密码";
    _passWLabel.font = [UIFont systemFontOfSize:15];
    _passWLabel.textColor = RGB(18, 18, 18);
    
    UITextField * passwordText = [[UITextField alloc]init];
    [_passWView addSubview:passwordText];
    passwordText.secureTextEntry = YES;
    passwordText.placeholder = @"请输入密码(6~18位数字、字母)";
    passwordText.font = [UIFont systemFontOfSize:15];
    passwordText.clearButtonMode = UITextFieldViewModeAlways;
    [passwordText addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    _passTextField = passwordText;
    
    [passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_passWView);
        make.left.equalTo(_passWLabel.mas_right).offset(40);
        make.right.equalTo(_passWView);
        make.top.bottom.equalTo(_passWView);
    }];
    
    /** 用户协议*/
    _agreementLabel = [[UILabel alloc]init];
    [self.view addSubview:_agreementLabel];
    _agreementLabel.text = @"注册即表示我同意《用户协议》";
    _agreementLabel.font = MBBFONT(13);
    _agreementLabel.textColor = MBBHEXCOLOR(0xfb6030);
    _agreementLabel.textAlignment = NSTextAlignmentCenter;
    _agreementLabel.attributedText = [MyControl originalStr:_agreementLabel.text position:6 color:FONT_LIGHT];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getAgreement)];
    _agreementLabel.userInteractionEnabled = YES;
    [_agreementLabel addGestureRecognizer:tap];
    
    /** 立即注册*/
    _registerBtn = [[UIButton alloc] init];
    [self.view addSubview:_registerBtn];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    _registerBtn.backgroundColor = RGB(209, 209, 209);
    [_registerBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [_registerBtn.titleLabel setFont:MBBFONT(17)];
    
    /** 快捷登陆*/
    MBBFastLoginView * fastView = [[MBBFastLoginView alloc]init];
    [self.view addSubview:fastView];
    fastView.delegate = self;
    [fastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(150);
    }];

    [self addcontrains];
}

// -  监听输入改变登录按钮颜色 -
-(void)textValueChanged{
    
    if (_phoneTextField.text.length != 0 && _vetifyCodeTextField.text.length != 0 && _passTextField.text.length != 0) {
        // 输入完成之后的颜色
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerBtn setBackgroundImage:[UIImage imageNamed:@"zc_anniu"] forState:UIControlStateNormal];
    }else if (_phoneTextField.text.length != 0){
        // 输入完成之后的颜色
        [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"zc_anniu"] forState:UIControlStateNormal];
    }
    else{
        // 没有字符时的颜色
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registerBtn.backgroundColor = RGB(209, 209, 209);
    }
}

- (void)addcontrains{
    
    [_registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backbtn);
        make.top.equalTo(_backbtn.mas_bottom).offset(25);
    }];
    [_inputTelLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_registerLabel);
        make.top.equalTo(_registerLabel.mas_bottom).offset(15);
    }];
    [_inputTelLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_inputTelLabel1);
        make.top.equalTo(_inputTelLabel1.mas_bottom).offset(5);
    }];
    [_telView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(_inputTelLabel2.mas_bottom).offset(25);
    }];
    [_areaNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(21.5);
        make.centerY.equalTo(_telView);
        make.width.mas_equalTo(35);
    }];
//    [_country mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(25);
//        make.centerY.equalTo(_telView);
//        make.width.mas_equalTo(35);
//    }];
    [_VerificationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(10);
        make.top.equalTo(_telView.mas_bottom).offset(10);
        make.width.mas_equalTo(230);
    }];
    [_verLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(21.5);
        make.centerY.equalTo(_VerificationView);
    }];
    [_passWView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(_VerificationView.mas_bottom).offset(10);
    }];
    [_passWLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_passWView);
        make.left.mas_equalTo(21.5);
        make.width.mas_equalTo(46);
    }];
    [_agreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_passWView);
        make.top.equalTo(_passWView.mas_bottom).offset(10);
    }];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(_agreementLabel.mas_bottom).offset(20);
    }];
}

/** 提交信息*/
- (void)submit{
    
    if(self.phoneTextField.text.length==0){
        [MyControl alertShow:@"请输入手机号"];
        return;
    }
    /** 只中国号码判断正则*/
    if ([_country.countryNum isEqualToString:@"+86"]) {
        if (![MyControl isPhoneNumber:self.phoneTextField.text]) {
            [MyControl alertShow:@"请输入正确的手机号码"];
            return;
        }
    }
    if(self.passTextField.text.length==0){
        [MyControl alertShow:@"请输入密码"];
        return;
    }
    if(self.vetifyCodeTextField.text.length==0){
        [MyControl alertShow:@"请输入验证码"];
        return;
    }
    
    if(self.passTextField.text.length<6||self.passTextField.text.length>18){
        [MyControl alertShow:@"请输入6-18位字母或数字"];
        return;
    }
    if(![MyControl checkPassword:self.passTextField.text ]){
        [MyControl alertShow:@"请输入6-18位字母或数字"];
        return;
    }
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"registerregister";
    paramDic[@"phone"] = self.phoneTextField.text;
    paramDic[@"pwd"] = self.passTextField.text;
    paramDic[@"code"] = self.vetifyCodeTextField.text;
    paramDic[@"registration_id"] = [MBBToolMethod getJPushRegistrationID];
    
    
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userRegister:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"注册成功,请登录" toView:self.view];
            [NSThread sleepForTimeInterval:0.5f];
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
            }];
        }
        if(request.responseJSONObject[@"other"]){
            [MBProgressHUD showError:request.responseJSONObject[@"other"]?request.responseJSONObject[@"other"]:@"注册失败" toView:self.view];
        }
    }];
    
}

#pragma mark - CountryChooseViewDelegate
- (void)makeChoiceCountry:(CountryChooseView *)countryCodeView{
    LSCountryTableController * country =[[LSCountryTableController alloc]init];
    country.countryBlock = ^(CountryNameModel *model) {
        _country.countryNum = [NSString stringWithFormat:@"+%@",model.code];
    };
    [self.navigationController pushViewController:country animated:YES];
}
#pragma mark - MBBFastLoginViewDelegate
- (void)fastLoginWith:(KLoginMethodType)method{
    [LSThirdShareLoginManager thirdAuthorizeLogin:(LSSDKPlatform)method];
}

/** 获取协议*/
- (void)getAgreement{
    
    MBBAboutUsController * AgreementVC = [[MBBAboutUsController alloc]init];
    AgreementVC.loadType = @"2";
    AgreementVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:AgreementVC animated:YES];
}

/** 获取验证码*/
- (void)getCodeButtonClicked:(UIButton*)button{
    
    if(self.phoneTextField.text.length==0)
    {
        [MyControl alertShow:@"请输入手机号"];
        
        return;
    }
    /** 只中国号码判断正则*/
    if ([_country.countryNum isEqualToString:@"+86"]) {
        if (![MyControl isPhoneNumber:self.phoneTextField.text]) {
            [MyControl alertShow:@"请输入正确的手机号码"];
            return;
        }
    }
    [MyControl countDownSeconds:^(NSString *resultStr) {
        button.enabled = NO;
        [_getCodeBtn setTitle:resultStr forState:UIControlStateNormal];
        if ([resultStr isEqualToString:@"重新获取验证码"]) {
            button.enabled = YES;
        }
    }];
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    
    NSString * str = @"abcdefghijkabcdefg";
    NSString * key = @"@#$%";
    NSString * signStr =[self withPhonerNum:_phoneTextField.text signStr:str keyStr:key];
    
    
    
    paramDic[@"phone"] = self.phoneTextField.text;
    paramDic[@"sign"] = signStr;
    
    /** 地区编码*/
    //    paramDic[@"areacode"] = [_country.countryNum substringFromIndex:1]?[_country.countryNum substringFromIndex:1]:@"";
    
    
    
    
    [MBProgressHUD showMessage:@"发送中...请稍后" toView:self.view];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    [manager GET:[NSString stringWithFormat:@"http://api.worldbuddy.cn/home/register/obtaincode?phone=%@&sign=%@",self.phoneTextField.text,signStr] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"msg"] integerValue] == 200) {
            [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
            
            
        }else {
            
            [MBProgressHUD showError:@"发送失败" toView:self.view];
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"failure--%@",error);
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
