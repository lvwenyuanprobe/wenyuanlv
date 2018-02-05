//
//  PublishInfoTopView.h
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger, KInfoType){
    KInfoLeave = 100,
    KInfoArrive,
    KInfoPlaneNum,
    KInfoSetoutTime,
    KInfoSchool,
};

@protocol PublishInfoTopViewDelegate <NSObject>
/** 填写信息*/
- (void)turnToInputView:(KInfoType)infoType;
@end

@interface PublishInfoTopView : UIView
@property (nonatomic, weak)id<PublishInfoTopViewDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *   cellArray;

@end
