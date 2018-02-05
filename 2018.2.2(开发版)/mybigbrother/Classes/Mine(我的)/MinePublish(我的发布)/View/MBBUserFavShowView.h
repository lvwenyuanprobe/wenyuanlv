//
//  MBBUserFavShowView.h
//  mybigbrother
//
//  Created by SN on 2017/6/12.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBBUserFavModel.h"
@protocol MBBUserFavShowViewDelegate <NSObject>
/** click nickname */
- (void)clickedNicknameWith:(MBBUserFavModel * )favUsermodel;

@end

@interface MBBUserFavShowView : UIView

/** 标签数组*/
@property (nonatomic, strong) NSMutableArray * labelArray;
/** 代理*/
@property (nonatomic, weak) id<MBBUserFavShowViewDelegate>delegate;

@end
