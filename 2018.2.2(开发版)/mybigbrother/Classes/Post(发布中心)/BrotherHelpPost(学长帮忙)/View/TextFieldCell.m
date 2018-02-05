//
//  TextFieldCell.m
//  mybigbrother
//
//  Created by apple on 2018/1/23.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "TextFieldCell.h"
#import "CreateTableModel.h"

@interface TextFieldCell()
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UITextField *textField;
@end

@implementation TextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.label = [UILabel new];
    [self.contentView addSubview:self.label];
    self.label.font = [UIFont systemFontOfSize:15.0f];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.textField = [UITextField new];
    [self.contentView addSubview:self.textField];
    self.textField.textAlignment = NSTextAlignmentRight;
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.label);
        make.right.mas_equalTo(-15);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueChanged:) name:UITextFieldTextDidChangeNotification object:self.textField];
}

#pragma mark --textField添加通知回调
- (void)textFieldAddObserver:(id)observer selector:(SEL)selector
{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:UITextFieldTextDidChangeNotification object:self.textField];
}

- (void)setCreatTableModel:(CreateTableModel *)creatTableModel
{
    _creatTableModel = creatTableModel;
    
    self.label.text = creatTableModel.title;
    self.textField.placeholder = creatTableModel.placeholder;
    // 修改textField文字大小
    [self.textField setValue:[UIFont systemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
    // 修改textField文字颜色
//    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setFormDict:(NSMutableDictionary *)formDict
{
    _formDict = formDict;
    self.textField.text = [formDict valueForKey:self.creatTableModel.key];
}

//将输入的内容保存到formDict里面
- (void)textFieldValueChanged:(NSNotification *)note
{
    if (!self.creatTableModel) {
        return;
    }
    [self.formDict setValue:self.textField.text forKey:self.creatTableModel.key];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

@end

