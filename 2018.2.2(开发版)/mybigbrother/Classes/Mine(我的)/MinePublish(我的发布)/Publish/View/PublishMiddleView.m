//
//  PublishMiddleView.m
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "PublishMiddleView.h"

@interface PublishMiddleView ()<UITextViewDelegate>
/** 标签*/
@property (nonatomic, strong) NSMutableArray *  buttonArray;

@end

@implementation PublishMiddleView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    self.buttonArray = [NSMutableArray array];
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"约伴简介";
    titleLabel.textColor = FONT_DARK;
    titleLabel.font = MBBFONT(15);
    
    titleLabel.frame = CGRectMake(10, 10, SCREEN_WIDTH, 30);
    [self addSubview:titleLabel];

    
   MBBCustomTextView * explain = [[MBBCustomTextView alloc] initWithFrame:CGRectMake(20,
                                                                           40,
                                                                           SCREEN_WIDTH - 40,
                                                                           120)
                                                 andPlaceholder:@"可以写下你的自我介绍,约伴要求"
                                            andPlaceholderColor:FONT_LIGHT];
    explain.textColor = BASE_COLOR;
    explain.font = [UIFont systemFontOfSize:17];
    explain.backgroundColor = BASE_VC_COLOR;
    explain.keyboardType = UIKeyboardTypeDefault;
    explain.delegate = self;
    
    explain.frame = CGRectMake(10, CGRectGetMaxY(titleLabel.frame), SCREEN_WIDTH -20, 70);
    _explain = explain;
    [self addSubview:explain];
    
    
    UIView  * line = [[UIView alloc]init];
    line.backgroundColor = BASE_VC_COLOR;
    
    line.frame = CGRectMake(0, CGRectGetMaxY(explain.frame)+20, SCREEN_WIDTH, 5);
    [self addSubview:line];
    
    UILabel * sex = [[UILabel alloc]init];
    sex.text = @"添加标签(限选一个)";
    sex.textColor = FONT_DARK;
    sex.font = MBBFONT(15);
    
    sex.frame = CGRectMake(10, CGRectGetMaxY(line.frame)+10, SCREEN_WIDTH, 30);
    [self addSubview:sex];
    
    NSArray * sexArr  = @[@"仅限女生",@"仅限男生",@"不限性别"];
    
    for (int i = 0; i < sexArr.count ; i ++ ) {
        UIButton *sexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sexBtn.frame = CGRectMake(10 + i * (80 + 10), CGRectGetMaxY(sex.frame), 80, 20);
        sexBtn.tag = i + 100;
        sexBtn.clipsToBounds = YES;
        sexBtn.layer.cornerRadius = 3;
        sexBtn.layer.borderColor = FONT_LIGHT.CGColor;
        sexBtn.layer.borderWidth = 0.5;
        [sexBtn setTitle:sexArr[i] forState:UIControlStateNormal];
        [sexBtn setTitleColor:FONT_LIGHT forState:UIControlStateNormal];
        [sexBtn setTitleColor:FONT_DARK forState:UIControlStateSelected];

        if(i==0){
            sexBtn.selected = YES;
        }
        [self addSubview:sexBtn];
        [sexBtn.titleLabel setFont:MBBFONT(12)];
        [sexBtn addTarget:self action:@selector(sexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:sexBtn];
    }
}

- (void)sexBtnClick:(UIButton * )button{
    if (button.selected == YES) {
        return;
    }
    for (UIButton * btn  in self.buttonArray) {
        btn.selected = NO;
    }
    button.selected = YES;
    if ([self.delegate respondsToSelector:@selector(chooseSexSign:)]) {
        [self.delegate chooseSexSign:button.tag];
    }

    
}
@end
