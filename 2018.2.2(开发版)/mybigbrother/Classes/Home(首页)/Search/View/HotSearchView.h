//
//  HotSearchView.h
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HotSearchViewDelegate <NSObject>
/** 热搜结果列表*/
- (void)hotSearchResultList:(UIButton *)button;

@end

@interface HotSearchView : UIView
@property (nonatomic, weak) id<HotSearchViewDelegate>delegate;
@end
