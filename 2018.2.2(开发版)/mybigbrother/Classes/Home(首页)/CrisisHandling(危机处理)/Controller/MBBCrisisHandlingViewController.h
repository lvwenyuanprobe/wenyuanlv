//
//  MBBCrisisHandlingViewController.h
//  mybigbrother
//
//  Created by qiu on 21/1/18.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBBCrisisHandlingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
///判断String空不空；
bool isNotEmptyNotNullString(NSString *string);
@end
