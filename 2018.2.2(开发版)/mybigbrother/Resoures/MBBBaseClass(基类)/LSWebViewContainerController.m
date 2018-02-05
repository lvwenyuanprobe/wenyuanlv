//
//  LSWebViewContainerController.m
//  mybigbrother
//
//  Created by SN on 2017/5/2.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "LSWebViewContainerController.h"

#import "WebViewJavascriptBridge.h"

@interface LSWebViewContainerController ()
@property WebViewJavascriptBridge * bridge;
@end

@implementation LSWebViewContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 设置webView*/
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
   
    /** 本地的网页*/
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];
   
    /** 开启日志*/
    [WebViewJavascriptBridge enableLogging];
   
    /** webview建桥JS与OjbC*/
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    
    /** 设置代理*/
    [self.bridge setWebViewDelegate:self];
    
    /**
     JS主动调用OC的方法
     这是JS会调用OC_register_method方法，这是OC注册给JS调用的
     JS需要回调，当然JS也可以传参数过来。data就是JS所传的参数，不一定需要传
     OC端通过responseCallback回调JS端，JS就可以得到所需要的数据
     */
    [self.bridge registerHandler:@"OC_register_method" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"js call OC_register_method, data from js is %@", data);
        if (responseCallback) {
            /** OC反馈给JS(data 参数)*/
            responseCallback(@{@"key": @"value"});
        }
    }];
    
    [self.bridge registerHandler:@"OC_register_method" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"js call OC_register_method, data from js is %@", data);
        if (responseCallback) {
            /** OC反馈给JS(data 参数)*/
            responseCallback(@{@"key": @"value"});
        }
    }];
    
    /**
     OC 调用JS方法 ()
     */
    [self.bridge callHandler:@"JS_method" data:@{@"key": @"value"} responseCallback:^(id responseData) {
        /** 从JS获取的参数responseData*/
        NSLog(@"from js: %@", responseData);
        
    }];

    // Do any additional setup after loading the view.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
