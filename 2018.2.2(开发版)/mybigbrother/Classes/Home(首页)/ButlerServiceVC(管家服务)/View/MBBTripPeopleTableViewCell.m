//
//  MBBTripPeopleTableViewCell.m
//  FEUILib
//
//  Created by qiu on 3/1/18.
//
//

#import "MBBTripPeopleTableViewCell.h"

#define kRight 10
@interface MBBTripPeopleTableViewCell ()
{
    DWQNumberChangedBlock numberWithBlock;
    DWQTextFieldChangedBlock textFiledChangeBlock;
}
@end

@implementation MBBTripPeopleTableViewCell

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

    _subtractionButton = [[UIButton alloc] init];
    [_subtractionButton setBackgroundImage:[UIImage imageNamed:@"xz_js"] forState:UIControlStateNormal];
    [self.contentView addSubview:_subtractionButton];
    [_subtractionButton addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_subtractionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);

    }];
    
    _rightNumLab = [[UILabel alloc] init];
    [self.contentView addSubview:_rightNumLab];
    [_rightNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(_subtractionButton.mas_left).with.offset(-5);
        make.width.mas_equalTo(30);
    }];
    _rightNumLab.textAlignment = NSTextAlignmentCenter;
    _rightNumLab.textColor = [UIColor blackColor];

    [_rightNumLab setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightThin]];
    _rightNumLab.text = @"0";

    _additionButton = [[UIButton alloc] init];
    [_additionButton addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_additionButton setBackgroundImage:[UIImage imageNamed:@"xz_zj"] forState:UIControlStateNormal];

        [self.contentView addSubview:_additionButton];
        [_additionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(_rightNumLab.mas_left).with.offset(-5);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(25);

        }];
    
    _nameTestFiled = [[UITextField alloc] init];
    _nameTestFiled.delegate = self;
    _nameTestFiled.placeholder = @"请输入真实姓名";
    _nameTestFiled.textAlignment = NSTextAlignmentRight;
    _nameTestFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.contentView addSubview:_nameTestFiled];
    [_nameTestFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-kRight-15);
        make.left.equalTo(self.contentView.mas_left).with.offset(140);
    }];

}
-(void)setHidePeopleConfig:(NSString *)string{
    self.titleLab.text = string;
    self.nameTestFiled.hidden = YES;
    self.rightNumLab.hidden = NO;
    _subtractionButton.hidden = NO;
    _additionButton.hidden = NO;
    
}
-(void)setHideConfig:(NSString *)string{

    self.titleLab.text = string;
    self.nameTestFiled.hidden = YES;
    self.rightNumLab.hidden = NO;
    _subtractionButton.hidden = NO;
    _additionButton.hidden = NO;
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)addBtnClick:(UIButton*)button {
    
    NSInteger count = [self.rightNumLab.text integerValue];
    count++;
    
    if (numberWithBlock) {
        numberWithBlock(count);
    }
}
- (void)cutBtnClick:(UIButton*)button {
    NSInteger count = [self.rightNumLab.text integerValue];
    count--;
    if(count <= -1){
        return ;
    }
    
    if (numberWithBlock) {
        numberWithBlock(count);
    }
}

- (void)numberWithBlock:(DWQNumberChangedBlock)block {
    numberWithBlock = block;
}
@end
