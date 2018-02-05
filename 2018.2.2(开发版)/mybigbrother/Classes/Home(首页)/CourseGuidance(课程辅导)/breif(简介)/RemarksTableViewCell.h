//
//  RemarksTableViewCell.h
//  mybigbrother
//
//  Created by Loren on 2018/1/10.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RemarksCellDelegate <NSObject>

- (void)remarksCellShowContrntWithDic:(NSDictionary *)dic andCellIndexPath:(NSIndexPath *)indexPath;

@end

@interface RemarksTableViewCell : UITableViewCell

@property (nonatomic, weak) id<RemarksCellDelegate> delegate;

@property (nonatomic ,strong) UILabel *infolable;
@property (nonatomic ,strong) UILabel *textsLabel;
@property (nonatomic ,strong) UIButton *moreBtn;   // 展开收起按钮
@property (nonatomic ,strong) UIButton *moreLab;   // 展开收起按钮

- (void)setCellContent:(NSString *)contentStr andIsShow:(BOOL)isShow andCellIndexPath:(NSIndexPath *)indexPath;

@end
