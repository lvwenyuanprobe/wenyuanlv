//
//  MyCollectionViewCell.m
//  mybigbrother
//
//  Created by apple on 2018/1/7.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "Masonry.h"

NSString *const kMyCollectionViewCellID = @"kMyCollectionViewCellID";
@interface MyCollectionViewCell()

@end

@implementation MyCollectionViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    _posterView.image = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    if (_posterView) {
        return;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _posterView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.contentView);
            make.left.mas_equalTo(15);
        }];
        
        imageView;
    });
}

#pragma mark - Public Method

- (void)configureCellWithPostURL:(NSString *)posterURL {
    _posterView.image = [UIImage imageNamed:posterURL];
}


@end
