//
//  DriverWalletController.m
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "DriverWalletController.h"
#import "MBBDriverCrashExplainController.h"
#import "DriverGetCashInfoView.h"
#import "DriverAccountListController.h"
#import "InputTextView.h"
#import "DriverGetCashMethodChooseController.h"
#import "GetCashCellView.h"
#import "MBBAboutUsController.h"

@interface DriverWalletController ()<DriverGetCashInfoViewDelegate,InputTextViewDelegate>

@property (nonatomic, strong) InputTextView * inputView ;

@property (nonatomic, assign) KInfoType informationType;

@property (nonatomic, strong) NSMutableDictionary * informationDic;

@property (nonatomic, strong) DriverGetCashInfoView * informationView ;

@property (nonatomic, strong) UILabel * money;

@end

@implementation DriverWalletController

#pragma mark - 重写loadView() 重置self.view 解决IQkeyBoard导航栏漂移
-(void)loadView{
    UIScrollView * scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scr.backgroundColor = [UIColor whiteColor];
    self.view = scr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的钱包";
    self.view.backgroundColor = BASE_VC_COLOR;
    [self fetchMyWalletAccountMoney];
    
    /** 键盘回收通知*/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];

    /** 账单*/
    UIButton * seeRuleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
    [seeRuleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [seeRuleBtn setBackgroundImage:[UIImage  imageNamed:@"wallet_account"] forState:UIControlStateNormal];
    [seeRuleBtn addTarget:self action:@selector(fetchAccountList) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * selectBar = [[UIBarButtonItem alloc] initWithCustomView:seeRuleBtn];
    self.navigationItem.rightBarButtonItem = selectBar;
    
    
    UIImageView * topImage = [[UIImageView alloc]init];
    [self.view addSubview:topImage];
    topImage.image = [UIImage imageWithColor:BASE_COLOR];
    topImage.sd_layout
    .topSpaceToView(self.view,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(130)
    .leftSpaceToView(self.view,0);
    
    
    UILabel * count = [[UILabel alloc]init];
    count.text = @"$0.00";
    count.font = MBBFONT(25);
    count.textColor = BUTTON_COLOR;
    count.textAlignment = NSTextAlignmentCenter;
    _money = count;
    
    UILabel * title = [[UILabel alloc]init];
    title.text = @"当前余额";
    title.font = MBBFONT(15);
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    
    [topImage addSubview:count];
    [topImage addSubview:title];

    count.sd_layout
    .topSpaceToView(topImage,20)
    .leftSpaceToView(topImage,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(30);
    
    title.sd_layout
    .topSpaceToView(count,10)
    .leftSpaceToView(topImage,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(30);
    
    /** 提现金额*/
    GetCashCellView * putCash = [[GetCashCellView alloc]init];
    putCash.leftLabel.text = @"提现金额";
    putCash.rightLabel.text = @"请输入";
    putCash.rightLabel.textColor = [UIColor redColor];
    [self.view addSubview:putCash];
    putCash.tag = KInfoMoney;
    putCash.sd_layout
    .topSpaceToView(topImage,0)
    .leftSpaceToView(self.view,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(45);
    [putCash addTarget:self action:@selector(inputCashNumber) forControlEvents:UIControlEventTouchUpInside];
    
    /** */
    UILabel * manInfo = [[UILabel alloc]init];
    manInfo.text = @"取款人信息";
    manInfo.font = MBBFONT(15);
    [self.view addSubview:manInfo];
    manInfo.sd_layout
    .topSpaceToView(putCash,10)
    .leftSpaceToView(self.view,10)
    .widthIs(SCREEN_WIDTH)
    .heightIs(20);
    
    /** 下面*/
    DriverGetCashInfoView * informationView = [[DriverGetCashInfoView alloc]init ];
    informationView.delegate = self;
    _informationView = informationView;
    
    [self.view addSubview:informationView];
    
    informationView.sd_layout
    .topSpaceToView(manInfo,10)
    .leftSpaceToView(self.view,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(145);
    
    /** 确认提现*/
    UIButton * getCrash = [[UIButton alloc] init];
    [getCrash setTitle:@"确认提现" forState:UIControlStateNormal];
    [getCrash setBackgroundImage:[UIImage imageWithColor:BUTTON_COLOR] forState:UIControlStateNormal];
    [getCrash addTarget:self action:@selector(makesureGetCrash) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getCrash];
    
    getCrash.sd_layout
    .topSpaceToView(informationView,30)
    .leftSpaceToView(self.view , 20)
    .widthIs(SCREEN_WIDTH - 40)
    .heightIs(44);
    getCrash.sd_cornerRadius = @(5);
    
    /** */
    UILabel * explain = [[UILabel alloc]init];
    explain.text = @"提现说明";
    explain.font = MBBFONT(12);
    explain.textColor= BUTTON_COLOR;
    explain.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:explain];
    
    explain.sd_layout
    .topSpaceToView(getCrash,10)
    .leftSpaceToView(self.view,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(30);
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(explainDetial)];
    explain.userInteractionEnabled = YES;
    [explain addGestureRecognizer:tap];
    
    InputTextView * inputView = [[InputTextView alloc]initWithFrame:CGRectMake(0,
                                                                               SCREEN_HEIGHT-64-55,
                                                                               SCREEN_WIDTH,
                                                                               55)];
    inputView.delegate = self;
    _inputView = inputView;
    _inputView.hidden = YES;
    [self.view addSubview:inputView];

    
    self.informationType =  KInfoName ;
    self.informationDic  = [NSMutableDictionary dictionary];
    
    
    
    // Do any additional setup after loading the view.
}
- (void)inputCashNumber{
    /** 调用代理*/
    [self completeInfo:KInfoMoney];
}
/** 账单*/
- (void)fetchAccountList{
    DriverAccountListController * accountList = [[DriverAccountListController alloc]init];
    [self.navigationController pushViewController:accountList animated:YES];
}

#pragma mark - 提交提现申请
- (void)makesureGetCrash{
    
    if (!self.informationDic[@"name"]) {
        [MyControl alertShow:@"请输入姓名"];
        return;
    }
    if (!self.informationDic[@"type"]) {
        [MyControl alertShow:@"请选择提现方式"];
        return;

    }
    if (!self.informationDic[@"money"]) {
        [MyControl alertShow:@"请输入提现金额"];
        return;

    }
    if (!self.informationDic[@"account"]) {
        [MyControl alertShow:@"请输入账号"];
        return;

    }
    if (![MyControl isPhoneNumber:self.informationDic[@"account"]]) {
        [MyControl alertShow:@"请确认账号输入正确"];
        return;

    }
    
    /** 弹出密码输入*/
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请输入密码"
                                                                    message:nil
                                                             preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          UITextField * password = alert.textFields.firstObject;
                                                          if (password.text.length != 0) {
                                                              
                                                              [self.informationDic setObject:password.text forKey:@"pwd"];
                                                              
                                                              /** 提现*/
                                                              [self FetchCashNetwork];
                                                          }
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入密码";
        textField.secureTextEntry = YES;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)alertTextFieldDidChange:(UITextField *)textField{
    
    
}
/** 申请提现*/
- (void)FetchCashNetwork{
    
    self.informationDic[@"sign"] = @"driverwithdrawals";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    self.informationDic[@"token"] = model.token;
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userDriverGetcash:self.informationDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            [MBProgressHUD showSuccess:@"申请成功" toView:self.view];
            
            /** 跳转*/
            [self fetchAccountList];
        }else{
           
            [MBProgressHUD showError:@"申请失败" toView:self.view];
        }
        
    }];

}
#pragma mark - 获取钱包金额
- (void)fetchMyWalletAccountMoney{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"driverbalance";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"token"] = model.token;
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userDriverWalletInfo:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            _money.text =[NSString stringWithFormat:@"$ %@",request.responseJSONObject[@"data"][@"d_balance"]];
        
        }else{
            _money.text = @"网络问题请稍后...";
        }
    }];
}
#pragma mark - DriverGetCashInfoViewDelegate

- (void)completeInfo:(KInfoType)infoType{
    _inputView.textView.text = nil;
    if(KInfoName == infoType){
        _inputView.hidden = NO;
        _inputView.textView.keyboardType = UIKeyboardTypeDefault;
        [_inputView.textView becomeFirstResponder];
        self.informationType = KInfoName;
        
    }
    if(KInfoMethod == infoType){
       /** 跳转选择*/
        DriverGetCashMethodChooseController * chooseMethod = [[DriverGetCashMethodChooseController alloc]init];
        chooseMethod.chooseMethodBlock = ^(KGetCashMethodType method) {
            for ( GetCashCellView * methodView in _informationView.subviews) {
                if (methodView.tag == KInfoMethod) {
                    if (method == KGetCashAlipay) {
                        methodView.rightLabel.text = @"支付宝";
                    }
                    if (method == KGetCashWeixin) {
                        methodView.rightLabel.text = @"微信";
                    }
                    /** 临时*/
                    [self.informationDic setObject:@"1" forKey:@"type"];
                }
            }
        };
        [self.navigationController pushViewController:chooseMethod animated:YES];
    }
    if(KInfoAccount == infoType){
        _inputView.hidden = NO;
        _inputView.textView.keyboardType = UIKeyboardTypePhonePad;
        [_inputView.textView becomeFirstResponder];
        self.informationType = KInfoAccount;
    }
    /** 本控制器调用*/
    if(KInfoMoney == infoType){
        _inputView.hidden = NO;
        _inputView.textView.keyboardType = UIKeyboardTypeDecimalPad;
        [_inputView.textView becomeFirstResponder];
        self.informationType = KInfoMoney;
    }
}

#pragma mark - InputTextViewDelegate
- (void)makeSureInputContentText:(NSString *)content{
    
    /** 组装数据*/
    if(self.informationType == KInfoName){
        for ( GetCashCellView * methodView in _informationView.subviews) {
            if (methodView.tag == KInfoName) {
                methodView.rightLabel.text = content;
            }
        }
        
        [self.informationDic setObject:content forKey:@"name"];
        
    }
    if(self.informationType == KInfoAccount){
        for ( GetCashCellView * methodView in _informationView.subviews) {
            if (methodView.tag == KInfoAccount) {
                methodView.rightLabel.text = content;
            }
        }
        [self.informationDic setObject:content forKey:@"account"];

    }
    if(self.informationType == KInfoMoney){
        for ( GetCashCellView * methodView in self.view.subviews) {
            if (methodView.tag == KInfoMoney) {
                methodView.rightLabel.text =[NSString stringWithFormat:@"$%@",content];
            }
        }
        [self.informationDic setObject:content forKey:@"money"];
    }
    
}
- (void)explainDetial{
    /** 提现说明*/
    MBBAboutUsController * aboutUsVC = [[MBBAboutUsController alloc]init];
    aboutUsVC.loadType = @"3";
    aboutUsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aboutUsVC animated:YES];
}
#pragma mark - 键盘回收处理
- (void)keyboardWillBeHidden:(NSNotification*)notification{
    _inputView.hidden = YES;
}

/** 注销通知*/
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
