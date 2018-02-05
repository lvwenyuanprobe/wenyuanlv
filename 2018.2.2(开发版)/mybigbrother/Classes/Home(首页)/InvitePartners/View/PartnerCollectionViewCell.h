//
//  PartnerCollectionViewcell.h
//  mybigbrother
//
//  Created by SN on 2017/7/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartnersTogetherModel.h"
@interface PartnerCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) PartnersTogetherModel * model;

@property (nonatomic, strong) NSIndexPath  * indexPath;

@end
