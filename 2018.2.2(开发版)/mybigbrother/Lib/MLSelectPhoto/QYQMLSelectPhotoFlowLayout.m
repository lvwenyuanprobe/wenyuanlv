//
//  QYQMLSelectPhotoFlowLayout.m
//  qiuyouquan
//
//  Created by sport on 16/7/7.
//  Copyright © 2016年 QYQ-Hawk. All rights reserved.
//

#import "QYQMLSelectPhotoFlowLayout.h"

@implementation QYQMLSelectPhotoFlowLayout

- (instancetype)init{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

/** 重写Subclasses should always call super if they override*/
- (void)prepareLayout{
    [super prepareLayout];
    self.collectionView.contentOffset = self.offsetpoint;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds{
    
    return NO;
    
}
@end
