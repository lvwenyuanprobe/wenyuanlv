//
//  AppDelegate.h
//  mybigbrother
//
//  Created by wang on 2017/3/29.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "WXApi.h"
#import "WXApiObject.h"
#import <AlipaySDK/AlipaySDK.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

