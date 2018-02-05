//
//  ParnterFavCommentShareView.h
//  mybigbrother
//
//  Created by SN on 2017/6/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM (NSInteger, KBottomOpreationType){
    KBottomCollection = 0,
    KBottomComment,
    KBottomShare,
};

@protocol ParnterFavCommentShareViewDelegate <NSObject>
/** 底部button对应不同的操作*/
- (void)bottomViewOperation:(KBottomOpreationType)type;
@end

@interface ParnterFavCommentShareView : UIView

@property (nonatomic, weak)id<ParnterFavCommentShareViewDelegate>delegate;


@end
