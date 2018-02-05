//
//  HotSearchView.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "HotSearchView.h"
@interface HotSearchView ()

@property (nonatomic, strong) NSMutableArray *   buttonArray;
@end

@implementation HotSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    UIImageView * titleImage = [[UIImageView alloc]init];
    titleImage.image = [UIImage imageNamed:@"search_star"];
    [self addSubview:titleImage];
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"热门搜索";
    titleLabel.textColor = FONT_LIGHT;
    titleLabel.font = MBBFONT(12);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    titleImage.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,SCREEN_WIDTH/2 - 60)
    .widthIs(20)
    .heightIs(20);
    
    titleLabel.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(20);

    NSMutableArray * temp = [NSMutableArray array];
    for (int i = 0 ; i < 20; i ++ ) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:FONT_DARK forState:UIControlStateNormal];
        [btn.titleLabel setFont:MBBFONT(11)];
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 3;
        btn.layer.borderColor = FONT_LIGHT.CGColor;
        btn.layer.borderWidth = 0.5;
        [self addSubview:btn];
        [btn addTarget:self action:@selector(buttonCliecked:) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = YES;
        [temp addObject:btn];
    }
    self.buttonArray = [temp copy];
    
    [self fetchHotwordsFromServer];
}

- (void)buttonCliecked:(UIButton * )button{
    if ([self.delegate respondsToSelector:@selector(hotSearchResultList:)]) {
        [self.delegate hotSearchResultList:button];
    }

}
- (void)fetchHotwordsFromServer{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"indexhotwords";
    [MBProgressHUD showMessage:@"请稍后..." toView:self];
    [MBBNetworkManager userSearchHotWords:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            NSArray * hotwords = [NSArray arrayWithArray:request.responseJSONObject[@"data"]];
            
            [hotwords enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                UIButton * button =  [self.buttonArray objectAtIndex:idx];
                [button setTitle:hotwords[idx][@"f_name"] forState:UIControlStateNormal];
                
                CGFloat btnW = (SCREEN_WIDTH - 80 - 20 *2)/3;
                CGFloat btnH = 25;
                button.tag = idx;
                button.hidden = NO;
                button.frame = CGRectMake(40 + (btnW + 20)*(idx%3),
                                       20 + 20 + (btnH + 10)*(idx/3),
                                       btnW,
                                       btnH);

                if (idx  == 18) {
                    *stop = YES;
                }
            }];
        }else{
        }
        
    }];

    
}
@end
