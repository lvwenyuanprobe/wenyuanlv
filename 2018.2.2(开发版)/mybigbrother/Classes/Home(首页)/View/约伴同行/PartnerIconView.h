//
//  PartnerIconView.h
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartnersTogetherModel.h"
#import "TacticsShareModel.h"

@interface PartnerIconView : UICollectionViewCell
/** 模型*/
@property (nonatomic, strong) PartnersTogetherModel * model;
@property (nonatomic, strong) TacticsShareModel  * model1 ;


@end

