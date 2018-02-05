//
//  MBBFastLoginView.h
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, KLoginMethodType){
    KLoginMethodWeixin = 100,
    KLoginMethodQQ,
    KLoginMethodWeibo
};

@protocol MBBFastLoginViewDelegate <NSObject>
/** 快登陆按钮点击事件*/
- (void)fastLoginWith:(KLoginMethodType)method;
@end


@interface MBBFastLoginView : UIView
@property (nonatomic, weak) id<MBBFastLoginViewDelegate>delegate;
@end
