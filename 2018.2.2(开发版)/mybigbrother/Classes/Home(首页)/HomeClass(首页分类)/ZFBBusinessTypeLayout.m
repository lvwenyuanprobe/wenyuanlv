//
//  ZFBBusinessTypeLayout.m
//  05-商家分类
//
//  Created by LV on 16/8/14.
//  Copyright © 2016年 LV. All rights reserved.
//

#import "ZFBBusinessTypeLayout.h"

@implementation ZFBBusinessTypeLayout

// 准备布局"当collectionVeiw将要显示时就会调用此方法来准备itemSize及行列间距等设置"
- (void)prepareLayout {
#warning mark - 重写此方法注意super
    [super prepareLayout];
    
//    NSLog(@"%@", self.collectionView);
    // 计算一个格子的宽和高
    CGFloat itemW = self.collectionView.bounds.size.width * 0.25;
    CGFloat itemH = self.collectionView.bounds.size.height * 0.5;
    // 设置格子大小
    self.itemSize = CGSizeMake(itemW, itemH);
    
    // 设置最小行间距
    self.minimumLineSpacing = 0;
    // 设置最小列间距
    self.minimumInteritemSpacing = 0;
    
    // 设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    


}
@end
