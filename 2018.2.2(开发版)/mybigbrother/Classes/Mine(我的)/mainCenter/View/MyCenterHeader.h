//
//  MyCenterHeader.h
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyCenterHeaderDelegate <NSObject>
/** 头像点击*/
- (void)MyCenterIconTap;

@end
@interface MyCenterHeader : UIImageView

@property(nonatomic,weak)id<MyCenterHeaderDelegate>delegate;

@end
