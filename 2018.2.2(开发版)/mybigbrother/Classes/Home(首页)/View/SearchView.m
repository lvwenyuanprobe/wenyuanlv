//
//  SearchView.m
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    UIImageView * searchImage = [[UIImageView alloc]init];
    searchImage.image = [UIImage imageNamed:@"home_search"];
    [self addSubview:searchImage];
    
    
    
    UILabel * title = [[UILabel alloc]init];
    title.text = @"大师兄";
    title.textColor = MBBHEXCOLOR_ALPHA(0x999999, 1.0);
    title.font = MBBFONT(15);
    [self addSubview:title];
    
    searchImage.sd_layout
    .topSpaceToView(self,8)
    .leftSpaceToView(self,15)
    .widthIs(14)
    .heightIs(14);
    
    title.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(searchImage,10)
    .widthIs(self.width - 25)
    .heightIs(30);
}

@end
