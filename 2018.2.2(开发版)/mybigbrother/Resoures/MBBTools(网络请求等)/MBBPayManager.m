//
//  MBBPayManager.m
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBPayManager.h"


#pragma mark - 微信
#import "WXApi.h"

#pragma mark - 支付宝
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>


@implementation MBBPayManager


/** 支付宝支付*/
+ (void)payUseAlipayWithOrderInfo:(NSMutableDictionary *)paramDic callBack:(void (^)(NSString *))resultBlock{
    //调用AliPaySdk进行支付
    paramDic[@"sign"] = @"paypay";
    [MBBNetworkManager userPayAlipay:paramDic responseResult:^(YTKBaseRequest *request) {
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            /** 设置返回原app*/
            //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
            NSString *appScheme = @"mybigbrother";
            /** 将签名成功字符串格式化为订单字符串,请严格按照该格式*/
            NSString *orderString = nil;
            orderString = request.responseJSONObject[@"data"];
            /** 调起支付*/
            [[AlipaySDK defaultService]
             payOrder:orderString
             fromScheme:appScheme
             callback:^(NSDictionary *resultDic) {
                 NSLog(@"reslut = %@", resultDic);
                 if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                     //支付成功
                     resultBlock(@"sccess");
                     
                 } else {
                     resultBlock(@"failure");
                 }
             }];
        }else{
            resultBlock(@"failure");
        }
        
    }];
}

/** 微信支付*/
+ (void)payUseWeixinWithOrderInfo:(NSMutableDictionary *)paramDic callBack:(void (^)(NSString *))resultBlock{
    paramDic[@"sign"] = @"paywepay";
    [MBBNetworkManager userPayWechat:paramDic responseResult:^(YTKBaseRequest *request) {
        
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            NSDictionary * WXdic = [NSDictionary dictionary];
            WXdic = request.responseJSONObject[@"data"];
            //调用TenPaySdk进行支付
            NSString *stamp  = WXdic[@"timestamp"];
            //调起微信支付
            PayReq * req             = [[PayReq alloc] init];
            req.openID              = WXdic[@"appid"];
            req.partnerId           = WXdic[@"partnerid"];
            req.prepayId            = WXdic[@"prepayid"];
            req.nonceStr            = WXdic[@"noncestr"];
            req.timeStamp           = stamp.intValue;
            /** 微信版本不同,该字段可能不同*/
            req.package             = @"Sign=WXPay";
            req.sign                = WXdic[@"sign"];
            
            if([WXApi sendReq:req])
            {
                [WXApi sendReq:req];
                
            }else
            {
                
                
            }
            /** 支付成功与失败:(通知)*/
        }else{
            
       
        }
    }];

}
@end
