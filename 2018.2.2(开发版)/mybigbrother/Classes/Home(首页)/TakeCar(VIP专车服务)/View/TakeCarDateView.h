//
//  TakeCarDateView.h
//  mybigbrother
//
//  Created by SN on 2017/4/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger, KTakeCarTimeType){
     KTakeCarTimeBegin= 100,
     KTakeCarTimeEnd,
};

@protocol TakeCarDateViewDelegate <NSObject>
/** */
- (void)takeCarTimeChoose:(KTakeCarTimeType)type;

@end

@interface TakeCarDateView : UIView
@property (nonatomic, strong) UILabel * beginLabel ;
@property (nonatomic, strong) UILabel * endLabel ;
@property (nonatomic, weak)   id<TakeCarDateViewDelegate>delegate;
@end
