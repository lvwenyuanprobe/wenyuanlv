//
//  CountryChooseView.h
//  mybigbrother
//
//  Created by SN on 2017/6/16.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CountryChooseView;
@protocol CountryChooseViewDelegate <NSObject>
/**  选中地区编码*/
- (void)makeChoiceCountry:(CountryChooseView * )countryCodeView;

@end

@interface CountryChooseView : UIView

@property (nonatomic, weak) id<CountryChooseViewDelegate>delegate;

@property (nonatomic, strong) NSString * countryNum ;
@end
