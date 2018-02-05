//
//  CustomServiceFooter.h
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomServiceFooterDelegate <NSObject>
/** 我要定制*/
- (void)customTap;
/** 提交信息*/
- (void)submitInformationDic:(NSDictionary *)dic;
/** 隐藏*/
- (void)dismissBottomView;
@end

@interface CustomServiceFooter : UIView
@property (nonatomic, weak) id<CustomServiceFooterDelegate>delegate;
@end
