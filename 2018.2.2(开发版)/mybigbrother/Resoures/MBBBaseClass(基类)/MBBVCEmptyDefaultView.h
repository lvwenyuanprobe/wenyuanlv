//
//  MBBVCEmptyDefaultView.h
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBBVCEmptyDefaultView : UIView

/**
 *  设置默认图
 *  @param frame     大小
 *  @param image     图片
 *  @param title     主
 *  @param subTitle  副
 */
- (instancetype)initWithFrame:(CGRect)frame centerImage:(NSString *)image title:(NSString *)title subTitle:(NSString * )subTitle;




/** 默认图*/
@property (nonatomic, strong) NSString * defaultImageStr;
/** 主默认说明*/
@property (nonatomic, strong) NSString * mainTitle;
/** 副默认说明*/
@property (nonatomic, strong) NSString * subTitle;



@end
