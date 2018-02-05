//
//  DriverGetCashInfoView.h
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger, KInfoType){
    KInfoName = 100,/** 姓名*/
    KInfoMethod,    /** 方式*/
    KInfoAccount,   /** 账户*/
    KInfoMoney,   /** 金额*/

};

@protocol DriverGetCashInfoViewDelegate <NSObject>
/** */
- (void)completeInfo:(KInfoType)infoType;

@end

@interface DriverGetCashInfoView : UIView
@property (nonatomic, weak)id<DriverGetCashInfoViewDelegate>delegate;
@end
