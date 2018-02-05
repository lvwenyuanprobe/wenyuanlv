//
//  RecommendFriendView.h
//  mybigbrother
//
//  Created by SN on 2017/5/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger, KOperationType){
    KOperationShare = 100,
    KOperationCancel,
};

@protocol RecommendFriendDelegate <NSObject>
/**  分享或取消*/
- (void)shareOrCancelOperation:(KOperationType )type;

@end

@interface RecommendFriendView : UIView
@property (nonatomic, weak) id<RecommendFriendDelegate>delegate;
@property (nonatomic,   copy) void(^shotImageBlcok)(UIImage * shotImage) ;
@end
