//
//  DifferentTacticsHeader.m
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "DifferentTacticsHeader.h"
@interface DifferentTacticsHeader()
@property (nonatomic, strong) UIView * sliderView;
@end


@implementation DifferentTacticsHeader

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
    self.contentSize = CGSizeMake(SCREEN_WIDTH, 61);
    //可变
    NSArray * buttonArr = [NSArray array];
    buttonArr = @[@"新生攻略",@"师兄分享"];
    
    CGFloat buttonWidth = SCREEN_WIDTH / 2;
    
    _buttonArray = [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i < buttonArr.count ; i ++){
        UIButton * titleButton = [MyControl createButtonFrame:CGRectMake(buttonWidth * i , 0, buttonWidth, 61)
                                                        Title:buttonArr[i]
                                                  BgImageName:nil
                                                    ImageName:nil
                                                       Method:@selector(buttonClicked:)
                                                       target:self];
        titleButton.tag = 1000 + i;
        [titleButton setBackgroundColor:[UIColor whiteColor]];
        [titleButton setTitleColor:BASE_COLOR forState:UIControlStateSelected];
        [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        titleButton.titleLabel.font = MBBFONT(16);
        titleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        if (i == 0) {
            titleButton.selected = YES;
        }
        [self addSubview:titleButton];
        [_buttonArray addObject:titleButton];
        
    }
    //中线
    UIView * middleline = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2,
                                                                  10,
                                                                  0.5,
                                                                  41)];
    middleline.backgroundColor = BASE_CELL_LINE_COLOR;
    [self addSubview:middleline];

    
    //底色线
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                60,
                                                                SCREEN_WIDTH,
                                                                1.5)];
    lineView.backgroundColor = BASE_CELL_LINE_COLOR;
    [self addSubview:lineView];
    
    //下滑线
    _sliderView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                          60,
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
    CGFloat buttonWidth = SCREEN_WIDTH / 2;
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
    
    CGFloat buttonWidth = SCREEN_WIDTH / 2;
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
