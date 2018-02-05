//
//  GYLClearCacheCell.m
//  清除缓存
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 probe_lwy@163.com. All rights reserved.
//

#import "GYLClearCacheCell.h"
#import "SDImageCache.h"
#import "SVProgressHUD.h"
#import "NSString+GYLExtension.h"

#define GYLCustomFile [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"MP3"]


@implementation GYLClearCacheCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        
        self.textLabel.text = @"清除缓存";
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.textColor = RGB(116, 116, 116);
        self.detailTextLabel.text = @"正在计算";
        self.detailTextLabel.font = [UIFont systemFontOfSize:15];
        
        self.userInteractionEnabled = NO;
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:1.0];
            
            //            NSString *customFileCache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"MP3"];
            
            unsigned long long size = GYLCustomFile.fileSize;
            NSLog(@"customFile -size:%zd",size);
            
            size += [SDImageCache sharedImageCache].getSize;   //SDImage 缓存
            //            NSLog(@"缓存值 - %zd",[SDImageCache sharedImageCache].getSize);
            
            
            NSLog(@"allFile -size:%zd",size);
            
            if (weakSelf == nil) return;
            
            NSString *sizeText = nil;
            if (size >= pow(10, 9)) {
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            }else if (size >= pow(10, 6)) {
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
                //                NSLog(@"换算缓存值  %zd",[NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)]);
            }else if (size >= pow(10, 3)) {
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            }else {
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                weakSelf.detailTextLabel.text = [NSString stringWithFormat:@"%@",sizeText];
                weakSelf.accessoryView = nil;
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(isClearCache)]];
                
                weakSelf.userInteractionEnabled = YES;
                
            });
            
        });
        
    }
    
    return self;
}

// 先提示是否清楚缓存
- (void)isClearCache
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                             message:@"是否清除应用缓存？"
                                                                      preferredStyle:UIAlertControllerStyleAlert ];
    
    //添加取消到UIAlertController中
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [cancelAction setValue:[UIColor grayColor] forKey:@"titleTextColor"];
    
    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 调用清除方法
        [self clearCacheClick];
    }];
    [OKAction setValue:[UIColor orangeColor] forKey:@"titleTextColor"];
    [alertController addAction:OKAction];
    
    [[self viewController].navigationController presentViewController:alertController animated:YES completion:^{
    }];
    
}
- (void)clearCacheClick
{
    [SVProgressHUD showWithStatus:@"正在清除缓存···"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [NSThread sleepForTimeInterval:2.0];
            
            NSFileManager *mgr = [NSFileManager defaultManager];
            [mgr removeItemAtPath:GYLCustomFile error:nil];
            [mgr createDirectoryAtPath:GYLCustomFile withIntermediateDirectories:YES attributes:nil error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
                
                // 设置文字
                self.detailTextLabel.text = nil;
                
            });
            
        });
    }];
}

/**
 *  当cell重新显示到屏幕上时, 也会调用一次layoutSubviews
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // cell重新显示的时候, 继续转圈圈
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}


@end

