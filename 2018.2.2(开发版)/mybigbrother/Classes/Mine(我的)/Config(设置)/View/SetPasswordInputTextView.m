//
//  SetPasswordInputTextView.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "SetPasswordInputTextView.h"

@interface SetPasswordInputTextView ()
    

@end

@implementation SetPasswordInputTextView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
    
- (void)setUpUI{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _passwordText = [[UITextField alloc]init];
    [_passwordText setFont:MBBFONT(15)];
//    _line = [[UIView alloc]init];
//    _line.backgroundColor = BASE_CELL_LINE_COLOR;
    NSArray * arr = @[_passwordText];
    
    _passwordText.keyboardType = UIKeyboardTypeASCIICapable;
    
    [self sd_addSubviews:arr];
    
    
    _passwordText.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH/2+50)
    .heightIs(45);
    
    
}
    
@end
