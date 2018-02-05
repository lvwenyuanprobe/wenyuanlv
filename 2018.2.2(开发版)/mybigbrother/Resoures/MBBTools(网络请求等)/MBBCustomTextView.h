//
//  MBBCustomTextView.h
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBBCustomTextView : UITextView

@property (nonatomic,weak)UILabel * placeholderLabel;


- (id)initWithFrame:(CGRect)frame andPlaceholder:(NSString *)placeholder andPlaceholderColor:(UIColor *)color;

/** 自定义标签*/
- (id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder holderColor:(UIColor *)color;

@end
