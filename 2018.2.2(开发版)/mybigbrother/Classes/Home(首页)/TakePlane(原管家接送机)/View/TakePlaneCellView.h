//
//  TakePlaneCellView.h
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakePlaneCellView : UIView
@property (nonatomic, strong) UIImageView * leftImage ;
@property (nonatomic, strong) UIImageView * rightArrow;
@property (nonatomic, strong) UILabel     * titleLabel ;
@property (nonatomic, strong) UITextField * rightLabel ;

@property (nonatomic, strong) UIView * line;
@end
