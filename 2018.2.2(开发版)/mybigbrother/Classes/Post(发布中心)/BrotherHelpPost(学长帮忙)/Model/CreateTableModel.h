//
//  CreateTableModel.h
//  mybigbrother
//
//  Created by apple on 2018/1/23.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CreateTableCellType) {
    CreateTableNormalCell,
    CreateTableTFCell,
    CreateTableSeparatorCell,
    CreateTableSelectCell,
    CreateTablePhotoCell,
    CreateTableTVCell,
};

@interface CreateTableModel : NSObject
// 名称
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *placeholder;
// 表单对应的字段
@property (nonatomic, copy)NSString *key;
//cell图片
@property (nonatomic,copy) NSString *imageName;

@property (nonatomic,assign) NSInteger maxLength;
// cell的类型
@property (nonatomic, assign)CreateTableCellType cellType;

@property (nonatomic,assign) UIKeyboardType keyboardType;

//图片cell用到
@property (nonatomic,copy) NSString *imgURL;


@property (nonatomic,copy) NSString *controllerName;
@property (nonatomic,assign) BOOL hidesBottomBarWhenPushed;

@property (nonatomic,copy) void (^operationBlock)(void);

@end

