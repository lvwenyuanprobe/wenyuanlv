//
//  MBBToolMethod.m
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBToolMethod.h"


static MBBToolMethod * manager;

@implementation MBBToolMethod


/** 单例*/
+ (MBBToolMethod *)shareManager{
    
    static dispatch_once_t onewToken;
    dispatch_once(&onewToken, ^{
        manager = [[MBBToolMethod alloc] init];
    });
    return manager;
}

/** 信息存储*/
- (MBBUser *)loginUser {
    NSUserDefaults * df = [NSUserDefaults standardUserDefaults];
    NSDictionary * dic = [df valueForKey:@"mbb_user_info"];
    MBBUserInfoModel *model = [[MBBUserInfoModel alloc] initWithDictionary:dic];
    MBBUser * loginUser = model.user;
    return loginUser;
}
/** 退出登录*/
+ (void)cleanUserInfoLogOut{
    NSUserDefaults * df = [NSUserDefaults standardUserDefaults];
    [df removeObjectForKey:@"mbb_user_info"];
    [df synchronize];
}
/** 获取用户信息*/
+ (MBBUserInfoModel *)fetchUserInfo{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [df valueForKey:@"mbb_user_info"];
    MBBUserInfoModel *model = [[MBBUserInfoModel alloc] initWithLocalDictionary:dic];
    return model;
}
/** 存储token*/
+ (void)putDeviceToken:(NSString *)deviceToken{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    [df setObject:deviceToken forKey:@"mbb_deviceToken"];
    [df synchronize];
}
/** 更新用户信息*/
+ (void)setUserInfo:(NSDictionary *)newUserInfo{
   
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    [df setObject:newUserInfo forKey:@"mbb_user_info"];
    [df synchronize];

}

/** 存储JPush的registrationID*/
+ (void)putJPushRegistrationID:(NSString *)registrationID{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    [df setObject:registrationID forKey:@"mbb_registrationID"];
    [df synchronize];
}
/** 获取JPush的registrationID*/
+ (NSString *)getJPushRegistrationID{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * str =  [df objectForKey:@"mbb_registrationID"]?[df objectForKey:@"mbb_registrationID"]:@"";
    return str;
}
@end
