//
//  MBBServiceHeadView.m
//  mybigbrother
//
//  Created by qiu on 4/1/18.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBServiceHeadView.h"

@implementation MBBServiceHeadView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatAnimaionViewWithMenus];
        
    }
    return self;
}
- (void)creatAnimaionViewWithMenus{
    NSArray *menuArray = [NSArray arrayWithObjects:@"提交需求",@"等待联系",@"安排行程",@"确认付款",@"轻松出行", nil];
   

    CGFloat     margin   = ([UIScreen mainScreen].bounds.size.width-8)/5.0;
    CGFloat     appviewx  = -2;

    for (NSInteger i=0; i<menuArray.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
            [button setFrame:CGRectMake(8, 15, margin, 30)];

            [button setTitleColor:[UIColor whiteColor ]forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"zt_ys"] forState:UIControlStateNormal];
            appviewx = margin + appviewx+8;

        }else{
            [button setFrame:CGRectMake(appviewx, 15, margin, 30)];

            [button setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
            
        [button setBackgroundImage:[UIImage imageNamed:@"zt_ws"] forState:UIControlStateNormal];
            appviewx = margin + appviewx-2;
}
        [button setTitle:menuArray[i] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:12];

        [button addTarget:self action:@selector(itemBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i];
        [self addSubview:button];
    }

}
- (void)itemBtnClicked:(UIButton *)sender{


}
@end
