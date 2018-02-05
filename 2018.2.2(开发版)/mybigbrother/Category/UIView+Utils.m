//
//  UIView+Utils.m
//  mybigbrother
//
//  Created by apple on 2017/11/20.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)
- (UIView*)subViewOfClassName:(NSString*)className {
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        
        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}
@end
/*
 
 此分类作用是：给系统搜索框切圆角和改“取消”按钮的字体和颜色所用
 
 // 搜索设置
 CGRect mainViewBounds = self.navigationController.view.bounds;
 _customSearchBar = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-60)/2), CGRectGetMinY(mainViewBounds)+30, CGRectGetWidth(mainViewBounds)-60, 30)];
 _customSearchBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
 [self.navigationController.view addSubview: _customSearchBar];
 _customSearchBar.layer.cornerRadius = 15.0f;
 _customSearchBar.layer.masksToBounds = YES;
 

 UIView* backgroundView = [_customSearchBar subViewOfClassName:@"_UISearchBarSearchFieldBackgroundView"];
 backgroundView.layer.cornerRadius = 21.0f;
 backgroundView.clipsToBounds = YES;
 */
 

