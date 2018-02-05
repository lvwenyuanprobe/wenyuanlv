//
//  ChoosePersonCountPicker.h
//  mybigbrother
//
//  Created by SN on 2017/4/14.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePersonCountPicker : UIView

- (id)initWithFrame:(CGRect)frame  withData:(NSArray *)outDataArray withCancel:(void(^)(void))cancelBlock withConfirm:(void(^)(NSInteger adult,NSInteger child))confirmBlock;

@property(nonatomic,strong)void (^SelectType)(NSInteger adult,NSInteger child);

@property(nonatomic,strong)void (^cancelAction)();

@end
