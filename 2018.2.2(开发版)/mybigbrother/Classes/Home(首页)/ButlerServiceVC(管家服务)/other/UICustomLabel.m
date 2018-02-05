//
//  UICustomLabel.m
//  FeOAClient
//
//  Created by yu weiming on 11-10-5.
//  Copyright 2011年 flyrise. All rights reserved.
//

#import "UICustomLabel.h"


@implementation UICustomLabel

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)setText:(NSString *)text{
    [super setText:text];
    if (delegate != nil) {
        if ([delegate respondsToSelector:@selector(afterSetText)]) {
            [delegate afterSetText];
        }
    }
}


- (void)setFont:(UIFont *)font{
    [super setFont:font];
    if (delegate != nil) {
        if ([delegate respondsToSelector:@selector(afterSetFont)]) {
            [delegate afterSetFont];
        }
    }
}

@end
