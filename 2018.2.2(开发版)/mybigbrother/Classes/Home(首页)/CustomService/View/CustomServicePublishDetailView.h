//
//  CustomServicePublishDetailView.h
//  mybigbrother
//
//  Created by SN on 2017/6/21.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomServicePublishDetailViewDelegate <NSObject>
@optional
/** */
- (void)CustomServicePublishDetailViewClick;

@end

@interface CustomServicePublishDetailView : UIView
@property (nonatomic, weak) id<CustomServicePublishDetailViewDelegate>delegate;
@end
