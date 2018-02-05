//
//  PublishMiddleView.h
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger, KSexSignType){
    KSexGirl = 100,
    KSexBoy,
    KSexX,
};

@protocol PublishMiddleViewDelegate <NSObject>
/** 选择性别标签*/
- (void)chooseSexSign:(KSexSignType)type;

@end

@interface PublishMiddleView : UIView
/** 简介*/
@property (nonatomic, strong) MBBCustomTextView * explain ;
@property (nonatomic, weak) id<PublishMiddleViewDelegate>delegate;
@end
