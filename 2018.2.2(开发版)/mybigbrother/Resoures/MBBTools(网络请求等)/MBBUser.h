//
//  MBBUser.h
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBBUser : NSObject

#pragma mark - **************************************此文件.h,.m中映射关系需同时修改********************************
/** 真实姓名*/
@property (nonatomic, strong) NSString * name;
/** 昵称*/
@property (nonatomic, strong) NSString * nickName;
/** 性别*/
@property (nonatomic, assign) NSInteger sex;
/** 年龄*/
@property (nonatomic, assign) NSInteger age;
/** 学校*/
@property (nonatomic, strong) NSString * school;
/** 年级*/
@property (nonatomic, strong) NSString * grade;
/** 手机*/
@property (nonatomic, strong) NSString * phoneNum;

/** 紧急联系人*/
@property (nonatomic, strong) NSString * urgent;

/** 头像*/
@property (nonatomic, strong) NSString * icon;
/** id*/
@property (nonatomic, assign) NSInteger  uid;
/** 1.学生,2.家长,3.司机*/
@property (nonatomic, assign) NSInteger  type;

/** 个性签名*/
@property (nonatomic, strong) NSString * autograph;

/** 密码*/
@property (nonatomic, strong) NSString * pdw;

/** 护照号*/
@property (nonatomic, strong) NSString * passportNum;

/** 生日*/
@property (nonatomic, strong) NSString * birthday;

/** 账号创建时间*/
@property (nonatomic, strong) NSString * addtime ;

/** 在读专业*/
@property (nonatomic, strong) NSString * major;

#pragma mark - 司机
/** 驾驶证*/
@property (nonatomic, strong) NSString * driverCard;
/** 出租车型号*/
@property (nonatomic, strong) NSString * driverModel;
/** 车牌号*/
@property (nonatomic, strong) NSString * driverNumber;


/** 转模型*/
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

/** 转字典*/
-(NSDictionary *)toDictionary;


/** 本地字典  转模型*/
-(instancetype)initWithLocalDictionary:(NSDictionary *)dictionary;

@end
