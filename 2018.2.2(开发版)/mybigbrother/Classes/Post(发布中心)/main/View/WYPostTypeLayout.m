//
//  WYPostTypeLayout.m
//  mybigbrother
//
//  Created by Loren on 2018/1/23.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYPostTypeLayout.h"

@implementation WYPostTypeLayout
// 准备布局"当collectionVeiw将要显示时就会调用此方法来准备itemSize及行列间距等设置"
- (void)prepareLayout {
    
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
