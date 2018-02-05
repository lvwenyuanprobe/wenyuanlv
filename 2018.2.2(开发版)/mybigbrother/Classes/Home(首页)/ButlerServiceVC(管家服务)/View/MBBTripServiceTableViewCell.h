//
//  MBBTripServiceTableViewCell.h
//  FEUILib
//
//  Created by qiu on 3/1/18.
//
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UICheckBox.h"

typedef void(^DWQChooseGenderChangedBlock)(BOOL isCheck);

typedef void(^DWQChooseGenderBlock)(NSString *isCheckString);

@interface MBBTripServiceTableViewCell : UITableViewCell<UICheckBoxDelegate>

@property (nonatomic, strong) UILabel * titleLab;

@property (nonatomic, strong) UIButton * manButton;

@property (nonatomic, strong) UIButton * womenButton;

@property (nonatomic, strong) UICheckBox * checkButton;

-(void)setButtonAlpha:(BOOL)isuse;

- (void)chooseGenderWithBlock:(DWQChooseGenderChangedBlock)block;

- (void)chooseGenderBlockWithBlock:(DWQChooseGenderBlock)block;

@end
