//
//  TextFieldCell.h
//  mybigbrother
//
//  Created by apple on 2018/1/23.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CreateTableModel;
@interface TextFieldCell : UITableViewCell
@property (nonatomic,weak) CreateTableModel *creatTableModel;
@property (nonatomic,weak) NSDictionary *formDict;
//方便外部把控好输入框
- (void)textFieldAddObserver:(id)observer selector:(SEL)selector;
@end
