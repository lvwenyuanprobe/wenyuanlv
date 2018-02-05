//
//  UICustomLabel.h
//  FeOAClient
//
//  Created by yu weiming on 11-10-5.
//  Copyright 2011年 flyrise. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UICustomLabelDelegate <NSObject>

- (void)afterSetText;
- (void)afterSetFont;

@end

@interface UICustomLabel : UILabel{

}

@property (nonatomic,weak)id<UICustomLabelDelegate> delegate;

@end
