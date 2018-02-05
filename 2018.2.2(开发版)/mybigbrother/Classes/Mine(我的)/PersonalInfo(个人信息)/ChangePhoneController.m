//
//  ChangePhoneController.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ChangePhoneController.h"
#import "SetPasswordInputTextView.h"
#import "CountryChooseView.h"
#import "LSCountryTableController.h"

typedef NS_ENUM (NSInteger, KAreaCodeType){
    KAreaCodeOriginal = 100,
    KAreaCodeNew,
};

@interface ChangePhoneController ()<CountryChooseViewDelegate>
@property (nonatomic, strong) SetPasswordInputTextView * originalPasswordView ;
@property (nonatomic, strong) SetPasswordInputTextView * freshPasswordView ;
@property (nonatomic, strong) SetPasswordInputTextView * makesurePasswordView ;
@property (nonatomic, strong) NSMutableDictionary * getSMSDic;

/** 原手机号地区编码*/
@property (nonatomic, strong) CountryChooseView * countryO;
/** 新手机号地区编码*/
@property (nonatomic, strong) CountryChooseView * countryN;

@end


@implementation ChangePhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改手机号";
    
    /** 提交*/
    UIButton * seeRuleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 17)];
    [seeRuleBtn setTitle:@"提交" forState:UIControlStateNormal];
    [seeRuleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [seeRuleBtn.titleLabel setFont:MBBFONT(15)];
    [seeRuleBtn addTarget:self action:@selector(commitNewPhoneNumer) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * selectBar = [[UIBarButtonItem alloc] initWithCustomView:seeRuleBtn];
    self.navigationItem.rightBarButtonItem = selectBar;
    
    
    
    SetPasswordInputTextView * originalPasswordView = [[SetPasswordInputTextView alloc]init];
    originalPasswordView.passwordText.placeholder = @"请输入手机号";
    SetPasswordInputTextView * newPasswordView = [[SetPasswordInputTextView alloc]init];
    newPasswordView.passwordText.placeholder = @"请输入验证码";
    SetPasswordInputTextView * makesurePasswordView = [[SetPasswordInputTextView alloc]init];
    makesurePasswordView.passwordText.placeholder = @"请输入新的手机号";
    
    
    /** 地理区号*/
    UIView * OCTBgView =[[UIView alloc]init];
    OCTBgView.backgroundColor = [UIColor whiteColor];
    CountryChooseView * Ocountry = [[CountryChooseView alloc]init];
    Ocountry.delegate = self;
    /** 设置默认*/
    Ocountry.countryNum = @"+86";
    Ocountry.tag = KAreaCodeOriginal;
    _countryO = Ocountry;
    
    /** 分割线*/
    UIView * Ocountryline = [[UIView alloc]init];
    Ocountryline.backgroundColor = BASE_CELL_LINE_COLOR;

    
    UIView * NCTBgView =[[UIView alloc]init];
    NCTBgView.backgroundColor = [UIColor whiteColor];
    CountryChooseView * Ncountry = [[CountryChooseView alloc]init];
    Ncountry.delegate = self;
    /** 设置默认*/
    Ncountry.countryNum = @"+86";
    Ncountry.tag = KAreaCodeNew;
    _countryN = Ncountry;

    /** 分割线*/
    UIView * Ncountryline = [[UIView alloc]init];
    Ncountryline.backgroundColor = BASE_CELL_LINE_COLOR;
    
    
    NSArray * arr = @[OCTBgView,
                      Ocountry,
                      Ocountryline,
                      
                      originalPasswordView,
                      newPasswordView,
                      
                      NCTBgView,
                      Ncountry,
                      Ncountryline,
                      
                      makesurePasswordView];
    
    _originalPasswordView = originalPasswordView;
    _freshPasswordView = newPasswordView;
    _makesurePasswordView = makesurePasswordView;
    
    [self.view sd_addSubviews:arr];
    
    
    OCTBgView.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(self, 0)
    .widthIs(70)
    .heightIs(44);
    
    Ocountry.sd_layout
    .leftSpaceToView(self.view, 10)
    .topSpaceToView(self, 10)
    .widthIs(50)
    .heightIs(20);
    Ocountryline.sd_layout
    .topSpaceToView(self.view, 10)
    .leftSpaceToView(Ocountry, 5)
    .widthIs(0.5)
    .heightIs(30);
    
    
    
    originalPasswordView.sd_layout
    .topSpaceToView(self.view ,0)
    .leftSpaceToView(Ocountryline,5)
    .widthIs(SCREEN_WIDTH - 70 )
    .heightIs(44);
    newPasswordView.sd_layout
    .topSpaceToView(originalPasswordView ,0)
    .leftSpaceToView(self.view,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(44);
    
    
    NCTBgView.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(self, 88)
    .widthIs(70)
    .heightIs(44);
    
    Ncountry.sd_layout
    .leftSpaceToView(self.view, 10)
    .topSpaceToView(self, 98)
    .widthIs(50)
    .heightIs(20);
    
    Ncountryline.sd_layout
    .topSpaceToView(self.view, 98)
    .leftSpaceToView(Ncountry, 5)
    .widthIs(0.5)
    .heightIs(30);

    
    
    
    
    makesurePasswordView.sd_layout
    .topSpaceToView(newPasswordView,0)
    .leftSpaceToView(self.view,70)
    .widthIs(SCREEN_WIDTH - 70)
    .heightIs(44);
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitleColor:FONT_DARK forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:MBBFONT(12)];
    [leftBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    [leftBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"mine_phone"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"mine_phone"] forState:UIControlStateSelected];
    [leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20,0, 0)];
    [newPasswordView addSubview:leftBtn];
    
    leftBtn.sd_layout
    .topSpaceToView(newPasswordView,0)
    .rightSpaceToView(newPasswordView,0)
    .widthIs(SCREEN_WIDTH/2)
    .heightIs(63);

}

#pragma mark - CountryChooseViewDelegate
- (void)makeChoiceCountry:(CountryChooseView *)countryCodeView{
    
    
    LSCountryTableController * country =[[LSCountryTableController alloc]init];
    /** 原手机地区编码*/
    if (countryCodeView.tag ==  KAreaCodeOriginal) {
        country.countryBlock = ^(CountryNameModel * model) {
            _countryO.countryNum = [NSString stringWithFormat:@"+%@",model.code];
        };
    }
    /** 新手机地区编码*/
    if (countryCodeView.tag ==  KAreaCodeNew) {
        country.countryBlock = ^(CountryNameModel * model) {
            _countryN.countryNum = [NSString stringWithFormat:@"+%@",model.code];
        };
    }
    [self.navigationController pushViewController:country animated:YES];
}


- (void)commitNewPhoneNumer{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"registermobile";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"token"] = model.token;
    paramDic[@"code"] = _freshPasswordView.passwordText.text;
    paramDic[@"phone"]=_makesurePasswordView.passwordText.text;
    paramDic[@"u_phone"] = self.originalPasswordView.passwordText.text;
    paramDic[@"areacode"]=[_countryN.countryNum substringFromIndex:1]?[_countryN.countryNum substringFromIndex:1]:@"";
    paramDic[@"u_areacode"]=[_countryO.countryNum substringFromIndex:1]?[_countryO.countryNum substringFromIndex:1]:@"";
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager changePhoneNumber:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"更改成功" toView:self.view];
            sleep(1);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showSuccess:@"修改失败了哦~" toView:self.view];
        }
    }];
}

- (void)leftBtnClicked:(UIButton * )button{
    [self.view endEditing:YES];
    if (_originalPasswordView.passwordText.text.length != 0) {
        
        /** 中国号码判断*/
        if([_countryO.countryNum isEqualToString:@"+86"]){
            BOOL isPhone = [MyControl isPhoneNumber:_originalPasswordView.passwordText.text];
            if (isPhone) {
                button.enabled = NO;
                [MyControl countDownSeconds:^(NSString *resultStr) {
                    [button setTitle:resultStr forState:UIControlStateNormal];
                    if ([resultStr isEqualToString:@"重新获取验证码"]) {
                        button.enabled = YES;
                    }
                }];
            }else{
                [MyControl alertShow:@"请输入正确的手机号码"];
                return;
            }
        }
    }else{
        [MyControl alertShow:@"请输入手机号码"];
        return;
    }
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"registerverification";
    paramDic[@"phone"] = self.originalPasswordView.passwordText.text;
    paramDic[@"areacode"]=[_countryO.countryNum substringFromIndex:1]?[_countryO.countryNum substringFromIndex:1]:@"";
    [MBProgressHUD showMessage:@"发送中...请稍后" toView:self.view];
    [MBBNetworkManager userRegisterPhoneMessage:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
           
            [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
            
        }else{
            [MBProgressHUD showError:@"发送失败" toView:self.view];
        }
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
