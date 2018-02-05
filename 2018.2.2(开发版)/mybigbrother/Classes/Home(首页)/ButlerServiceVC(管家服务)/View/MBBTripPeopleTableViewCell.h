//
//  MBBTripPeopleTableViewCell.h
//  FEUILib
//
//  Created by qiu on 3/1/18.
//
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

typedef void(^DWQNumberChangedBlock)(NSInteger number);

typedef void(^DWQTextFieldChangedBlock)(NSString *stringTextField);


@interface MBBTripPeopleTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UILabel * titleLab;

@property (nonatomic, strong) UILabel * rightNumLab;

@property (nonatomic, strong) UIButton * additionButton;

@property (nonatomic, strong) UIButton * subtractionButton;

@property (nonatomic, strong) UITextField *nameTestFiled;

- (void)numberWithBlock:(DWQNumberChangedBlock)block;

- (void)nameChangedBlock:(DWQTextFieldChangedBlock)block;

-(void)setHideConfig:(NSString *)string;

-(void)setHidePeopleConfig:(NSString *)string;

@end
