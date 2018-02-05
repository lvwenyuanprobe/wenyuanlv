//
//  InputTextView.m
//  mybigbrother
//
//  Created by SN on 2017/4/18.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "InputTextView.h"
@interface InputTextView ()<UITextViewDelegate>
@property (nonatomic,weak)UILabel * placeholderLabel;
@end

@implementation InputTextView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    self.backgroundColor = [UIColor whiteColor];
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = BASE_CELL_LINE_COLOR;
    [self addSubview:line];
    line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    
    UITextView * textView = [[UITextView alloc] init];
    textView.delegate    = self;
    textView.textColor   = [UIColor grayColor];
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = MBBFONT(15);
    textView.layer.cornerRadius  = 5;
    textView.layer.masksToBounds = YES;
    textView.layer.borderWidth   = 0.5;
    textView.layer.borderColor   = [MBBHEXCOLOR(0xdddddd) CGColor];
    textView.layoutManager.allowsNonContiguousLayout = NO;
    textView.scrollsToTop = NO;
    [self addSubview:textView];
    self.textView = textView;
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setTitleColor:BASE_YELLOW forState:UIControlStateNormal];
    [sendBtn setTitle:@"确定" forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sendBtn setBackgroundColor:[UIColor whiteColor]];
    sendBtn.layer.cornerRadius  = 5;
    sendBtn.layer.masksToBounds = YES;
    sendBtn.layer.borderWidth   = 0.5;
    sendBtn.layer.borderColor   = [MBBHEXCOLOR(0xdddddd) CGColor];
    [sendBtn addTarget:self action:@selector(makeSureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sendBtn];
    self.sureBtn = sendBtn;
    
    textView.frame = CGRectMake(10, 10, SCREEN_WIDTH - 30 - 60, 35);
    sendBtn.frame = CGRectMake(CGRectGetMaxX(textView.frame)+10, 10, 60, 35);
    

    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(5, 7,self.frame.size.width - 10, 20)];
    lab.textColor = [UIColor grayColor];
    lab.font = MBBFONT(15);
    _placeholderLabel = lab;
    [self.textView addSubview:lab];

}
- (void)makeSureBtnAction{
    [self.textView endEditing:YES];
    if ([self.delegate respondsToSelector:@selector(makeSureInputContentText:)]) {
        [self.delegate makeSureInputContentText:self.textView.text];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
}
@end
