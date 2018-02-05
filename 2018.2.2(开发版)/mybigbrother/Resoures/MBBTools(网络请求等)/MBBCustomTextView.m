//
//  MBBCustomTextView.m
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBCustomTextView.h"

@interface MBBCustomTextView()


@end

@implementation MBBCustomTextView

- (id)initWithFrame:(CGRect)frame andPlaceholder:(NSString *)placeholder andPlaceholderColor:(UIColor *)color{
    
    if (self = [super initWithFrame:frame]) {
        UILabel * lab = [[UILabel alloc] init];
        lab.font = MBBFONT(17);
        lab.text = placeholder;
        lab.textColor = color;
        lab.numberOfLines  = 2;
        [lab sizeToFit];        
        _placeholderLabel = lab;
        self.font = MBBFONT(17);
        self.textColor = FONT_DARK;
        self.scrollEnabled = NO;
        [self addSubview:_placeholderLabel];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
//            make.centerY.equalTo(self);
            make.right.mas_equalTo(-5);
            make.top.mas_equalTo(15);
        }];
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeByUse) name:UITextViewTextDidChangeNotification object:self];
        return self;
    }
    return nil;
}

- (id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder holderColor:(UIColor *)color{
    
    if (self = [super initWithFrame:frame]) {
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 10, 20)];
        lab.font = MBBFONT(10);
        lab.text = placeholder;
        lab.textColor = color;
        _placeholderLabel = lab;
        self.font = MBBFONT(12);
        self.textColor = FONT_DARK;
        self.scrollEnabled = NO;
        [self addSubview:_placeholderLabel];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeByUse) name:UITextViewTextDidChangeNotification object:self];
        return self;
    }
    return nil;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidChangeByUse{
    if (self.hasText) {
        _placeholderLabel.hidden = YES;
    }
    else{
        _placeholderLabel.hidden = NO;
    }
}


@end
