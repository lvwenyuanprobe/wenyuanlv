//
//  CustomServiceFooter.m
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "CustomServiceFooter.h"
#import "MBBCustomTextView.h"
@interface CustomServiceFooter ()
@property (nonatomic, strong) UILabel *   customLabel;
@property (nonatomic, strong) MBBCustomTextView *   serviceField;
@property (nonatomic, strong) MBBCustomTextView *   phoneField;
@property (nonatomic, strong) UIButton *   submitBtn;
@end

@implementation CustomServiceFooter

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    self.backgroundColor  = [UIColor whiteColor];
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self addSubview:line];
    
    line.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(1);
    
    
    UILabel * customLabel = [[UILabel alloc]init];
    customLabel.text = @"我要定制";
    customLabel.textColor = BASE_YELLOW;
    customLabel.font = MBBFONT(15);
    customLabel.textAlignment =  NSTextAlignmentCenter;
    [self addSubview:customLabel];
    
    MBBCustomTextView * serviceField = [[MBBCustomTextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 80, 100)
                                                                andPlaceholder:@"写下您要定制的信息,我们会全力为您提供贴心服务"
                                                           andPlaceholderColor:FONT_LIGHT];
    
    serviceField.backgroundColor = BASE_VC_COLOR;
    serviceField.clipsToBounds = YES;
    serviceField.layer.cornerRadius = 3;
    [self addSubview:serviceField];
    
    
    MBBCustomTextView * phoneField = [[MBBCustomTextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH -80, 35)
                                                              andPlaceholder:@"请您留下联系电话"
                                                         andPlaceholderColor:FONT_LIGHT];
    phoneField.backgroundColor = BASE_VC_COLOR;
    phoneField.clipsToBounds = YES;
    phoneField.layer.cornerRadius = 3;
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:phoneField];
    
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.titleLabel.textColor = [UIColor whiteColor];
    [submitBtn setBackgroundImage:[UIImage imageWithColor:BASE_YELLOW] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageWithColor:BASE_YELLOW] forState:UIControlStateSelected];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitInformation) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:submitBtn];

    
    
    _submitBtn = submitBtn;
    _customLabel = customLabel;
    _serviceField = serviceField;
    _phoneField = phoneField;
    [self setupViews];
    
    self.userInteractionEnabled = YES;
    _customLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(customTap)];
    UITapGestureRecognizer * dismissTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissTap)];
    [self addGestureRecognizer:dismissTap];
    [_customLabel addGestureRecognizer:tap];
    
    
}
- (void)dismissTap{
    if ([self.delegate respondsToSelector:@selector(dismissBottomView)]) {
        [self.delegate dismissBottomView];
    }

}
- (void)customTap{
    if ([self.delegate respondsToSelector:@selector(customTap)]) {
        [self.delegate customTap];
    }
}
- (void)submitInformation{

    [self CustomService];
}
- (void)setupViews{
    _customLabel.sd_layout
    .topSpaceToView(self,10)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(30);
    
    _serviceField.sd_layout
    .topSpaceToView(_customLabel,10)
    .leftSpaceToView(self,40)
    .widthIs(SCREEN_WIDTH - 80)
    .heightIs(100);
    
    _phoneField.sd_layout
    .topSpaceToView(_serviceField,10)
    .leftSpaceToView(self,40)
    .widthIs(SCREEN_WIDTH - 80)
    .heightIs(35);
    
    _submitBtn.sd_layout
    .topSpaceToView(_phoneField,10)
    .leftSpaceToView(self,100)
    .widthIs(SCREEN_WIDTH - 200)
    .heightIs(30);
    _submitBtn.clipsToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
}
- (void)CustomService{
    [self endEditing:YES];
    
    if (self.serviceField.text.length == 0) {
        [MyControl alertShow:@"请您输入内容"];return;
    }
    if (self.phoneField.text.length == 0) {
        [MyControl alertShow:@"请您输入手机号码"];return;
    }
    
    if (![MyControl isPhoneNumber:self.phoneField.text]) {
        [MyControl alertShow:@"请您输入正确的手机号码"];return;
    }

    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
//    paramDic[@"sign"] = @"<#registerverification#>";
     MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"u_id"] = @(model.user.uid);
    paramDic[@"con"] = self.serviceField.text;
    paramDic[@"tel"] = self.phoneField.text;
    [MBProgressHUD showMessage:@"请稍后..." toView:self];
    [MBBNetworkManager userCustomService:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"status"] integerValue] > 0) {
            [MBProgressHUD showSuccess:@"成功" toView:self];
            [self  dismissTap];
            
        }else{
            [MBProgressHUD showError:@"请你重新输入" toView:self];
        }
        
    }];

}
@end
