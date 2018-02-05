//
//  MBBInviteFriendView.h
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MBBInviteFriendViewDelegate <NSObject>
@required
/** 邀请好友*/
- (void)immediatelyInviteFriends:(KFriendType)friendType;
@optional
/** 消失时传出事件*/
- (void)dismissInviteView;
@end

@interface MBBInviteFriendView : UIView
@property (nonatomic, weak) id<MBBInviteFriendViewDelegate>delegate;
/** normal */
-(void)showInviteView;

/** Has no navgationBar*/
-(void)hasNoNavgationBarShowInviteView;
@end
