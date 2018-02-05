//
//  CollectCommentShareView.m
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "CollectCommentShareView.h"

@implementation CollectCommentShareView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    NSArray * images =@[@"bottom_collect",
                        @"bottom_comment",
                        @"bottom_share"];
    for (int i = 0; i < images.count; i ++) {
        
        if(i == 0){
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"" forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"bottom_collect_normal"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"bottom_collect"] forState:UIControlStateSelected];
            btn.frame = CGRectMake((SCREEN_WIDTH - 35*3)/6,
                                     10,
                                     30,
                                     30);
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.selected = NO;
            [self addSubview:btn];
            btn.tag = KBottomFav;
            UIView * line = [[UIView alloc]init];
            line.backgroundColor = BASE_GRAY_CLOR;
            [self addSubview:line];
            line.frame = CGRectMake(CGRectGetMaxX(btn.frame)+ (SCREEN_WIDTH - 35*3)/6,
                                    8,
                                    0.5,
                                    35);
        }else if (i == 1){
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"" forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"bottom_collection"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"bottom_collection_press"] forState:UIControlStateSelected];
            btn.frame = CGRectMake((SCREEN_WIDTH - 35*3)/6 + (40 + (SCREEN_WIDTH - 35*3)/3),
                                   10,
                                   30,
                                   30);
            [btn addTarget:self action:@selector(collectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.selected = NO;
            [self addSubview:btn];
            btn.tag = KBottomCollect;
            UIView * line = [[UIView alloc]init];
            line.backgroundColor = BASE_GRAY_CLOR;
            [self addSubview:line];
            line.frame = CGRectMake(CGRectGetMaxX(btn.frame)+ (SCREEN_WIDTH - 35*3)/6,
                                    8,
                                    0.5,
                                    35);
        }
        else{
            UIImageView * image = [[UIImageView alloc]init];
            image.frame = CGRectMake((SCREEN_WIDTH - 35*3)/6 + i * (45 + (SCREEN_WIDTH - 35*3)/3) ,
                                     10,
                                     30,
                                     30);
            image.tag = i;
            image.image = [UIImage imageNamed:images[i]];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageOperation:)];
            image.userInteractionEnabled = YES;
            self.userInteractionEnabled = YES;
            [image addGestureRecognizer:tap];
            [self addSubview:image];
            
            UIView * line = [[UIView alloc]init];
            line.backgroundColor = BASE_GRAY_CLOR;
            [self addSubview:line];
            line.frame = CGRectMake(CGRectGetMaxX(image.frame)+ (SCREEN_WIDTH - 35*3)/6,
                                    8,
                                    0.5,
                                    35);
        }


    }
}
- (void)buttonClicked:(UIButton *)button{
    
    button.selected = !button.selected;
    if (button.selected == YES) {
        
        if ([self.delegate respondsToSelector:@selector(bottomViewOperation:)]) {
            [self.delegate bottomViewOperation:button.tag];
        }
        [MBProgressHUD showSuccess:@"已赞" toView:self.superview];
    }else{
        [MBProgressHUD showSuccess:@"取消赞" toView:self.superview];
    }
}
- (void)collectButtonClicked:(UIButton *)button{
    
    button.selected = !button.selected;
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];

    if (button.selected == YES) {
        if ([self.delegate respondsToSelector:@selector(bottomViewOperation:)]) {
            [self.delegate bottomViewOperation:button.tag];
        }
        if (!model.token) {
            return;
        }
        [MBProgressHUD showSuccess:@"已收藏" toView:self.superview];
    }else{
        if (!model.token) {
            return;
        }
        [MBProgressHUD showSuccess:@"取消收藏" toView:self.superview];
    }
}

- (void)tapImageOperation:(UITapGestureRecognizer *)tap{
    
    UIImageView * image = (UIImageView *)tap.view;
    
    if ([self.delegate respondsToSelector:@selector(bottomViewOperation:)]) {
        [self.delegate bottomViewOperation:image.tag];
    }
}

@end
