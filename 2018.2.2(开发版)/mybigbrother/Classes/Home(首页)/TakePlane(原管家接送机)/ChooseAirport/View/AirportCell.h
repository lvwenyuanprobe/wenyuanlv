//
//  AirportCell.h
//  mybigbrother
//
//  Created by SN on 2017/4/17.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AirportModel.h"
#import "SchoolsModel.h"

@interface AirportCell : UITableViewCell
@property (nonatomic, strong) AirportModel * model;
@property (nonatomic, strong) SchoolsModel * schoolModel;

@end
