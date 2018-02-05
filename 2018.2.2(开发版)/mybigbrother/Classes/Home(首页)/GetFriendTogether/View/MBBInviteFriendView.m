//
//  MBBInviteFriendView.m
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBInviteFriendView.h"

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"


@interface MBBInviteFriendView ()
@property (nonatomic, strong) UIView * bottomView ;
@end

@implementation MBBInviteFriendView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    UIWindow *  win = [UIApplication sharedApplication].windows[0];
    self.frame =[UIScreen mainScreen].bounds;
    [win  addSubview:self];
    self.backgroundColor = [UIColor colorWithRed:67/255. green:67/255.  blue:67/255. alpha:0.5];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideInviteView)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64, SCREEN_WIDTH, 85)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    _bottomView = bottomView;
    
    [self sliderViewAnimation:CGRectMake(0, SCREEN_HEIGHT - 64 -85, SCREEN_WIDTH, 85)];

//    NSArray * images = @[@"share_weixin",@"share_qq",@"share_weibo"];
//    NSArray * titles = @[@"微信",@"QQ",@"微博"];

    NSMutableArray * images = [NSMutableArray array];
    NSMutableArray * titles = [NSMutableArray array];
    if ([WXApi isWXAppInstalled]) {
        [images addObject:@"fast_weixin"];
        [titles addObject:@"微信"];

    }
    
    if ([QQApiInterface isQQInstalled]) {
        [images addObject:@"fast_qq"];
        [titles addObject:@"QQ"];

    }
    
    if ([WeiboSDK isWeiboAppInstalled]) {
        [images addObject:@"share_weibo"];
        [titles addObject:@"微博"];
    }

    
    if (images.count == 0 ) {
        UILabel * nolabel = [[UILabel alloc]init];
        [_bottomView addSubview:nolabel];
        nolabel.frame = CGRectMake(0, 30, SCREEN_WIDTH,20);
        nolabel.text  = @"您暂时没有可供分享的平台";
        nolabel.textColor  = BASE_YELLOW;
        nolabel.font  = MBBFONT(15);
        nolabel.textAlignment = NSTextAlignmentCenter;
    }
    
    

    for (int i = 0 ; i < images.count; i ++) {
        
        CGFloat startW = 0;
        if (images.count == 1) {
            startW  = (SCREEN_WIDTH - 40 )/ 2;
        }
        if (images.count == 2) {
            startW  = (SCREEN_WIDTH - 40 * 2)/ 4;
        }
        if (images.count == 3) {
            startW  = (SCREEN_WIDTH - 40 * 3)/ 6;
        }
        
        UIButton * registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(startW + i * (40+(SCREEN_WIDTH - 40 * 3)/3),
                                                                            10,
                                                                            50,
                                                                            50)];
        [registerBtn setBackgroundImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [registerBtn setTitle:titles[i] forState:UIControlStateNormal];
        [registerBtn setTitleColor:FONT_DARK forState:UIControlStateNormal];
        registerBtn.titleLabel.font = MBBFONT(12);
       
        if ([images[i] isEqualToString:@"fast_weixin"]) {
            registerBtn.tag = KFriendWeixin;
        }
        if ([images[i] isEqualToString:@"fast_qq"]) {
            registerBtn.tag = KFriendQQ;
            
        }
        if ([images[i] isEqualToString:@"share_weibo"]) {
            registerBtn.tag = KFriendWeibo;
        }

        registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [registerBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -50,0, -50)];
        [registerBtn setTitleEdgeInsets:UIEdgeInsetsMake(70,0,0,0)];

        [registerBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:registerBtn];
    }
    
}

- (void)buttonClicked:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(immediatelyInviteFriends:)]) {
        [self.delegate immediatelyInviteFriends:button.tag];
    }
    [self hideInviteView];
}
-(void)showInviteView{
    [self.superview addSubview:self];
}
- (void)hasNoNavgationBarShowInviteView{
    
    _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT-85, SCREEN_WIDTH, 85);
    [self.superview addSubview:self];
}
-(void)hideInviteView{
    if ([self.delegate respondsToSelector:@selector(dismissInviteView)]) {
        [self.delegate dismissInviteView];
    }
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - 64, SCREEN_WIDTH, 85);
                     }
                     completion:^(BOOL finished){
                         if (finished == YES) {
                             [self removeFromSuperview];
                             
                         }
                     }];
}
/** 动画*/
- (void)sliderViewAnimation:(CGRect)rect{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _bottomView.frame = rect;
    [UIView commitAnimations];
}

@end
