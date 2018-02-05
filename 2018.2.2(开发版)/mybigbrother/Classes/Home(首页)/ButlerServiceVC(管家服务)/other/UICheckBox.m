//
//  UICheckBox.h
//  FEUILib
//
//  Created by qiu on 3/1/18.
//
//

#import "UICheckBox.h"


@interface UICheckBox(private)

- (void)_initWithDefaultImage;
- (void)_innerInit;
@end

@implementation UICheckBox
@synthesize checkIdString;
@synthesize image = _image;
@synthesize highlightImage = _highlightImage;
@synthesize isChecked;
@synthesize titleLabel = _titleLabel;
@synthesize checkboxDelegate = _checkboxDelegate;

@synthesize titleAlignMode;
- (void)setTitleAlignMode:(UICheckBoxTitleAlignMode)aTitleAlignMode{
    if (titleAlignMode != aTitleAlignMode) {
        titleAlignMode = aTitleAlignMode;
        [self sizeToFit];
    }
}


- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self _innerInit];
    }
    return  self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        [self _innerInit];
    }
	
    return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)aTitle{
    if(self = [self initWithFrame:frame title:aTitle titleAlignMode:UICheckBoxTitleAlignModeRight]){
    
    }
    checkIdString = [[NSString alloc] init ];
    return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)aTitle titleAlignMode:(UICheckBoxTitleAlignMode)aTitleAlignMode{
    if(self = [self initWithFrame:frame]){
        titleAlignMode = aTitleAlignMode;
        _titleLabel.text = aTitle;
    }
    
    return self;
}

- (void)_innerInit{
    _titleSpaceToImage = 5;
    isChecked = NO;
    _imageScale = 1;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self addSubview:_imageView];
    
    _titleLabel = [[UICustomLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _titleLabel.delegate = self;
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleLabel];
    
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
    [self _initWithDefaultImage];
    
}



- (void)_initWithDefaultImage{
    self.image = [UIImage imageNamed:@"checkbox_uncheck.png"];
    self.highlightImage = [UIImage imageNamed:@"checkbox_checked.png"];
    _imageScale = 2;
    [self sizeToFit];
}

- (void)setImage:(UIImage *)aImage highlightImage:(UIImage *)aHighlightImage imageScale:(int)aScale{
    self.image = aImage;
    self.highlightImage = aHighlightImage;
    _imageScale = aScale;
    [self sizeToFit];
}

#pragma mark UICustomLabel delegate methods

- (void)afterSetFont{
    if (_titleLabel.text != nil && [_titleLabel.text length]>0) {
        [self sizeToFit];
    }
    
}

- (void)afterSetText{
    if (_titleLabel.text != nil && [_titleLabel.text length]>0) {
        [self sizeToFit];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)sizeToFit {
	if (_image == nil  || _highlightImage == nil) {
		return;
	}
	
	[_titleLabel sizeToFit];
	float imageWidth = _image.size.width/_imageScale;
	float imageHeight = _image.size.height/_imageScale;
	[self setIsChecked:isChecked];
	
	if (titleAlignMode == UICheckBoxTitleAlignModeLeft) {
		_titleLabel.frame = CGRectMake(0, 0, _titleLabel.frame.size.width, self.frame.size.height);
		
		int initX = _titleLabel.frame.origin.x + _titleLabel.frame.size.width + _titleSpaceToImage;
		float centerX = initX + imageWidth/2;
		float centerY = self.frame.size.height/2;
		_imageView.frame =  CGRectMake(initX, 0, imageWidth, imageHeight);
		_imageView.center = CGPointMake(centerX, centerY);
	}
	else if(titleAlignMode == UICheckBoxTitleAlignModeRight) {
		_imageView.frame =  CGRectMake(0, 0, imageWidth, imageHeight);
		float centerX = imageWidth/2+15;
		float centerY = self.frame.size.height/2;
		_imageView.center = CGPointMake(centerX, centerY);
		
		int initX = _imageView.frame.origin.x + imageWidth + _titleSpaceToImage;
		_titleLabel.frame = CGRectMake(initX, 0, _titleLabel.frame.size.width, self.frame.size.height);
	}
	
	int selfWidth = _titleLabel.frame.size.width + imageWidth + _titleSpaceToImage;
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, selfWidth, self.frame.size.height);
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self setIsChecked:!isChecked];
    if (_checkboxDelegate !=nil && [_checkboxDelegate respondsToSelector:@selector(didFinishedCheckAction:)]) {
        [_checkboxDelegate didFinishedCheckAction:self];
    }
}

- (void)setIsChecked:(BOOL)checked {
	isChecked = checked;
	if (isChecked) {
		_imageView.image = _highlightImage;
	}
	else {
		_imageView.image = _image;
	}
}


 

@end
