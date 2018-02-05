//
//  DriverStarsView.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "DriverStarsView.h"

@implementation DriverStarsView

- (instancetype)initWithFrame:(CGRect)frame starCount:(NSInteger)count{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self addStartCount:count];
    }
    
    return self;
}
- (void)addStartCount:(NSInteger )count{
    
    for (int i = 0 ; i < 5 ; i ++ ) {
        UIImageView * star = [[UIImageView alloc]init];
        star.image = [UIImage imageNamed:@"comment_redstar"];
        star.frame = CGRectMake(0 + i*(20 + 5),
                                0,
                                20,
                                20);
        if (i < 5 - count) {
            star.hidden = YES;
        }
        [self addSubview:star];
    }
    
}
@end
