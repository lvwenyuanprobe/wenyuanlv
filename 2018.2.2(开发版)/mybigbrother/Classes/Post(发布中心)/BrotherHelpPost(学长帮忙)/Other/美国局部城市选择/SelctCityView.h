//
//  SelctCityView.h
//  mybigbrother
//
//  Created by Loren on 2018/2/2.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyCitySelectBlock)(NSString *selectCity);

@interface SelctCityView : UIView

-(instancetype)initWithFrame:(CGRect)frame andMyCitySelect:(MyCitySelectBlock)selectCity;

@property (nonatomic, copy) MyCitySelectBlock block;

@end
