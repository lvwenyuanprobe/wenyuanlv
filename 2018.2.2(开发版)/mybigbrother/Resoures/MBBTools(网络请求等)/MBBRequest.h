//
//  MBBRequest.h
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "YTKRequest.h"

@interface MBBRequest : YTKRequest
    /** 网络请求*/
- (instancetype)initWithRUrl:(NSString *)url andRMethod:(YTKRequestMethod)method andRArgument:(id)argument;
@end
