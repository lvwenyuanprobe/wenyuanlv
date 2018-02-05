//
//  MBBAboutUsController.h
//  mybigbrother
//
//  Created by SN on 2017/5/19.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBBaseUIViewController.h"

#import "BannerModel.h"
#import "ServiceBannerModel.h"
//导入头文件
#import <JavaScriptCore/JavaScriptCore.h>
@protocol JSObjcDelegate <JSExport>
//tianbai对象调用的JavaScript方法，必须声明！！！
- (void)call;
- (void)getCall:(NSString *)callString;

@end
@interface MBBAboutUsController : MBBBaseUIViewController<UIWebViewDelegate,JSObjcDelegate>

@property (nonatomic, strong) UIWebView * webViewDoc;
@property (nonatomic, strong) JSContext *jsContext;


/** 0 关于我们 1 活动规则 2 用户协议 3 提现说明 4 支付协议 5 banner*/

@property (nonatomic, strong) NSString * loadType;

/************  banner ***********/

/** 首页 */
@property (nonatomic, strong) BannerModel * HomeModel;
/** 学生banner**/
@property (nonatomic, strong) ServiceBannerModel * ServiceModel;

@end
