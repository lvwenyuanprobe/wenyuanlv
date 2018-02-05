//
//  DetailReplyCell.h
//  mybigbrother
//
//  Created by SN on 2017/4/1.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@class CommentModel;
@protocol DetailReplyCellDelegate <NSObject>

@optional
/** 回复 or 评论 */
- (void)operationReply:(CommentModel *)model;
/** 举报此条内容*/
- (void)reportUserContent:(CommentModel *)model;

/** 查看回复人资料*/
- (void)scanReplyUserPersonInfo:(CommentModel *)model;

@end

@interface DetailReplyCell : UITableViewCell
@property (nonatomic, strong) CommentModel * model;
@property (nonatomic, weak) id<DetailReplyCellDelegate>delegate;
@end
