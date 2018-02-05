//
//  MBBFastLoginView.m
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBFastLoginView.h"


//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"

@interface MBBFastLoginView ()

@end

@implementation MBBFastLoginView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    /** 快捷登陆*/
    UIView * leftline = [[UIView alloc]init];
    leftline.backgroundColor = RGB(102, 102, 102);
    
    UILabel * title = [[UILabel alloc]init];
    title.text = @"使用社交软件一键登录";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = MBBFONT(12);
    title.textColor = RGB(102, 102, 102);
    
    UIView * rightline = [[UIView alloc]init];
    rightline.backgroundColor = RGB(102, 102, 102);
    
    NSArray * subViews = @[leftline,title,rightline];
    [self sd_addSubviews:subViews];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.mas_equalTo(-91);
    }];
    [leftline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.equalTo(title.mas_left).offset(-10);
        make.centerY.equalTo(title);
        make.height.mas_equalTo(0.5);
    }];
    [rightline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25);
        make.left.equalTo(title.mas_right).offset(10);
        make.centerY.equalTo(title);
        make.height.mas_equalTo(0.5);
    }];
    
    NSMutableArray * images = [NSMutableArray array];
    
    if ([WXApi isWXAppInstalled]) {
        [images addObject:@"fast_weixin"];
    }

    if ([QQApiInterface isQQInstalled]) {
        [images addObject:@"fast_qq"];
    }
    
    if ([WeiboSDK isWeiboAppInstalled]) {
        [images addObject:@"share_weibo"];
    }

    
    for (int i = 0 ; i < images.count; i ++) {
        
        CGFloat startW = 0;
        if (images.count == 1) {
            startW  = (SCREEN_WIDTH - 46 )/ 2;
        }
        if (images.count == 2) {
            startW  = (SCREEN_WIDTH - 46 * 2 - 65)/ 2;
        }
        if (images.count == 3) {
            startW  = (SCREEN_WIDTH - 46 * 3 - 20)/ 2;
        }
        
        UIButton * registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(startW + i * (46+50) - 35,
                                                                            [title bottom] + 75,
                                                                            46,
                                                                            46)];
        [registerBtn setBackgroundImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [registerBtn addTarget:self action:@selector(fastLoginClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([images[i] isEqualToString:@"fast_weixin"]) {
            registerBtn.tag = KLoginMethodWeixin;
        }
        if ([images[i] isEqualToString:@"fast_qq"]) {
            registerBtn.tag = KLoginMethodQQ;

        }
        if ([images[i] isEqualToString:@"share_weibo"]) {
            registerBtn.tag = KLoginMethodWeibo;
        }
        
        [self addSubview:registerBtn];
    }
    
}

- (void)fastLoginClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(fastLoginWith:)]) {
        [self.delegate fastLoginWith:button.tag];
    }

}
@end
