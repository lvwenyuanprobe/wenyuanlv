//
//  ChooseCarTopView.m
//  mybigbrother
//
//  Created by SN on 2017/4/11.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ChooseCarTopView.h"
#import "CarModel.h"
#import "SCAdView.h"


@interface ChooseCarTopView()<UIScrollViewDelegate,SCAdViewDelegate>

/** 改变page的只读*/
@property (nonatomic, strong) SCAdView * adView;
/** 车型*/
@property (nonatomic, strong) UILabel * carType;
/** 车名*/
@property (nonatomic, strong) UILabel * carNames;
@end

@implementation ChooseCarTopView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    UILabel * carType = [[UILabel alloc]init];
    carType.textColor = FONT_DARK;
    carType.font = MBBFONT(15);
    carType.textAlignment = NSTextAlignmentCenter;
    [self addSubview:carType];
    
    
    UILabel * carNames = [[UILabel alloc]init];
    carNames.textColor = FONT_LIGHT;
    carNames.font = MBBFONT(15);
    carNames.textAlignment = NSTextAlignmentCenter;
    [self addSubview:carNames];

    carType.sd_layout
    .topSpaceToView(self, 100)
    .leftSpaceToView(self, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(20);
    
    carNames.sd_layout
    .topSpaceToView(carType, 5)
    .leftSpaceToView(self, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(20);
    
    _carType = carType;
    _carNames = carNames;

}
-(void)setCarModels:(NSArray *)carModels{
    _carModels = carModels;
    
    CarModel * model = [carModels firstObject];
    _carType.text = model.car_type;
    _carNames.text = model.car_desc;

    
    SCAdView * adView = [[SCAdView alloc]initWithBuilder:^(SCAdViewBuilder *builder) {
        builder.adArray = carModels;
        builder.viewFrame = CGRectMake(0,
                                       0,
                                       SCREEN_WIDTH,
                                       100);
        builder.adItemSize = CGSizeMake(SCREEN_WIDTH/4, 70);
        builder.itemCellClassName = @"CarCollectionViewCell";
        builder.threeDimensionalScale = 1.4;
        builder.secondaryItemMinAlpha = 0.8;
        builder.minimumLineSpacing = 35;
    }];
    adView.delegate = self;
    adView.backgroundColor = [UIColor whiteColor];
    _adView = adView;
    [self addSubview:adView];
}
#pragma mark - SCAdViewDelegate

- (void)sc_didClickAd:(id)adModel{
    
    
}

- (void)sc_scrollToIndex:(NSInteger)index{
    
    CarModel * model = [_carModels objectAtIndex:index];
    _carType.text = model.car_type;
    _carNames.text = model.car_desc;
    self.presentPageBlock(index);
    
}
@end
