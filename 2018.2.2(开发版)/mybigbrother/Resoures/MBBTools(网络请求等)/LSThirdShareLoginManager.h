//
//  LSThirdShareLoginManager.h
//  mybigbrother
//
//  Created by SN on 2017/4/28.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, LSSDKPlatform){
    LSSDKPlatformSubTypeWeixin = 100,
    LSSDKPlatformSubTypeQQ,
    LSSDKPlatformSubTypeWeibo
};

@interface LSThirdShareLoginManager : NSObject

/**
 *  设置分享参数
 *
 *  @param text     文本
 *  @param images   图片集合,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage。如: @"http://www.mob.com/images/logo_black.png" 或 @[@"http://www.mob.com/images/logo_black.png"]
 *  @param url      网页路径/应用路径
 *  @param title    标题
 *  @param type     分享类型
 */
- (void)SSDKSetupShareParamsByText:(NSString *)text
                            images:(id)images
                               url:(NSURL *)url
                             title:(NSString *)title
                              type:(LSSDKPlatform)type;

/**
 *  设置分享参数
 *
 *  @param SDKType     文本
 *  @param imageArray   图片集合,传入参数可以为单张图片信息，也可以为一个NSArray
 *  @param urlStr   网页路径/应用路径
 *  @param title    标题
 *  @param text     分享内容(微博的链接放在内容中)
 */
+ (void)shareInfomationToFriends:(LSSDKPlatform )SDKType
                          images:(NSArray *)imageArray
                          urlStr:(NSString *)urlStr
                           title:(NSString *)title
                            text:(NSString *)text;

/** 第三方授权登陆*/
+ (void)thirdAuthorizeLogin:(LSSDKPlatform)SDKType;

@end
