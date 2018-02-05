//
//  CollectCommentShareView.h
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger, KBottomOpreationType){
    KBottomFav = 0,
    KBottomCollect,
    KBottomShare,
};

@protocol CollectCommentShareViewDelegate <NSObject>
/** 底部button对应不同的操作*/
- (void)bottomViewOperation:(KBottomOpreationType)type;

@end

@interface CollectCommentShareView : UIView
@property (nonatomic, weak)id<CollectCommentShareViewDelegate>delegate;


@end
