//
//  LSSmoothNavgationController.h
//  mybigbrother
//
//  Created by SN on 2017/5/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
/** 适用于首页导航栏渐变
 *  scrollview 替换成tabelView 也同样适用于其他页面
 */

#import <UIKit/UIKit.h>

@interface LSSmoothNavgationController : UIViewController

/** 导航栏中部视图*/
@property (nonatomic, strong) UIView * titleView;

/** 主滚动视图*/
@property (nonatomic, strong) UIScrollView * mainScrollView;
@end
