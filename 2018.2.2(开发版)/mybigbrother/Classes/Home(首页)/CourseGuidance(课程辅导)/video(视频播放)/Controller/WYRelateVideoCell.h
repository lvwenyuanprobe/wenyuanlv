//
//  WYRelateVideoCell.h
//  mybigbrother
//
//  Created by Loren on 2018/1/12.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYRelateVideoCell : UITableViewCell

// 讲师
@property (nonatomic,strong) UILabel * teacherLabel;
// 讲师名称
@property (nonatomic,strong) UILabel * teacher;
// 课程
@property (nonatomic,strong) UILabel * coruseLabel;
// 课程名称
@property (nonatomic,strong) UILabel * coruse;
// 播放次数
@property (nonatomic,strong) UILabel * playerNumber;
// 讲师图片
@property (nonatomic,strong) UIImageView * teacherIcon;

@end
