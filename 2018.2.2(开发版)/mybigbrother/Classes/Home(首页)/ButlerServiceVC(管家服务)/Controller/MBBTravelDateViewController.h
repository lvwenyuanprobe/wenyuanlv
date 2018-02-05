//
//  MBBTravelDateViewController.h
//  mybigbrother
//
//  Created by qiu on 21/1/18.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectCallback)(NSString *selectString);

@interface MBBTravelDateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableViewCountry;
@property (weak, nonatomic) IBOutlet UITableView *tableViewProvince;
@property (weak, nonatomic) IBOutlet UITableView *tableVIewCity;

@property (nonatomic, copy) SelectCallback selectStringCallback;//点击确定返回关联事项的Array

@end
