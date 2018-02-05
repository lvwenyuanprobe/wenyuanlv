//
//  MBBRegisterController.h
//  mybigbrother
//
//  Created by apple on 2017/12/18.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBBaseUIViewController.h"

@interface MBBRegisterController : MBBBaseUIViewController
/** 顶部视图*/
@property (nonatomic, weak)UIImageView *  iconImageView;
/** 密码图片*/
@property (nonatomic, weak)UIImageView *  passwordImage;
/** 手机图片*/
@property (nonatomic, weak)UIImageView *  phoneImageView;
/** */
@property (nonatomic, weak)UIView *       passwordView;
@property (nonatomic, weak)UIView *       inputBoardView;

/** 手机输入框*/
@property (nonatomic, strong)UITextField* phoneTextField;
/** 验证码输入框*/
@property (nonatomic, strong)UITextField* vetifyCodeTextField;
/** 注册按钮*/
@property (nonatomic, strong)UIButton *   registerButton;
/** 获取验证码按钮*/
@property (nonatomic, strong)UIButton *   getCodeButtton;
/** 协议按钮*/
@property (nonatomic, strong)UIButton *   agreementButtton;

@end
