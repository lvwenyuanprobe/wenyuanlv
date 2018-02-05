//
//  MBBTripTimeTableViewCell.h
//  FEUILib
//
//  Created by qiu on 3/1/18.
//
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "MBBTripModel.h"
typedef void(^DWQChooseChangedBlock)(NSString *time);
typedef void(^DWQTextFieldChangedBlock)(NSString *stringTextField);

@interface MBBTripTimeTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UILabel * titleLab;

@property (nonatomic, strong) UIButton * rightButton;

@property (nonatomic, strong) UITextField *  telTestFiled;

- (void)chooseTimeWithBlock:(DWQChooseChangedBlock)block;
- (void)nameChangedBlock:(DWQTextFieldChangedBlock)block;

-(void)setConfigModel:(MBBTripModel *)model;
@end
