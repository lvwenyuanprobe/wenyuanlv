//
//  WYTableViewCell.h
//  mybigbrother
//
//  Created by qiu on 9/1/18.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DWQNumberChangedBlock)(NSInteger number);

@interface WYTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLab;

@property (nonatomic, strong) UIButton *subtractionButton;

- (void)numberAddWithBlock:(DWQNumberChangedBlock)block;

@end
