//
//  XTVersion.m
//  XiaoTu
//
//  Created by 何振东 on 15/7/7.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import "TWVersionChecker.h"

//此链接为苹果官方查询App的接口。
#define kAPPURL     @"http://itunes.apple.com/lookup?id="

@interface TWVersionChecker ()

@end

@implementation TWVersionChecker

+ (void)checkVersionForAppId:(NSString *)appId completionHandler:(void (^)(BOOL hasNew, NSString *updateText, NSString *updateUrl, NSString *version))completionHandler
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kAPPURL, appId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

             if (error) {
                 if (completionHandler) {
                     completionHandler(NO, nil, nil, nil);
                 }
             } else {
                 NSDictionary *remoteInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 NSString *latestVersion = [remoteInfo[@"results"] firstObject][@"version"];
                 NSString *releaseNotes = [remoteInfo[@"results"] firstObject][@"releaseNotes"];
                 NSString *updateUrl = [remoteInfo[@"results"] firstObject][@"trackViewUrl"];
                
                 if ((completionHandler)) {
                     completionHandler(YES, releaseNotes, updateUrl, latestVersion);
                 }
                
             }
         });
     }];
}

@end
