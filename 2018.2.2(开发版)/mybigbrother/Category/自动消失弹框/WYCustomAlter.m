//
//  WYCustomAlter.m
//  mybigbrother
//
//  Created by Loren on 2018/1/18.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYCustomAlter.h"

@implementation WYCustomAlter

+ (void)showMessage:(NSString *)message {
    // 获取window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *showView = [[UIView alloc] init];
    showView.backgroundColor = [UIColor blackColor];
    showView.frame = CGRectMake(1, 1, 1, 1);
    showView.alpha = 0.5f;
    showView.layer.cornerRadius = 5.0f;
    showView.layer.masksToBounds = YES;
    [window addSubview:showView];
    
    UILabel *label = [[UILabel alloc] init];
    UIFont *font = [UIFont systemFontOfSize:15];
    CGRect labelRect = [message boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    label.frame = CGRectMake(10, 5, ceil(CGRectGetWidth(labelRect)), CGRectGetHeight(labelRect));
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [showView addSubview:label];
    showView.frame = CGRectMake((SCREEN_WIDTH - CGRectGetWidth(labelRect) - 20)/2, (SCREEN_HEIGHT - CGRectGetWidth(labelRect) - 20)/2, CGRectGetWidth(labelRect)+20, CGRectGetHeight(labelRect)+10);
    [UIView animateWithDuration:1.5 animations:^{
        showView.alpha = 0;
    } completion:^(BOOL finished) {
        [showView removeFromSuperview];
    }];
}



@end
