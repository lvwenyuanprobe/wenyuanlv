//
//  MBBUser.m
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import "MBBUser.h"

@implementation MBBUser

+(void)initialize
{
    [self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"uid":@"id"
                 };
    }];
}
/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */
#pragma mark - 网络数据获取 字典转模型

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[@"u_img"] isKindOfClass:[NSNull class]]){
        self.icon = dictionary[@"u_img"];
    }
    if(![dictionary[@"u_name"] isKindOfClass:[NSNull class]]){
        self.name = dictionary[@"u_name"];
    }
    if(![dictionary[@"u_nickname"] isKindOfClass:[NSNull class]]){
        self.nickName = dictionary[@"u_nickname"];
    }
    if(![dictionary[@"u_sex"] isKindOfClass:[NSNull class]]){
        
        self.sex = [dictionary[@"u_sex"] integerValue];
    }
    if(![dictionary[@"u_age"] isKindOfClass:[NSNull class]]){
        self.age = [dictionary[@"u_age"] integerValue];
    }
    if(![dictionary[@"u_birthday"] isKindOfClass:[NSNull class]]){
        self.birthday = dictionary[@"u_birthday"];
    }
    
    if(![dictionary[@"u_phone"] isKindOfClass:[NSNull class]]){
        self.phoneNum = dictionary[@"u_phone"];
    }
    if(![dictionary[@"u_urgent"] isKindOfClass:[NSNull class]]){
        self.urgent = dictionary[@"u_urgent"];
    }

    if(![dictionary[@"u_autograph"] isKindOfClass:[NSNull class]]){
        self.autograph = dictionary[@"u_autograph"];
    }
    
    if(![dictionary[@"u_id"] isKindOfClass:[NSNull class]]){
        self.uid = [dictionary[@"u_id"] integerValue];
    }
    if(![dictionary[@"u_type"] isKindOfClass:[NSNull class]]){
        self.type = [dictionary[@"u_type"] integerValue];
    }
    
    if(![dictionary[@"u_pdw"] isKindOfClass:[NSNull class]]){
        self.pdw = dictionary[@"u_pdw"];
    }
    if(![dictionary[@"x_major"] isKindOfClass:[NSNull class]]){
        self.major = dictionary[@"x_major"];
    }
    
    if(![dictionary[@"x_passport"] isKindOfClass:[NSNull class]]){
        self.passportNum = dictionary[@"x_passport"];
    }
    if(![dictionary[@"x_school"] isKindOfClass:[NSNull class]]){
        self.school = dictionary[@"x_school"];
    }
    if(![dictionary[@"x_grade"] isKindOfClass:[NSNull class]]){
        self.grade = dictionary[@"x_grade"];
    }
    if(![dictionary[@"u_addtime"] isKindOfClass:[NSNull class]]){
        self.addtime = dictionary[@"u_addtime"];
    }
    
    /** 司机特有*/
    if(![dictionary[@"d_card"] isKindOfClass:[NSNull class]]){
        self.driverCard = dictionary[@"d_card"];
    }
    if(![dictionary[@"d_number"] isKindOfClass:[NSNull class]]){
        self.driverNumber = dictionary[@"d_number"];
    }
    if(![dictionary[@"d_model"] isKindOfClass:[NSNull class]]){
        self.driverModel = dictionary[@"d_model"];
    }


    return self;
}
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
#pragma mark - 模型转本地 - 存储字典

-(NSDictionary *)toDictionary{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    
    if(self.addtime != nil){
        dictionary[@"addtime"] = self.addtime;
    }
    if(self.name != nil){
        dictionary[@"name"] = self.name;
    }
    if(self.nickName != nil){
        dictionary[@"nickName"] = self.nickName;
    }
    
    dictionary[@"sex"] = @(self.sex);
    dictionary[@"age"] = @(self.age);
    
    if(self.autograph != nil){
        dictionary[@"autograph"] = self.autograph;
    }
    if(self.birthday != nil){
        dictionary[@"addtime"] = self.birthday;
    }
    if(self.icon != nil){
        dictionary[@"icon"] = self.icon;
    }
    /** 特殊*/
    if (self.type == 0) {
        dictionary[@"type"] = @(1);
    }else{
        dictionary[@"type"] = @(self.type);
    }

    if(self.school != nil){
        dictionary[@"school"] = self.school;
    }
    if(self.pdw != nil){
        dictionary[@"pdw"] = self.pdw;
    }
    if(self.major != nil){
        dictionary[@"major"] = self.major;
    }
    if(self.phoneNum != nil){
        dictionary[@"phoneNum"] = self.phoneNum;
    }
    if(self.urgent != nil){
        dictionary[@"urgent"] = self.urgent;
    }

    dictionary[@"uid"] = @(self.uid);
    
    dictionary[@"type"] = @(self.type);
    
    if(self.passportNum != nil){
        dictionary[@"passportNum"] = self.passportNum;
    }

    if(self.grade != nil){
        dictionary[@"grade"] = self.grade;
    }
    
    /** 司机特有*/
    if(self.driverNumber != nil){
        dictionary[@"driverNumber"] = self.driverNumber;
    }

    if(self.driverModel != nil){
        dictionary[@"driverModel"] = self.driverModel;
    }

    if(self.driverCard != nil){
        dictionary[@"driverCard"] = self.driverCard;
    }


    return dictionary;

}
#pragma mark - 本地字典 -  字典转模型

-(instancetype)initWithLocalDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[@"icon"] isKindOfClass:[NSNull class]]){
        self.icon = dictionary[@"icon"];
    }
    if(![dictionary[@"name"] isKindOfClass:[NSNull class]]){
        self.name = dictionary[@"name"];
    }
    if(![dictionary[@"nickName"] isKindOfClass:[NSNull class]]){
        self.nickName = dictionary[@"nickName"];
    }
    if(![dictionary[@"sex"] isKindOfClass:[NSNull class]]){
        self.sex = [dictionary[@"sex"] integerValue];
    }
    if(![dictionary[@"age"] isKindOfClass:[NSNull class]]){
        self.age = [dictionary[@"age"] integerValue];
    }
    if(![dictionary[@"birthday"] isKindOfClass:[NSNull class]]){
        self.birthday = dictionary[@"birthday"];
    }
    
    if(![dictionary[@"phoneNum"] isKindOfClass:[NSNull class]]){
        self.phoneNum = dictionary[@"phoneNum"];
    }
    if(![dictionary[@"autograph"] isKindOfClass:[NSNull class]]){
        self.autograph = dictionary[@"autograph"];
    }
    
    if(![dictionary[@"uid"] isKindOfClass:[NSNull class]]){
        self.uid = [dictionary[@"uid"] integerValue];
    }
    if(![dictionary[@"type"] isKindOfClass:[NSNull class]]){
        self.type = [dictionary[@"type"] integerValue];
    }
    
    if(![dictionary[@"pdw"] isKindOfClass:[NSNull class]]){
        self.pdw = dictionary[@"pdw"];
    }
    if(![dictionary[@"major"] isKindOfClass:[NSNull class]]){
        self.major = dictionary[@"major"];
    }
    
    if(![dictionary[@"passportNum"] isKindOfClass:[NSNull class]]){
        self.passportNum = dictionary[@"passportNum"];
    }
    
    if(![dictionary[@"urgent"] isKindOfClass:[NSNull class]]){
        self.urgent = dictionary[@"urgent"];
    }

    if(![dictionary[@"school"] isKindOfClass:[NSNull class]]){
        self.school = dictionary[@"school"];
    }
    if(![dictionary[@"grade"] isKindOfClass:[NSNull class]]){
        self.grade = dictionary[@"grade"];
    }
    if(![dictionary[@"addtime"] isKindOfClass:[NSNull class]]){
        self.addtime = dictionary[@"addtime"];
    }
    
    
    /** 司机特有*/
    if(![dictionary[@"driverCard"] isKindOfClass:[NSNull class]]){
        self.driverCard = dictionary[@"driverCard"];
    }
    if(![dictionary[@"driverModel"] isKindOfClass:[NSNull class]]){
        self.driverModel = dictionary[@"driverModel"];
    }
    if(![dictionary[@"driverNumber"] isKindOfClass:[NSNull class]]){
        self.driverNumber = dictionary[@"driverNumber"];
    }
    
    return self;
}

@end
