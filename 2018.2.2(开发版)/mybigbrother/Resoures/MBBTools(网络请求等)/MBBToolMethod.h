//
//  MBBToolMethod.h
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBBUser.h"
#import "MBBUserInfoModel.h"

@interface MBBToolMethod : NSObject
/** 单例*/
+ (MBBToolMethod *)shareManager;

/** 数据存储*/
- (MBBUser *)loginUser;

/**
 *  获取用户信息
 *
 *  @return 用户信息
 */
+ (MBBUserInfoModel *)fetchUserInfo;
/**
 *  存储token
 */
+ (void)putDeviceToken:(NSString *)deviceToken;

/**
 *  更新用户信息
 *
 *  @param newUserInfo 更新后的用户信息
 */
+ (void)setUserInfo:(NSDictionary *)newUserInfo;

/** 退出登录*/
+ (void)cleanUserInfoLogOut;

/** 存储JPush的registrationID*/
+ (void)putJPushRegistrationID:(NSString *)registrationID;


/** 获取JPush的registrationID*/
+ (NSString *)getJPushRegistrationID;
@end
