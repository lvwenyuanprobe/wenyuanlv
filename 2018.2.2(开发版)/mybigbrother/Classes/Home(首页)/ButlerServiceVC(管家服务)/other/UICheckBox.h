//
//  UICheckBox.h
//  FEUILib
//
//  Created by qiu on 3/1/18.
//
//
#import <UIKit/UIKit.h>
#import "UICustomLabel.h"

typedef enum {
	UICheckBoxTitleAlignModeLeft,	//文字在checkbox图标左边
	UICheckBoxTitleAlignModeRight	//文字在checkbox图标右边
}UICheckBoxTitleAlignMode;


@protocol UICheckBoxDelegate <NSObject>

- (void)didFinishedCheckAction:(id)sender;

@end


@interface UICheckBox : UIControl<UICustomLabelDelegate> {
    BOOL	isChecked;
    
	UIImage *_image;
	UIImage *_highlightImage;
	
	UIImageView  *_imageView;
	int _imageScale;
	UICustomLabel *_titleLabel;
	int _titleSpaceToImage; //标题与图标之间的间距
	UICheckBoxTitleAlignMode titleAlignMode;
	
//	id<UICheckBoxDelegate> checkboxDelegate;
}
@property (nonatomic,copy) NSString *checkIdString;
@property (nonatomic,retain)UIImage *image;
@property (nonatomic,retain)UIImage *highlightImage;
@property (nonatomic,assign)id<UICheckBoxDelegate> checkboxDelegate;
@property (nonatomic, assign)BOOL	isChecked;
@property (nonatomic, assign)UICheckBoxTitleAlignMode titleAlignMode;
@property (nonatomic, readonly)UICustomLabel *titleLabel;


//初始化时,指定标题,标题在图标的右边
- (void)setImage:(UIImage *)aImage highlightImage:(UIImage *)aHighlightImage imageScale:(int)aScale;
- (id)initWithFrame:(CGRect)frame title:(NSString *)aTitle;
- (id)initWithFrame:(CGRect)frame title:(NSString *)aTitle titleAlignMode:(UICheckBoxTitleAlignMode)aTitleAlignMode;

@end
