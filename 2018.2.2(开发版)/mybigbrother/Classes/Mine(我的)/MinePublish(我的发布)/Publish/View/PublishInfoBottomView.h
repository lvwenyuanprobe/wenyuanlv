//
//  PublishInfoBottomView.h
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PublishInfoBottomViewDelegate <NSObject>
/** 添加照片*/
- (void)bottomViewAddPhotos;

@end

@interface PublishInfoBottomView : UIView
@property (nonatomic, weak)id<PublishInfoBottomViewDelegate>delegate;
/** 图片*/
@property (nonatomic, strong) UIImageView * selectIamge;
@end
