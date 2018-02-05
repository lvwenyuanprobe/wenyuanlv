//
//  DriverAccountListModel.h
//  mybigbrother
//
//  Created by SN on 2017/5/10.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DriverAccountListModel : NSObject
/** 交易类型*/
@property (nonatomic, strong) NSString * b_status ;
/** 交易金额*/
@property (nonatomic, strong) NSString * bill_money ;
/** 交易时间*/
@property (nonatomic, strong) NSString * bill_time ;
/** 交易日期*/
@property (nonatomic, strong) NSString * date ;
/** 所属服务*/
@property (nonatomic, strong) NSString * f_name ;

/** 当账单为提现服务时 0 处理中 1 审核不通过 2 审核通过*/
@property (nonatomic, strong) NSString * r_status ;
@end
