//
//  GetPartnerDetailHeader.h
//  mybigbrother
//
//  Created by SN on 2017/4/1.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PartnersTogetherModel.h"

@interface GetPartnerDetailHeader : UIView

@property (nonatomic, strong) PartnersTogetherModel * model;
/** 跳转*/
@property (nonatomic, strong) UINavigationController * KNavgationController;
@end
