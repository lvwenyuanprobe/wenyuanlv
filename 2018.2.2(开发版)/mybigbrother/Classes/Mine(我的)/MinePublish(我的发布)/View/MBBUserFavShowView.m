//
//  MBBUserFavShowView.m
//  mybigbrother
//
//  Created by SN on 2017/6/12.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBUserFavShowView.h"

@interface MBBUserFavShowView()

/** 点赞人数组*/
@property(nonatomic,strong)NSArray * FavUsers;

/** 标记按钮*/
@property(nonatomic,strong)UIButton * recordBtn;

/** 预支数组*/
@property(nonatomic,strong)NSMutableArray  *  buttonsArray;

/** 处理数组*/
@property(nonatomic,strong) NSMutableArray * handleArray;

@end

@implementation MBBUserFavShowView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
        
    }
    
    return self;
}
- (void)setup{
    
    NSMutableArray *temp = [NSMutableArray new];
    /** 最多12个*/
    for (int i = 0; i < 13; i++) {
        UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:tagBtn];
        
        tagBtn.clipsToBounds = YES;
        tagBtn.titleLabel.font =MBBFONT(12) ;
        [tagBtn setTitleColor:MBBHEXCOLOR(0xffa995) forState:UIControlStateNormal];
        [tagBtn setTitleColor:MBBHEXCOLOR(0xffa995) forState:UIControlStateSelected];
        [temp addObject:tagBtn];
    }
    /** 预制图片数组*/
    self.buttonsArray = [temp copy];
}

- (void)setLabelArray:(NSMutableArray *)labelArray{
    _recordBtn = nil;
    
    _labelArray = labelArray;
    
    UIImageView * favImageView = [[UIImageView alloc]init];
    favImageView.image = [UIImage imageNamed:@"fav_list"];
    favImageView.frame = CGRectMake(10,
                                    10,
                                    20,
                                    20);
    [self addSubview:favImageView];
    
    /** 多于12个处理*/
    if (_labelArray.count > 12) {
        NSArray * tempArray = [_labelArray subarrayWithRange:NSMakeRange(0, 12)];
        _labelArray = [NSMutableArray arrayWithArray:tempArray];
    }
    
    NSMutableArray * changeArr = [NSMutableArray array];
    for (MBBUserFavModel * model in _labelArray) {
        NSMutableDictionary * temp = [NSMutableDictionary dictionary];
        temp[@"u_nickname"] = [NSString stringWithFormat:@"%@、",model.u_nickname];
        [changeArr addObject:temp];
    }
    
    _handleArray = changeArr;
    [_handleArray addObject:@{@"u_nickname":@"等觉得很赞。"}];
    
    /** 按钮展示处理*/
    for (long i = _handleArray.count; i < self.buttonsArray.count; i++) {
        UIButton * button = [self.buttonsArray objectAtIndex:i];
        button.hidden = YES;
    }
    //没有赞
    if (_handleArray.count == 1) {
        self.height = 0;
        self.fixedHeight = @(10);
        favImageView.hidden = YES;
        return;
    }
    
    __block CGFloat selectBtnY = 15;
    [_handleArray enumerateObjectsUsingBlock:^(NSDictionary *  dic , NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat maxItemWidth = self.frame.size.width - 50;
        CGSize buttonSize = [self sizeWithFont:MBBFONT(12)
                                       maxSize:CGSizeMake(maxItemWidth, MAXFLOAT)
                                          with:dic[@"u_nickname"]];
        UIButton * tagBtn = self.buttonsArray[idx];
        tagBtn.tag = idx;
        if (_recordBtn) {
            if ((CGRectGetMaxX(_recordBtn.frame) + buttonSize.width) > maxItemWidth) {
                selectBtnY = selectBtnY + 12 +  5;
                tagBtn.frame = CGRectMake(CGRectGetMaxX(favImageView.frame) + 5,
                                          selectBtnY,
                                          buttonSize.width + 5 ,
                                          12);
            }else{
                tagBtn.frame = CGRectMake(CGRectGetMaxX(_recordBtn.frame),
                                          selectBtnY,
                                          buttonSize.width + 5,
                                          12);
            }
        }else{
            
            tagBtn.frame = CGRectMake(CGRectGetMaxX(favImageView.frame) + 5,
                                      selectBtnY,
                                      buttonSize.width + 5,
                                      12);
        }
        [tagBtn setTitle:dic[@"u_nickname"] forState:UIControlStateNormal];
        [tagBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _recordBtn = tagBtn ;
    }];
    
    [self setupAutoHeightWithBottomView:_recordBtn bottomMargin:10];
}
#pragma mark - 点击事件
- (void)buttonClicked:(UIButton *)btn{
    
    /** 等觉得很赞不响应*/
    if (btn.tag == _handleArray.count - 1) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(clickedNicknameWith:)]) {
        [self.delegate clickedNicknameWith:_labelArray[btn.tag]];
    }

    
}
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize with:(NSString *)string{
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    maxSize = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    maxSize = CGSizeMake(maxSize.width, maxSize.height );
    return maxSize;
}


@end
