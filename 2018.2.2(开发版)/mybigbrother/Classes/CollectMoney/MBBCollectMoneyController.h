//
//  MBBCollectMoneyController.h
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBBaseUIViewController.h"

@interface MBBCollectMoneyController : MBBBaseUIViewController

/************************* 优惠券筛选条件 (可选)****************************/

/**
 *  服务id : 定制服务1 包车服务2 接机服务3
 *  其他服务id是服务列表中返回的服务f_id
 */
/** 服务的id*/
@property (nonatomic, strong) NSString *  serviceId;

/** 机场的id*/
@property (nonatomic, strong) NSString *  airportId;

/** 车辆的id*/
@property (nonatomic, strong) NSString *  carId;

/*************************   支付条件    (必传) ****************************/
/** 订单Id*/
@property (nonatomic, strong) NSString * orderId;


/*************************   下部展示价格 (必传)  ****************************/

/** 订单价格*/
@property (nonatomic, strong) NSString * orderPrice;

@end
