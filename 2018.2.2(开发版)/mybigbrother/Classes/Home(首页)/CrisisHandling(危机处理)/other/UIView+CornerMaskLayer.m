//
//  UIView+CornerMaskLayer.m
//
//  Created by tony on 15/9/18.
//

#import "UIView+CornerMaskLayer.h"
#import <objc/runtime.h>

@implementation UIView (CornerMaskLayer)

- (void)addCornerMaskLayerWithRadius:(CGFloat)radius
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)].CGPath;
    self.layer.mask = layer;
}

- (CGFloat)cornerRadius
{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue];
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}


- (CGFloat)borderWidth
{
    return [objc_getAssociatedObject(self, @selector(borderWidth)) floatValue];
}
- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}


- (UIColor *)borderColor
{
    return objc_getAssociatedObject(self, @selector(borderColor));
}
- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)shadowColor
{
    return objc_getAssociatedObject(self, @selector(shadowColor));
}
- (void)setShadowColor:(UIColor *)shadowColor
{
    self.layer.shadowColor = shadowColor.CGColor;
}

- (CGFloat)shadowOpacity
{
    return [objc_getAssociatedObject(self, @selector(shadowOpacity)) floatValue];
}
- (void)setShadowOpacity:(CGFloat)shadowOpacity
{
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = shadowOpacity;
}


@end
