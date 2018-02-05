//
//  MBBPayManager.h
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBBPayManager : NSObject

/**
 *  支付宝支付
 *  @param dic              订单基本信息
 *  @param resultBlock      支付结果回调Block(成功:success,失败返回:failure)
 */
+ (void)payUseAlipayWithOrderInfo:(NSMutableDictionary *)dic callBack:(void(^)(NSString * result))resultBlock;



/**
 *  微信支付
 *  @param dic              订单基本信息
 *  @param resultBlock      支付结果回调Block(成功:success,失败返回:failure)
 */
+ (void)payUseWeixinWithOrderInfo:(NSDictionary *)dic callBack:(void(^)(NSString * result))resultBlock;

@end
