//
//  MBBTripServiceTableViewCell.m
//  FEUILib
//
//  Created by qiu on 3/1/18.
//
//

#import "MBBTripServiceTableViewCell.h"

#define kRight 10
@interface MBBTripServiceTableViewCell ()
{
    DWQChooseGenderChangedBlock numberWithBlock;
    
    DWQChooseGenderBlock isCheck;

}
@end

@implementation MBBTripServiceTableViewCell

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
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    _titleLab.textColor = [UIColor blackColor];
    
    _checkButton = [[UICheckBox alloc] initWithFrame:CGRectMake(0, 0, 30, 30) title:nil titleAlignMode:UICheckBoxTitleAlignModeRight];
    _checkButton.checkboxDelegate = self;
   [_checkButton setImage:[UIImage imageNamed:@"xz_kuang.png"] highlightImage:[UIImage imageNamed:@"gj_dh.png"] imageScale:1];
    _checkButton.selected = YES;
    [self.contentView addSubview:_checkButton];
    [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).with.offset(-kRight-5);
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(26);
    }];
    
    _manButton = [[UIButton alloc] init];
    [self.contentView addSubview:_manButton];
    [_manButton mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(self.contentView.mas_centerY);
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(-40);
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(26);

    }];
    
    [_manButton setTitle:@"男" forState:UIControlStateNormal];
    [_manButton.titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightThin]];
    [_manButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_manButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [_manButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    [_manButton addTarget:self action:@selector(manButtonSelect:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    _womenButton = [[UIButton alloc] init];
    [self.contentView addSubview:_womenButton];
    [_womenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(40);
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(26);
        
    }];
    [_womenButton.titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightThin]];
    [_womenButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [_womenButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    [_womenButton setTitle:@"女" forState:UIControlStateNormal];
    [_womenButton addTarget:self action:@selector(womenButtonSelect:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];

    [_womenButton setBackgroundImage:[UIImage imageNamed:@"gj_mr"] forState:UIControlStateNormal];
    [_womenButton setBackgroundImage:[UIImage imageNamed:@"gj_xz"] forState:UIControlStateSelected];
    [_manButton setBackgroundImage:[UIImage imageNamed:@"gj_mr"] forState:UIControlStateNormal];
    [_manButton setBackgroundImage:[UIImage imageNamed:@"gj_xz"] forState:UIControlStateSelected];
    [self setButtonAlpha:NO];

}
- (void)womenButtonSelect:(id)sender {
    self.manButton.selected = NO;
    self.womenButton.selected = YES;
    if (isCheck) {
        isCheck(@"3");
    }
}
- (void)manButtonSelect:(id)sender {
    self.manButton.selected = YES;
    self.womenButton.selected = NO;
    if (isCheck) {
        isCheck(@"2");
    }
}
-(void)setButtonAlpha:(BOOL)isuse{
    _manButton.userInteractionEnabled =isuse;
    _womenButton.userInteractionEnabled =isuse;
    _womenButton.alpha = isuse ? 1 : 0.3;
    _manButton.alpha = isuse ? 1 : 0.3;
    if (isuse) {
        self.womenButton.selected = YES;
    }
}
- (void)chooseGenderBlockWithBlock:(DWQChooseGenderBlock)block{
    isCheck = block;
}
#pragma mark UICheckBox delegate
- (void)didFinishedCheckAction:(id)sender{
    if (numberWithBlock) {
        numberWithBlock(((UICheckBox*)sender).isChecked);
    }
}
- (void)chooseGenderWithBlock:(DWQChooseGenderChangedBlock)block{
    numberWithBlock = block;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
