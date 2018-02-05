//
//  RecommendFriendView.m
//  mybigbrother
//
//  Created by SN on 2017/5/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "RecommendFriendView.h"

@implementation RecommendFriendView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setUpUI];
    }
    
    return self;
}
- (void)setUpUI{
    
    
    UIImageView * topImage = [[UIImageView alloc]init];
    topImage.image = [UIImage imageNamed:@"recommend_middle"];
    topImage.frame = CGRectMake(0, 0, SCREEN_WIDTH - 40, 150);
    [self addSubview:topImage];
    
    UIImageView * logoImage =  [[UIImageView alloc]init];
    logoImage.image = [UIImage imageNamed:@"mine_logo"];
    [topImage addSubview:logoImage];
    
    UILabel * logoLabel = [[UILabel alloc]init];
    logoLabel.textAlignment = NSTextAlignmentCenter;
    logoLabel.text = @"我的大师兄";
    logoLabel.textColor = [UIColor whiteColor];
    [topImage addSubview:logoLabel];
    
    
    
    logoImage.sd_layout
    .leftSpaceToView(topImage, (SCREEN_WIDTH -40)/2 - 30)
    .topSpaceToView(topImage, 75 - 30 - 10)
    .widthIs(60)
    .heightIs(60);
    
    logoLabel.sd_layout
    .topSpaceToView(logoImage, 5)
    .leftSpaceToView(topImage, 0)
    .widthIs(SCREEN_WIDTH - 40)
    .heightIs(20);
    

    /** 主*/
    UILabel * mainLabel = [[UILabel alloc]init];
    mainLabel.text = @"    World 大师兄App由思能教育咨询（大连）有限公司面向中国有海外教育，移民，置业，投资需求的客户及其子女进行开发，服务区域覆盖整个美国。\n    World大师兄依托发达的海外校友网络和良好的海外商业关系可以为客户及其子女提供专业的移民律师咨询服务和海外投资咨询服务等其他服务，并为客户提供一对一的专业咨询，帮助客户轻松移居海外并实现全球资产配置。";
    mainLabel.lineBreakMode = NSLineBreakByCharWrapping;
    mainLabel.numberOfLines = 0;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:mainLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    NSRange range = NSMakeRange(0, [mainLabel.text length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    mainLabel.attributedText = attributedString;

    UIFont * currentFont = [[UIFont alloc]init];
    
    /** 设置5s 适配*/
    CGFloat lineSpace = 0;
    if(IS_IPHONE_5 || IS_IPHONE_4){
        currentFont = MBBFONT(10);
        lineSpace = 5;
    }else{
        currentFont = MBBFONT(12);
        lineSpace = 12;
    }
    paragraphStyle.lineSpacing = lineSpace;
    mainLabel.font = currentFont;
    NSDictionary * attributesDic = @{
                            NSFontAttributeName:currentFont,
                            NSParagraphStyleAttributeName:paragraphStyle
                            };
    CGRect rect = [mainLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 40 - 40, MAXFLOAT)
                                               options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                            attributes:attributesDic
                                               context:nil];
    
    [self addSubview:mainLabel];
    
    mainLabel.sd_layout
    .topSpaceToView(topImage, 10)
    .leftSpaceToView(self, 20)
    .widthIs(SCREEN_WIDTH - 80)
    .heightIs(rect.size.height + 1);
    
    
    
    /** 二维码*/
    UIImageView * QRImage =   [[UIImageView alloc]init];
    QRImage.image = [UIImage imageNamed:@"mine_QR"];
    [self addSubview:QRImage];
    
    QRImage.sd_layout
    .topSpaceToView(mainLabel, 10)
    .leftSpaceToView(self, (SCREEN_WIDTH - 40)/2 - 35)
    .widthIs(70)
    .heightIs(70);
    
    /** */
    
    UILabel * loadLabel = [[UILabel alloc]init];
    loadLabel.text = @"识别二维码下载我的大师兄";
    loadLabel.textAlignment = NSTextAlignmentCenter;
    loadLabel.font = currentFont;
    
    [self addSubview:loadLabel];
    loadLabel.sd_layout
    .topSpaceToView(QRImage, 5)
    .leftSpaceToView(self, 0)
    .widthIs(SCREEN_WIDTH - 40)
    .heightIs(20);
    
    

    
    
    UIImageView * cancelImage = [[UIImageView alloc]init];
    cancelImage.image = [UIImage imageNamed:@"share_cancel"];
    [self addSubview:cancelImage];
    cancelImage.sd_layout
    .topSpaceToView(self, -15)
    .leftSpaceToView(self, -15)
    .widthIs(30)
    .heightIs(30);
    UIImageView * tapImage = [[UIImageView alloc]init];
    tapImage.image = [UIImage imageNamed:@"recommend_button"];
    [self addSubview:tapImage];
    
    tapImage.sd_layout
    .bottomSpaceToView(self,-30)
    .leftSpaceToView(self, (SCREEN_WIDTH - 40)/2 - 30)
    .heightIs(60)
    .widthIs(60);
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tapImage.userInteractionEnabled = YES;
    tapImage.tag = KOperationShare;
    self.userInteractionEnabled = YES;
    [tapImage addGestureRecognizer:tap];
    
    UITapGestureRecognizer * cancellTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    cancelImage.userInteractionEnabled = YES;
    topImage.userInteractionEnabled = YES;
    cancelImage.tag = KOperationCancel;
    [cancelImage addGestureRecognizer:cancellTap];
    
    
    
}

- (void)tap:(UIGestureRecognizer *)tap{
    
    if(tap.view.tag == KOperationShare){
        UIImage * shotImage = [MyControl screenShotView:self];
        UIImage * dealImage = [MyControl cutImageWithImage:shotImage
                                                   atPoint:CGPointMake(15, 15)/** 基准点*/
                                                  withSize:CGSizeMake(self.frame.size.width - 30,self.frame.size.height -45)/** 切除(cancel&share)image*/
                                           backgroundColor:[UIColor whiteColor]];
        self.shotImageBlcok(dealImage);
    }
    if ([self.delegate respondsToSelector:@selector(shareOrCancelOperation:)]) {
        [self.delegate shareOrCancelOperation:tap.view.tag];
    }
}
#pragma mark - 子视图超出父视图bounds
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0 ) {
        UIView * result = [super hitTest:point withEvent:event];
        if (result) {
            return result;
        }else{
            for (UIView * subView in self.subviews.reverseObjectEnumerator) {
                /** 不同坐标系中点的转化(B视图中a点转化为A视图中的点)
                 * [A convertPoint: a fromView: B];
                 */
                CGPoint subPoint = [subView convertPoint:point  fromView:self];
                /*
                 *  触摸的点是否在当前视图内,是返回当前视图,否返回nil
                 */
                result = [subView hitTest:subPoint withEvent:event];
                if (result) {
                    return result;
                }
            }
        }
    }
    return nil;
}
#pragma mark - 截图
-(UIImage *)screenShotView:(UIView *)view{
    UIImage *imageRet = [[UIImage alloc]init];
    UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageRet;
}
@end
