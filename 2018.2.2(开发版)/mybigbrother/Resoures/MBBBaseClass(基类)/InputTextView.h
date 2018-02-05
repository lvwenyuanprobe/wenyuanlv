//
//  InputTextView.h
//  mybigbrother
//
//  Created by SN on 2017/4/18.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol InputTextViewDelegate <NSObject>
/** 确定输入内容*/
- (void)makeSureInputContentText:(NSString *)content;

@end

@interface InputTextView : UIView
/** 输入框*/
@property (nonatomic, strong) UITextView * textView;
/** 按钮*/
@property (nonatomic, strong) UIButton *   sureBtn;

/** 代理*/
@property (nonatomic, weak) id<InputTextViewDelegate>delegate;

@end
