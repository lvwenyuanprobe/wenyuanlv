//
//  PublishInfoTopView.m
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "PublishInfoTopView.h"
#import "OrderInfoCell.h"
@interface PublishInfoTopView ()
@end

@implementation PublishInfoTopView



- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.cellArray = [NSMutableArray array];
    
    NSArray * titles =[NSArray arrayWithObjects:@"出发地",@"目的地",@"航班号",@"出发时间",@"就读学校", nil];
    
        for (int i = 0; i < titles.count; i ++) {
        
            OrderInfoCell * cell = [[OrderInfoCell alloc]init];
            cell.leftLabel.text = titles[i];
            cell.rightField.placeholder = @"请填写";
            cell.frame = CGRectMake(0, 0 + i *(44), SCREEN_WIDTH, 44);
            if (i == titles.count - 1) {
                cell.line.hidden = YES;
            }
            if (i == 3) {
                cell.rightField.text = @"请选择";
                cell.rightField.userInteractionEnabled = NO;
            }
            cell.tag = 100 + i;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pleaseInputInfo:)];
            cell.userInteractionEnabled = YES;
            self.userInteractionEnabled = YES;
            [cell addGestureRecognizer:tap];
            [self addSubview:cell];
            [self.cellArray addObject:cell];
    }
}

- (void)pleaseInputInfo:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(turnToInputView:)]) {
        [self.delegate turnToInputView:tap.view.tag];
    }    
}
@end
