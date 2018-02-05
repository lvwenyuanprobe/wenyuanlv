//
//  MBBTextViewTableViewCell.h
//  mybigbrother
//
//  Created by qiu on 21/1/18.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBBTextViewTableViewCell : UITableViewCell<UITextViewDelegate>

typedef void(^DWQTextViewChangedBlock)(NSString *stringTextView);

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *labelTip;

- (void)textViewWithBlock:(DWQTextViewChangedBlock)block;

@end
