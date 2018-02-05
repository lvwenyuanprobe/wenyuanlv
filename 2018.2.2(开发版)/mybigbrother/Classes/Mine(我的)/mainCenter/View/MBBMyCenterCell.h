//
//  MBBMyCenterCell.h
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MBBMyCenterCellDelegate <NSObject>
/** 客服*/
- (void)outSideCustomService;
- (void)inSideCustomService;
@end

@interface MBBMyCenterCell : UITableViewCell
@property(nonatomic,weak)UIImageView * leftView;
@property(nonatomic,weak)UILabel * menuLabel;


@property(nonatomic,weak)UIImageView * rightImage;
@property(nonatomic,weak)UILabel * rightLabel;
@property (nonatomic, strong) NSIndexPath * indexPath ;

@property (nonatomic, weak)id<MBBMyCenterCellDelegate>delegate;

@end
