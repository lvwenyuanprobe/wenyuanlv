//
//  MyControl.m
//  SnsDemo
//
//  Created by zhangcheng on 14-8-15.
//  Copyright (c) 2014年 lyt. All rights reserved.
//

#import "MyControl.h"

#import "MBBLoginContoller.h"

/** 相机相关*/
#import <AVFoundation/AVBase.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVCaptureDevice.h>

@implementation MyControl
+(UIButton*)createButtonFrame:(CGRect)frame Title:(NSString*)title BgImageName:(NSString*)bgImageName ImageName:(NSString*)imageName Method:(SEL)sel target:(id)target
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:MBBHEXCOLOR(0x00c7c8) forState:UIControlStateNormal];
    button.frame=frame;
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = MBBFONT(15);
        
    }
    if (bgImageName) {
        [button setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    //添加方法
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    //记住，这里无论手动还是自动都不需要释放！，因为button本身是使用类方法进行创建
    return button;
}
/** 倒计时*/
+ (void)countDownSeconds:(void (^)(NSString * resultStr))resultStr{
    __block int timeout = 60; // 倒计时时间60秒
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer =
    dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0),
                              1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if (timeout <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示
                
                resultStr(@"重新获取验证码");
                
            });
        } else {
            int seconds = timeout % 61;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示
                resultStr([NSString stringWithFormat:@"%.2ds后重发",seconds]);
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
/** 判断是否为电话号码*/
+ (BOOL)isPhoneNumber:(NSString *)phoneNumber {
    //手机号正则表达式
    NSString * phoneRegex = [NSString string];
    if (phoneNumber.length == 11) {
        phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    }else{
        return YES;
    }
    NSPredicate *phoneAuth = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL auth = [phoneAuth evaluateWithObject:phoneNumber];
    return auth;
}
/** 富文本改变字体颜色*/
+ (NSMutableAttributedString *)originalStr:(NSString *)originStr  position:(NSInteger)position color:(UIColor *)color{
    
    NSUInteger length = [originStr length];
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc]initWithString:originStr];
    if ([originStr length] > 0) {
        /** 调整颜色*/
        [attriStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, length-position)];
    }
    return attriStr;
}

/** 检查相机是否可用*/
+ (BOOL)checkCameraJurisdiction{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(AVAuthorizationStatusRestricted == authStatus ||
       AVAuthorizationStatusDenied == authStatus)
    {
        return NO;
    }
    return YES;
}

/** 计算日期天数*/
+(NSInteger)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate{
    
    if (!serverDate ||!endDate) {
        return -1;
    }else{
        NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [gregorian setFirstWeekday:2];
        //去掉时分秒信息
        NSDate *fromDate;
        NSDate *toDate;
        [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:serverDate];
        [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
        NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
        return dayComponents.day;
    }
}

/** 展示alert*/
+ (void)alertShow:(NSString *)alertMessage{
        [[[UIAlertView alloc] initWithTitle:@"提示"
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil, nil] show];
}

/** 正则匹配用户密码6-18位数字和字母组合*/
+ (BOOL)checkPassword:(NSString *) password{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

/** 判断是否登陆*/
+ (BOOL)MBBisLogionSuccess{
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    if (model.token) {
        return YES;
    }else{
        return NO;
    }
}
/** 判断当前页是否登陆*/
+ (void)CheckOutPresentVCLogin:(UIViewController *)presentVC isLoginToPush:(UIViewController *)pushVC{
    
    if ([self MBBisLogionSuccess]) {
        
        [presentVC.navigationController pushViewController:pushVC animated:YES];
        
    }else{
        MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
        [presentVC.navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                            animated:YES
                                                          completion:nil];
        return;
    }
}

/** 邮箱正则*/
+ (BOOL)validateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
/** 截图*/
+ (UIImage *)screenShotView:(UIView *)view{
    UIImage *imageRet = [[UIImage alloc]init];
    UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageRet;
}

/**
 *  裁剪图片
 注：若裁剪范围超出原图尺寸，则会用背景色填充缺失部位
 *
 *  @param image     原图
 *  @param Point     坐标
 *  @param Size      大小
 *  @param backColor 背景色
 *
 *  @return 新生成的图片
 */
+(UIImage *)cutImageWithImage:(UIImage *)image
                      atPoint:(CGPoint)Point
                     withSize:(CGSize)Size
              backgroundColor:(UIColor *)backColor
{
    UIGraphicsBeginImageContextWithOptions(Size, NO, 0.0);
    
    CGRect bounds = CGRectMake(0,
                               0,
                               Size.width,
                               Size.height);
    
    CGRect rect   = CGRectMake(-Point.x,
                               -Point.y,
                               image.size.width,
                               image.size.height);
    
    
    [backColor set];
    UIRectFill(bounds);
    
    [image drawInRect:rect];
    
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end









