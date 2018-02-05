//
//  MBBTripTimeTableViewCell.m
//  FEUILib
//
//  Created by qiu on 3/1/18.
//
//

#import "MBBTripTimeTableViewCell.h"
#define kRight 10

@interface MBBTripTimeTableViewCell ()
{
    DWQChooseChangedBlock chooseTimeBlock;
    DWQTextFieldChangedBlock textFiledChangeBlock;
}
@end
@implementation MBBTripTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUI];
    }
    return self;
}
-(void)setUI{

        _titleLab = [[UILabel alloc] init];
        [_titleLab setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightThin]];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).with.offset(20);
            make.right.equalTo(self.contentView.mas_right).with.offset(-55);
            make.height.mas_equalTo(20);
        }];
    
        _titleLab.textColor = [UIColor blackColor];

        _rightButton = [[UIButton alloc] init];
        [self.contentView addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-kRight-5);
            make.width.mas_equalTo(100);
        }];
    [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightThin]];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];

    _telTestFiled = [[UITextField alloc] init];
    _telTestFiled.placeholder = @"请输入电话号码";
    _telTestFiled.textAlignment = NSTextAlignmentRight;
     _telTestFiled.keyboardType = UIKeyboardTypeNumberPad;
    _telTestFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _telTestFiled.delegate = self;
    [self.contentView addSubview:_telTestFiled];
    [_telTestFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-kRight-15);
        make.left.equalTo(self.contentView.mas_left).with.offset(140);
    }];
}
-(void)hiddenTextFile{
    _telTestFiled.hidden = YES;
    _rightButton.hidden = NO;
    
}
-(void)hiddenRightButton{
    _telTestFiled.hidden = NO;
    _rightButton.hidden = YES;
    
}
-(void)setConfigModel:(MBBTripModel *)model{
    [self hiddenTextFile];
    _titleLab.text = model.destination;
    
    [_rightButton setTitle:model.desString forState:UIControlStateNormal];

    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textFiledChangeBlock) {
        textFiledChangeBlock(textField.text);
    }
    
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

- (void)chooseClick:(UIButton*)button {
    
    if (chooseTimeBlock) {
        chooseTimeBlock(button.titleLabel.text);
    }
}
- (void)chooseTimeWithBlock:(DWQChooseChangedBlock)block{
    
    chooseTimeBlock = block;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
