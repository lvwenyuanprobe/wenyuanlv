//
//  PersonalHeaderView.h
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonalHeaderViewDelegate <NSObject>
@optional
/** 更换头像*/
- (void)PersonalChangeIconImage;

@end

@interface PersonalHeaderView : UIButton
/** 头像*/
@property (nonatomic, strong) UIImageView *   icon;

@property (nonatomic, weak) id<PersonalHeaderViewDelegate>delegate;
@end
