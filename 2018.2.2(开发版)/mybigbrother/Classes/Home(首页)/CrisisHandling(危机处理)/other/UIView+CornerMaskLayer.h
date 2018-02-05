//
//  UIView+CornerMaskLayer.h
//
//  Created by tony on 15/9/18.
//  圆角边框xib 与 圆角图片方法

#import <UIKit/UIKit.h>

//IB_DESIGNABLE
@interface UIView (CornerMaskLayer)

/** 返回圆角图片 */
- (void)addCornerMaskLayerWithRadius:(CGFloat)radius;

@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;
@property (nonatomic, strong)IBInspectable UIColor *borderColor;
@property (nonatomic, strong)IBInspectable UIColor *shadowColor;
@property (nonatomic, assign)IBInspectable CGFloat shadowOpacity;
@end
