//
//  HomeGetParntersView.h
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartnersTogetherModel.h"
#import "TacticsShareModel.h"
typedef NS_ENUM(NSInteger,PageContolRequstStyle) {
    PartnerRequstStyle = 1,
    NewRequstStyle = 2,
    BigRequstStyle = 3
};

@protocol HomeGetParntersViewDelegate <NSObject>


/** 约伴同行详情*/
- (void)gotoGetPartnerDetail:(PartnersTogetherModel * )model;
- (void)gotoShareVCDetail:(TacticsShareModel *)model;
/** 加载更多(跳转约伴列表)*/
- (void)loadMoreDataFromServerList;
@end
@interface HomeGetParntersView : UIView
@property (nonatomic, weak)id<HomeGetParntersViewDelegate>delegate;
@property (nonatomic ,assign) PageContolRequstStyle requstStyle;
@property (nonatomic ,copy) NSString *stringRequstStyle;
+(instancetype)initFrame:(CGRect)frame PageContolViewWithTyle:(PageContolRequstStyle)style;

@end
