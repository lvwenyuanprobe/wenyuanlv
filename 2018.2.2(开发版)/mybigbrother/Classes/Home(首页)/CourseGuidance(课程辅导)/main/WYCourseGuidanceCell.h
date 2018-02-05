//
//  WYCourseGuidanceCell.h
//  mybigbrother
//
//  Created by Loren on 2018/1/9.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

//#import "WYCourseMdel.h"
//@class WYCourseMdel;

typedef void(^DWQGoBreifVCBlock)(NSString *ButtonText);

@interface WYCourseGuidanceCell : UITableViewCell

//@property (nonatomic,strong) WYCourseMdel *CourseMdel;

// 头像
@property (nonatomic,strong) UIImageView *iconImgView;

@property (nonatomic,strong) UIImageView *tvImgView;
// 讲师
@property (nonatomic,strong) UILabel *teacher;
// 讲师名称
@property (nonatomic,strong) UILabel *teacherName;
// 主讲
@property (nonatomic,strong) UILabel *mainLecture;
// 主讲课程
@property (nonatomic,strong) UILabel *mainLectureName;
// 课程
@property (nonatomic,strong) UILabel *message;
// 课程名称
@property (nonatomic,strong) UILabel *messageContent;
// 简介
@property (nonatomic,strong) UIButton *breif;

- (void)goToBreifVCBlock:(DWQGoBreifVCBlock)block;


@end
