//
//  WYCrisisHandlingTableViewCell.h
//  mybigbrother
//
//  Created by qiu on 21/1/18.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICheckBox.h"

typedef NS_ENUM(NSInteger,TitleManagerStyle)
{
    NameStyle      = 0,
    AgeStyle       = 1,
    TelStyle       = 2,
    TimeStyle      = 3,
    SchoolStyle    = 4,
};
typedef NS_ENUM(NSInteger,TitleManagerStyle1)
{
    SchoolExpulsionStyle = 0,
    PhysicalDiseaseStyle = 1,
    PsychologicalCounselingStyle = 2,
    LegalAdviceStyle = 3,
};
typedef void(^DWQTextFieldChangedBlock)(NSString *stringTextField);

typedef void(^DWQTextViewChangedBlock)(NSString *stringTextView);

typedef void(^DWQChooseChangedBlock)(BOOL isCheck);

typedef void(^DWQSchoolTime)(NSString *stringTime);

@interface WYCrisisHandlingTableViewCell : UITableViewCell<UITextViewDelegate,UICheckBoxDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *titleLableSectionTwo;

@property (weak, nonatomic) IBOutlet UITextField *textFile;

@property (weak, nonatomic) IBOutlet UIButton *rightLable;


@property (weak, nonatomic) IBOutlet UIButton *NButton;

@property (weak, nonatomic) IBOutlet UIButton *YesButton;

@property (weak, nonatomic) IBOutlet UICheckBox *checkView;

@property (weak, nonatomic) IBOutlet UITextView *textView;

-(void)setTitleName:(TitleManagerStyle)style withRightString:(NSString *)string;

-(void)setSectionTwoTitleName:(TitleManagerStyle1)style;

- (void)nameChangedBlock:(DWQTextFieldChangedBlock)block;

- (void)setDetaildBlock:(DWQTextViewChangedBlock)block;

- (void)chooseCheckWithBlock:(DWQChooseChangedBlock)block;

-(void)chooseSchooleTime:(DWQSchoolTime)block;

@end
