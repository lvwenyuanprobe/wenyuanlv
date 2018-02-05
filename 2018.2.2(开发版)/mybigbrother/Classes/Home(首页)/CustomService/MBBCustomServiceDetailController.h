//
//  MBBCustomServiceDetailController.h
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBBaseUIViewController.h"
//导入头文件
#import <JavaScriptCore/JavaScriptCore.h>
@protocol JSObjcDelegate <JSExport>
//tianbai对象调用的JavaScript方法，必须声明！！！
- (void)call;
- (void)getCall:(NSString *)callString;

@end
@interface MBBCustomServiceDetailController : MBBBaseUIViewController<UIWebViewDelegate,JSObjcDelegate>
/** 服务id (必传)*/
@property (nonatomic, strong) NSString * serviceId;
/** 0 学生类服务  1 家长类服务 (必传) **/
@property (nonatomic, strong) NSString * serviceType;
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) JSContext *jsContext;

@end
