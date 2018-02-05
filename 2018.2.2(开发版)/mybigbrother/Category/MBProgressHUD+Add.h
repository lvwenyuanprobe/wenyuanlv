//
//  MBProgressHUD+Add.h
//  mybigbrother
//
//  Created by SN on 2017/4/12.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Add)

/** 展示错误信息*/
+ (void)showError:(NSString *)error toView:(UIView *)view;
/** 展示成功信息*/
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

/** 展示信息*/
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

@end
