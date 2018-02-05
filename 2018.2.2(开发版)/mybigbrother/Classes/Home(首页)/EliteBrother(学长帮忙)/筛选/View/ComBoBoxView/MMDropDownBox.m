//
//  MMDropDownBox.m
//  MMComboBoxDemo
//
//  WY
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MMDropDownBox.h"
#import "MMComboBoxHeader.h"
@interface MMDropDownBox ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) CAGradientLayer *line;
@end

@implementation MMDropDownBox
- (id)initWithFrame:(CGRect)frame titleName:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        self.title = title;
        self.isSelected = NO;
        self.userInteractionEnabled = YES;
        
        //add recognizer
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapAction:)];
        [self addGestureRecognizer:tap];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        self.titleLabel.text = self.title;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self);
        }];
        
        //add subView
        self.arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pulldown.png"]];
        [self addSubview:self.arrow];
        [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.equalTo(self.titleLabel.mas_right).offset(10);
            make.width.height.mas_equalTo(ArrowSide);
        }];
        
//        UIColor *dark = [UIColor colorWithWhite:0 alpha:1.0];
        UIColor *clear = [UIColor colorWithWhite:0 alpha:0];
        NSArray *colors = @[(id)clear.CGColor,(id)[UIColor colorWithHexString:@"#eae9e9"].CGColor, (id)clear.CGColor];
        NSArray *locations = @[@-1, @1.0, @1.0];
        self.line = [CAGradientLayer layer];
        self.line.colors = colors;
        self.line.locations = locations;
        self.line.startPoint = CGPointMake(0, 0);
        self.line.endPoint = CGPointMake(0, 1);
        self.line.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 , 0, 1.0/Scale, self.height+5);
        [self.layer addSublayer:self.line];

    }
    return self;

}

- (void)updateTitleState:(BOOL)isSelected {
    if (isSelected) {
        self.titleLabel.textColor = [UIColor colorWithHexString:titleSelectedColor];
        self.arrow.image = [UIImage imageNamed:@"pullup"];
    } else{
        self.titleLabel.textColor = [UIColor blackColor];
        self.arrow.image = [UIImage imageNamed:@"pulldown"];
    }
}

- (void)updateTitleContent:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)respondToTapAction:(UITapGestureRecognizer *)gesture {
    if ([self.delegate respondsToSelector:@selector(didTapDropDownBox:atIndex:)]) {
        [self.delegate didTapDropDownBox:self atIndex:self.tag];
    }
}
@end
