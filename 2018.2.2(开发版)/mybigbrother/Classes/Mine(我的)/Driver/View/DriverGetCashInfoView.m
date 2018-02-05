//
//  DriverGetCashInfoView.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "DriverGetCashInfoView.h"
#import "GetCashCellView.h"

@implementation DriverGetCashInfoView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    self.backgroundColor = BASE_VC_COLOR;
    NSArray * array = @[@{
                          @"left":@"取款人",
                          @"right":@"请输入取款人姓名"
                          },
                        @{
                            @"left":@"提现方式",
                            @"right":@"请选择提现方式>"
                            },
                        @{
                            @"left":@"账号信息",
                            @"right":@"请输入账号"
                            },
                        ];
    for (int i = 0 ; i < array.count ; i ++) {
        GetCashCellView * view = [[GetCashCellView alloc]init];
        view.frame = CGRectMake(0, (0 + i) * (44 + 5), SCREEN_WIDTH, 44);
        view.leftLabel.text = array[i][@"left"];
        view.rightLabel.text = array[i][@"right"];
        view.tag = i + 100;
        [self addSubview:view];
        [view addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)buttonClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(completeInfo:)]) {
        [self.delegate completeInfo:button.tag];
    }

}
@end
