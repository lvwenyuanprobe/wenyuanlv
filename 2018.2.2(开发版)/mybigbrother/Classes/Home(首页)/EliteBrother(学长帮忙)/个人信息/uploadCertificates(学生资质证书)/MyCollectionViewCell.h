//
//  MyCollectionViewCell.h
//  mybigbrother
//
//  Created by apple on 2018/1/7.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved..
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const kMyCollectionViewCellID;

@interface MyCollectionViewCell : UICollectionViewCell
- (void)configureCellWithPostURL:(NSString *)posterURL;
@property (strong, nonatomic) UIImageView *posterView;
@end
