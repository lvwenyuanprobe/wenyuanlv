//
//  DriverStarsView.h
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverStarsView : UIView

- (void)addStartCount:(NSInteger )count;

- (instancetype)initWithFrame:(CGRect)frame starCount:(NSInteger)count;
@end
