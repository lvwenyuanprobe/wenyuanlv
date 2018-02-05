//
//  MBBServiceOptionView.h
//  mybigbrother
//
//  Created by SN on 2017/4/1.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MBBServiceOptionView;
@class ServicesModel;

@protocol  MBBServiceOptionViewDelegate <NSObject>
/** 服务详情*/
- (void)showServiceDetail:(MBBServiceOptionView *)optionView;

@end
@interface MBBServiceOptionView : UIView
@property(nonatomic, weak) id<MBBServiceOptionViewDelegate>delegate;

@property (nonatomic, strong) ServicesModel * model;
@end
