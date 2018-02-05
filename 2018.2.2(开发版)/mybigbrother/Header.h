//
//  Header.h
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#ifndef Header_h
#define Header_h

/** 文件服务器获取资源*/
#define Server_File_Host @""

#ifdef DEBUG

/** 测试环境*/
#define Server_Host        @"http://api.worldbuddy.cn"
/** 关于我们*/
#define MBB_ABOUTUS        @"http://api.worldbuddy.cn/home/index/about"
/** 用户协议*/
#define MBB_USER_AGREEMENT @"http://api.worldbuddy.cn/home/index/agreement"
/** 活动规则*/
#define MBB_ACTIVITY_RULE  @"http://api.worldbuddy.cn/home/index/rule"
/** 提现说明*/
#define MBB_GETCASH_RULE   @"http://api.worldbuddy.cn/home/index/withdrawals"
/** 支付协议*/
#define MBB_PAYAGREEMENT   @"http://api.worldbuddy.cn/home/pay/agreement"

#else

/** 生产环境*/
#define Server_Host        @"http://api.worldbuddy.cn"
/** 关于我们*/
#define MBB_ABOUTUS        @"http://api.worldbuddy.cn/home/index/about"
/** 用户协议*/
#define MBB_USER_AGREEMENT @"http://api.worldbuddy.cn/home/index/agreement"
/** 活动规则*/
#define MBB_ACTIVITY_RULE  @"http://api.worldbuddy.cn/home/index/rule"
/** 提现说明*/
#define MBB_GETCASH_RULE   @"http://api.worldbuddy.cn/home/index/withdrawals"
/** 支付协议*/
#define MBB_PAYAGREEMENT   @"http://api.worldbuddy.cn/home/pay/agreement"

#endif

/*正式服务器*/
// http://api.worldbuddy.cn

/*测试服务器*/
// http://dev.api.worldbuddy.cn








/** 日志输出宏定义*/
#ifdef DEBUG
/** 调试状态*/
#define ZXLog(...) NSLog(__VA_ARGS__)

#else
/** 发布状态*/
#define ZXLog(...)

#endif


#endif /* Header_h */
