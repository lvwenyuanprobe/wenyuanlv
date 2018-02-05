//
//  XTVersion.h
//  XiaoTu
//
//  Created by 何振东 on 15/7/7.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  版本管理类
 */
@interface TWVersionChecker : NSObject

/**
 *  检查appstore是否有新版本
 *
 *  @param appId             要查检的appid
 *  @param completionHandler 检查返回的代理
 */
+ (void)checkVersionForAppId:(NSString *)appId completionHandler:(void (^)(BOOL hasNew, NSString *updateText, NSString *updateUrl, NSString *version))completionHandler;


@end
