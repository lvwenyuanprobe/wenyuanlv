//
//  MBBChoosePayMethodView.h
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger, KPayMethodType){
    KPayUseAlipay = 100,
    KPayUseWeixin,
};
@protocol MBBChoosePayMethodViewDelegate <NSObject>
/** 确定选中的支付方式*/
- (void)makeSurePayMethod:(KPayMethodType )type;
/** 使用优惠券选项*/
- (void)tapCouponView;
@end

@interface MBBChoosePayMethodView : UIView
/** 显示优惠*/
@property (nonatomic, strong) UILabel * rightDiscount;
@property (nonatomic, weak)id<MBBChoosePayMethodViewDelegate>delegate;
@end
