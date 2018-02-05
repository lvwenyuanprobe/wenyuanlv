//
//  NSString+GYLExtension.m
//  清除缓存
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 probe_lwy@163.com. All rights reserved.
//

#import "NSString+GYLExtension.h"

@implementation NSString (GYLExtension)
- (unsigned long long)fileSize
{
    unsigned long long size = 0;
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    
    BOOL isExist = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    
    if(!isExist) return size;
    
    if (isExist) {
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subPath in enumerator) {
            
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
            
            size +=[mgr attributesOfItemAtPath:fullPath error:nil].fileSize;
            
        }
    }else
    {
        size = [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
    
    return size;
}

@end

