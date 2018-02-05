//
//  MBBRequest.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBRequest.h"


@interface MBBRequest ()
@property(nonatomic, strong) NSString *rURl;
@property YTKRequestMethod rMethod;
@property(nonatomic, strong) id rArgument;
@end

@implementation MBBRequest
    
- (instancetype)initWithRUrl:(NSString *)url
                  andRMethod:(YTKRequestMethod)method
                andRArgument:(id)argument {
    if (self = [super init]) {
        self.rURl = url;
        self.rMethod = method;
        self.rArgument = argument;
    }
    return self;
}
    
#pragma mark--- 重载YTKRequest的一些设置方法
- (NSInteger)cacheTimeInSeconds {
    return  1 ;
}

- (NSString *)requestUrl {
    return self.rURl;
}
- (YTKRequestMethod)requestMethod {
    return self.rMethod;
}
    
- (id)requestArgument {
    
    NSMutableDictionary * argDic = [[NSMutableDictionary alloc] init];
    NSArray * allKeys = [self.rArgument allKeys];
    for (NSString * key in allKeys) {
        [argDic setObject:[self.rArgument valueForKey:key] forKey:key];
    }
    /** 加密MD5*/
    for (NSString * key in allKeys) {
        if ([key isEqualToString:@"sign"]) {
            /** 当前不加密0412*/
            [argDic removeObjectForKey:@"sign"];
            /** 加密 + 当前时间戳*/
//            NSString * encryptStr = [argDic[@"sign"] md5String];
//            NSDate   * senddate = [NSDate date];
//            NSString * timep = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
//            argDic[@"sign"] = [NSString stringWithFormat:@"%@%@",encryptStr,timep];
        }
    }
    
    return argDic;
}

@end
