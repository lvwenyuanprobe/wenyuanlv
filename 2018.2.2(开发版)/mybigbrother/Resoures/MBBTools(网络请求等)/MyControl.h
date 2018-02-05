//
//  MyControl.h
//  SnsDemo
//
//  Created by zhangcheng on 14-8-15.
//  Copyright (c) 2014年 lyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//#import <Foundation/Foundation.h>
@interface MyControl : NSObject
#pragma mark - 创建button
+(UIButton*)createButtonFrame:(CGRect)frame Title:(NSString*)title BgImageName:(NSString*)bgImageName ImageName:(NSString*)imageName Method:(SEL)sel target:(id)target;
/** 倒计时*/
+ (void)countDownSeconds:(void (^)(NSString * resultStr))resultStr;

/** 手机正则
 * @param phoneNumber 手机号码
 */
+ (BOOL)isPhoneNumber:(NSString *)phoneNumber;

/** 邮箱正则
 * @param email 邮箱
 */
+ (BOOL)validateEmail:(NSString *)email;


/** 富文本调整颜色(由前至后)
 *  @param originStr 源字符串
 *  @param position  改变颜色的位置
 *  @param color     要改变的颜色
 */
+ (NSMutableAttributedString *)originalStr:(NSString *)originStr  position:(NSInteger)position color:(UIColor *)color;


/** 检查相机使用权限*/
+ (BOOL)checkCameraJurisdiction;


/** 计算日期间隔天数
 * @param serverDate 起始
 * @param endDate    结束
 */
+(NSInteger)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate;


/** 展示信息alert*/
+ (void)alertShow:(NSString *)alertMessage;

/** 判断是否登陆*/
+ (BOOL)MBBisLogionSuccess;


/** 正则匹配用户密码6-18位数字和字母组合
 * @param password 密码
 */
+ (BOOL)checkPassword:(NSString *) password;

/** 判断当前页是否登陆 登陆并跳转下一页;  未登录时push可为nil)
 *  @param presentVC  当前视图控制器
 *  @param pushVC     push视图控制器

 */
+ (void)CheckOutPresentVCLogin:(UIViewController *)presentVC isLoginToPush:(UIViewController *)pushVC;

/** 截图
 *  @param view     被截视图图
 */
+ (UIImage *)screenShotView:(UIView *)view;
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
              backgroundColor:(UIColor *)backColor;

/** 生成图片*/
+ (UIImage *)createImageWithColor:(UIColor *)color;
@end
