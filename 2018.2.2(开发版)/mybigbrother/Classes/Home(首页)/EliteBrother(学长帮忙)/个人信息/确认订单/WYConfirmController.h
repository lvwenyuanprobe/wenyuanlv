//
//  WYConfirmController.h
//  mybigbrother
//
//  Created by Loren on 2018/1/31.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYConfirmController : UIViewController
// 头像
@property (nonatomic,strong) UIImageView *iconImgView;
// 兼职名称
@property (nonatomic,strong) UILabel *partTimeName;
// 校标
@property (nonatomic,strong) UIImageView *universityTipImg;
// 校名
@property (nonatomic,strong) UILabel *uiniversityName;
// 专业标
@property (nonatomic,strong) UIImageView *professionalImgView;
//专业名称
@property (nonatomic,strong) UILabel *professinalName;
// 星期几
@property (nonatomic,strong) UILabel *weekLabel;
// 起始时间
@property (nonatomic,strong) UILabel *starTime;
// 结束时间
@property (nonatomic,strong) UILabel *endTime;
// /每天
@property (nonatomic,strong) UILabel *everyDayLabel;
// 价钱
@property (nonatomic,strong) UILabel *priceLabel;
// 商品编号名称
@property (nonatomic,strong) UILabel *GoodsNumberName;
// 商品编号
@property (nonatomic,strong) UILabel *GoodsNumber;
// 预约时间
@property (nonatomic,strong) UILabel *appointmentTime;
// 应付金额名称
@property (nonatomic,strong) UILabel *payName;
// 应付金额
@property (nonatomic,strong) UILabel *payAcconut;


@end
