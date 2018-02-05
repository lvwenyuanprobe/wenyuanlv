//
//  BRTextField.h
//  mybigbrother
//
//  Created by apple on 2018/1/23.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.

#import <UIKit/UIKit.h>

typedef void(^BRTapAcitonBlock)(void);
typedef void(^BREndEditBlock)(NSString *text);

@interface BRTextField : UITextField
/** textField 的点击回调 */
@property (nonatomic, copy) BRTapAcitonBlock tapAcitonBlock;
/** textField 结束编辑的回调 */
@property (nonatomic, copy) BREndEditBlock endEditBlock;

@end
