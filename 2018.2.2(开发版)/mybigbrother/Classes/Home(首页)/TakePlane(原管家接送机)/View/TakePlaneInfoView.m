//
//  TakePlaneInfoView.m
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "TakePlaneInfoView.h"
#import "TakePlaneCellView.h"
#import "TakePlaneInfoCountView.h"

@implementation TakePlaneInfoView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    UIImageView * titleImage = [[UIImageView alloc]init];
    titleImage.image = [UIImage imageNamed:@"home_take_banner"];
    titleImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    
    [self addSubview:titleImage];
    
    NSArray * titles = @[@"接机机场",
                         @"目的地学校",
                         @"人数",
                         @"出发时间",
                         @"到达时间",
                         @"航班号",
                         @"车型选择"
                         ];
    NSArray * images = @[@"takeplane_plane",
                         @"takeplane_school",
                         @"takeplane_count",
                         @"takeplane_time",
                         @"takeplane_time",
                         @"takeplane_flight",
                         @"takeplane_car"
                         ];
    
    self.cells = [NSMutableArray array];
    for (int i = 0 ; i < titles.count; i ++ ) {
        if (i == 2) {
           
            TakePlaneInfoCountView * cell = [[TakePlaneInfoCountView alloc]initWithFrame:CGRectMake(0 ,
                                                                                          100 + 44 * i ,
                                                                                          SCREEN_WIDTH,
                                                                                          44)];
            [self addSubview:cell];
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellTap:)];
            cell.userInteractionEnabled = YES;
            self.userInteractionEnabled = YES;
            [cell addGestureRecognizer:tap];
            /** 注意*/
            cell.tag = i + 100;
            [self.cells addObject:cell];

        }else{
            
            TakePlaneCellView * cell = [[TakePlaneCellView alloc]initWithFrame:CGRectMake(0 ,
                                                                                          100 + 44 * i ,
                                                                                          SCREEN_WIDTH,
                                                                                          44)];
            cell.titleLabel.text = titles[i];
            cell.leftImage.image = [UIImage imageNamed:images[i]];
            [self addSubview:cell];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellTap:)];
            cell.userInteractionEnabled = YES;
            self.userInteractionEnabled = YES;
            [cell addGestureRecognizer:tap];
            /** 注意*/
            cell.tag = i + 100;
            [self.cells addObject:cell];
            if (i == 0) {//机场
                cell.rightArrow.hidden = NO;
                cell.rightLabel.placeholder = @"请选择";
                cell.rightLabel.userInteractionEnabled = NO;
            }
            
            if (i == 3) {//出发时间
                cell.rightArrow.hidden = NO;
                cell.rightLabel.placeholder = @"请选择";
                cell.rightLabel.userInteractionEnabled = NO;
            }
            if (i == 4) {//到达时间
                cell.rightArrow.hidden = NO;
                cell.rightLabel.placeholder = @"请选择";
                cell.rightLabel.userInteractionEnabled = NO;
            }
            if (i == 5) {//航班号
                cell.rightArrow.hidden = YES;
                cell.rightLabel.placeholder = @"请填写";
            }
            if (i == 6) {//车型
                cell.rightArrow.hidden = NO;
                cell.rightLabel.placeholder = @"";
                cell.rightLabel.userInteractionEnabled = NO;
            }

        }
    }
}
- (void)cellTap:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(TakePlaneInfoViewChooseInfo:)]) {
        [self.delegate TakePlaneInfoViewChooseInfo:tap.view.tag];
    }

    
}
@end
