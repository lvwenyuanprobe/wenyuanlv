//
//  MessageModel.h
//  mybigbrother
//
//  Created by SN on 2017/6/2.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
/** */
@property (nonatomic, strong) NSString *  add_time;
/** 内容*/
@property (nonatomic, strong) NSString *  content;



@property (nonatomic, strong) NSString *  id;
@property (nonatomic, strong) NSString *  type;

@end
