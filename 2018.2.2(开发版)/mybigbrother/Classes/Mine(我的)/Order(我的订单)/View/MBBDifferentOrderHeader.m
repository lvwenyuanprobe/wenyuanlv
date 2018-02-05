//
//  MBBDifferentOrderHeader.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBDifferentOrderHeader.h"

@interface MBBDifferentOrderHeader()
@property (nonatomic, strong) UIView * sliderView;
@end

@implementation MBBDifferentOrderHeader
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setupView];
    }
    
    return self;
}
- (void)setupView{
    
    self.bounces = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.backgroundColor  = [UIColor whiteColor];
    self.contentSize = CGSizeMake(SCREEN_WIDTH, 44);
    //可变
    NSArray * buttonArr = [NSArray array];
    buttonArr = @[@"全部",@"待付款",@"进行中",@"待评价"];
    
    CGFloat buttonWidth = SCREEN_WIDTH / 4;
    
    _buttonArray = [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i < buttonArr.count ; i ++){
        UIButton * titleButton = [MyControl createButtonFrame:CGRectMake(buttonWidth * i , 0, buttonWidth, 44)
                                                        Title:buttonArr[i]
                                                  BgImageName:nil
                                                    ImageName:nil
                                                       Method:@selector(buttonClicked:)
                                                       target:self];
        titleButton.tag = 1000 + i;
        [titleButton setBackgroundColor:[UIColor whiteColor]];
        [titleButton setTitleColor:BASE_COLOR forState:UIControlStateSelected];
        [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleButton.titleLabel setFont:MBBFONT(17)];
        titleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        if (i == 0) {
            titleButton.selected = YES;
        }
        [self addSubview:titleButton];
        [_buttonArray addObject:titleButton];
        
    }
    
    //底色线
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                44,
                                                                SCREEN_WIDTH,
                                                                1.5)];
    lineView.backgroundColor = [UIColor colorWithRed:242/255. green:242/255. blue:242/255. alpha:1.0];
    [self addSubview:lineView];
    
    //下滑线
    _sliderView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                          44,
                                                          buttonWidth,
                                                          1.5)];
    _sliderView.backgroundColor = BASE_YELLOW;
    [self addSubview:_sliderView];
}
    
    /** 按钮点击*/
- (void)buttonClicked:(UIButton*)button{
    //防止频繁点击
    if (button.selected == YES) {
        return;
    }
    button.selected = YES;
    for (int i = 0 ;  i < _buttonArray.count ; i ++ ) {
        UIButton * tempButton = _buttonArray[i];
        tempButton.selected = NO;
        if ([tempButton isEqual:button]) {
            tempButton.selected = YES;
        }
    }
    CGFloat buttonWidth = SCREEN_WIDTH / 4;
    [self sliderViewAnimation:CGRectMake(buttonWidth * (button.tag - 1000),
                                         [_sliderView y],
                                         buttonWidth,
                                         [_sliderView height])];
    
    if ([self.showDelegate respondsToSelector:@selector(showDifferentOrderListWithState:)]) {
        
        [self.showDelegate showDifferentOrderListWithState:button.tag - 1000];
    }
    
}
- (void)publicButtonClicked:(NSInteger)buttonTag{
    
    for (int i = 0 ;  i < _buttonArray.count ; i ++ ) {
        UIButton * tempButton = _buttonArray[i];
        tempButton.selected = NO;
        if (tempButton.tag == buttonTag) {
            tempButton.selected = YES;
        }
    }
    
    CGFloat buttonWidth = SCREEN_WIDTH / 4;
    [self sliderViewAnimation:CGRectMake(buttonWidth * (buttonTag - 1000),
                                         [_sliderView y],
                                         buttonWidth,
                                         [_sliderView height])];
    
}
    
    /** 动画*/
- (void)sliderViewAnimation:(CGRect)rect{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _sliderView.frame = rect;
    [UIView commitAnimations];
}


@end
