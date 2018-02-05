//
//  WYCrisisHandlingTableViewCell.m
//  mybigbrother
//
//  Created by qiu on 21/1/18.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYCrisisHandlingTableViewCell.h"
@interface WYCrisisHandlingTableViewCell ()
{
    DWQTextFieldChangedBlock textFiledChangeBlock;
    DWQTextViewChangedBlock textViewDetailBlock;
    DWQChooseChangedBlock isCheck;
    DWQSchoolTime isSchoolTime;
}

@end
@implementation WYCrisisHandlingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _checkView.checkboxDelegate = self;
    [_checkView setImage:[UIImage imageNamed:@"xz_kuang.png"] highlightImage:[UIImage imageNamed:@"gj_dh.png"] imageScale:1];
    _checkView.titleAlignMode = UICheckBoxTitleAlignModeRight;//UICheckBoxTitleAlignModeRight
    _textFile.delegate = self;
    _textView.delegate = self;
    self.YesButton.selected  = YES;
}
-(void)setTitleName:(TitleManagerStyle)style withRightString:(NSString *)string{
    
   self.textFile.font = [UIFont systemFontOfSize:16.0f];
   [self.textFile.placeholder setValue:[UIColor colorWithHexString:@"#999999"] forKey:@"_placeholderLabel.textColor"];
    if (style == NameStyle) {
        self.rightLable.hidden = YES;
        if (string.length > 0) {
            self.textFile.text = string;
        }
        self.titleLable.text = @"姓名";
        self.textFile.placeholder = @"请填写真实姓名";
//        self.textFile.clearButtonMode = UITextFieldViewModeAlways;
        NSLog(@"self.titleLable.text%@",self.titleLable.text);
    }else if (style == AgeStyle){
        self.titleLable.text = @"年龄";
        self.rightLable.hidden = YES;
        if (string.length > 0) {
            self.textFile.text = string;
        }
        NSLog(@"self.titleLable.text%@",self.titleLable.text);
        self.textFile.placeholder = @"请填写真实年龄";
        self.textFile.keyboardType = UIKeyboardTypeNumberPad;

    }else if (style == TelStyle){
        self.rightLable.hidden = YES;
        if (string.length > 0) {
            self.textFile.text = string;
        }
        self.titleLable.text = @"联系电话";
        NSLog(@"self.titleLable.text%@",self.titleLable.text);
        self.textFile.placeholder = @"请填写联系电话";
        self.textFile.keyboardType = UIKeyboardTypeNumberPad;

    }else if (style == TimeStyle){
        self.titleLable.text = @"来美时间";
        self.rightLable.hidden = NO;
        self.textFile.hidden = YES;
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    }else{
        self.rightLable.hidden = NO;
        self.titleLable.text = @"在读学校";
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
}
-(void)setSectionTwoTitleName:(TitleManagerStyle1)style{
    if (style == SchoolExpulsionStyle) {
        self.titleLableSectionTwo.text = @"学校开除";
        NSLog(@"self.titleLableSectionTwo.text%@",self.titleLableSectionTwo.text);

    }else if (style == PhysicalDiseaseStyle){
        self.titleLableSectionTwo.text = @"身体疾病";
        NSLog(@"self.titleLableSectionTwo.text%@",self.titleLableSectionTwo.text);

    }else if (style == PsychologicalCounselingStyle){
        self.titleLableSectionTwo.text = @"心理疏导";
        NSLog(@"self.titleLableSectionTwo.text%@",self.titleLableSectionTwo.text);

    }else{
        self.titleLableSectionTwo.text = @"法律咨询";
        NSLog(@"self.titleLableSectionTwo.text%@",self.titleLableSectionTwo.text);

    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textFiledChangeBlock) {
        textFiledChangeBlock(textField.text);
    }
    
}
- (IBAction)chooseSchoolTime:(UIButton*)button {
    if (isSchoolTime) {
        isSchoolTime(button.titleLabel.text);
    }
}
-(void)chooseSchooleTime:(DWQSchoolTime)block{
    isSchoolTime = block;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textFiledChangeBlock) {
        textFiledChangeBlock(textField.text);
    }
    
}
- (void)nameChangedBlock:(DWQTextFieldChangedBlock)block{
    textFiledChangeBlock = block;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textViewDetailBlock) {
        textViewDetailBlock(textView.text);
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textViewDetailBlock) {
        textViewDetailBlock(textView.text);
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textViewDetailBlock) {
        textViewDetailBlock(textView.text);
    }
}
- (void)setDetaildBlock:(DWQTextViewChangedBlock)block{
    textViewDetailBlock = block;
    
}
#pragma mark UICheckBox delegate
- (void)didFinishedCheckAction:(id)sender{
    if (isCheck) {
        isCheck(((UICheckBox*)sender).isChecked);
    }
}
- (void)chooseCheckWithBlock:(DWQChooseChangedBlock)block{
    isCheck = block;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)chooseNO:(id)sender {
    self.NButton.selected = YES;
    self.YesButton.selected  = NO;
    if (isCheck) {
        isCheck(NO);
    }
}
- (IBAction)chooseYES:(id)sender {
    self.NButton.selected = NO;
    self.YesButton.selected  = YES;
    if (isCheck) {
        isCheck(YES);
    }
}

@end
