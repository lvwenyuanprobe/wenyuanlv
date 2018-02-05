//
//  MBBDefines.h
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#ifndef MBBDefines_h
#define MBBDefines_h





/** 登入 */
#define MBB_LOGIN_IN @"MBB_LOGIN_IN"

/** 登出 */
#define MBB_LOGIN_OUT @"MBB_LOGIN_OUT"

/** 引导页结束 创建根视图控制器*/
#define MBB_RECREATE_ROOT @"RECREATE_ROOTVC"

/** 微信支付*/
#define WECHATPAY_NOTIFA @"WechatPay_Notifa"

/** 支付宝支付(iOS10通知)*/
#define ALIPAY_NOTIFA    @"AliPay_Notifa"

/** tabBar 首页点击*/
#define TABHOMEPAGE_NOTIFA    @"HomePage_Tab_Click"


typedef NS_ENUM (NSInteger, KFriendType){
    KFriendWeixin = 100,
    KFriendQQ,
    KFriendWeibo
};




#define    kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备的宽 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/** 设备的高 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define PicWScale SCREEN_WIDTH/320.0f
#define PicHScale SCREEN_HEIGHT/568.0f
/** 快速设置颜色宏 */
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/** 颜色生成*/
#define MBBCOLOR_ALPHA(r, g, b, a)                           \
[UIColor colorWithRed:(r) / 255.0                            \
green:(g) / 255.0                                            \
blue:(b) / 255.0                                             \
alpha:a * 1.0]
#define MBBCOLOR(r, g, b)                                    \
[UIColor colorWithRed:(r) / 255.0                            \
green:(g) / 255.0                                            \
blue:(b) / 255.0                                             \
alpha:1.0]
#define MBBHEXCOLOR_ALPHA(c, a) [UIColor colorWithHexValue:c alpha:a]
#define MBBHEXCOLOR(c) [UIColor colorWithHexValue:c alpha:1.0]
// RGB
#define RGB(r,g,b)          RGBA(r,g,b,1)
#define RGBEqualColor(c)    RGB(c,c,c)
#define RGBRandom           RGB(arc4random()%255,arc4random()%255,arc4random()%255)


#pragma mark - 定义属性

#define YQ_Nonatomic_Strong                 @property (nonatomic, strong)
#define YQ_Nonatomic_Assign                 @property (nonatomic, assign)
#define YQ_Nonatomic_Copy                   @property (nonatomic, copy)
#define YQ_Nonatomic_Weak                   @property (nonatomic, weak)
#define YQ_Nonatomic_String(__str__)        YQ_Nonatomic_Copy   NSString * __str__ ;
#define YQ_Nonatomic_Array(__arr__)         YQ_Nonatomic_Strong NSArray  * __arr__ ;
#define YQ_Nonatomic_MutableArr(__arr__)    YQ_Nonatomic_Strong NSMutableArray* __arr__ ;
#define YQ_Nonatomic_Dictionary(__dic__)    YQ_Nonatomic_Strong NSDictionary  * __dic__ ;
#define YQ_Nonatomic_MutableDic(__dic__)    YQ_Nonatomic_Strong NSMutableDictionary * __dic__ ;
#pragma mark - -

//统一间距
#define LeftMarginPengBei  bigPhoneValue(23)
#define RightMarginPengBei LeftMarginPengBei

#define __weakSelf__        __weak   __typeof(self)weakSelf = self;
#define __strongSelf__      __strong __typeof(weakSelf)self = weakSelf;

//线
#define colorLineYiZhangTong [UIColor colorWithHexString:@"#dddddd"]
#define colorsLineYiZhangTong [UIColor colorWithHexString:@"#eeeeee"]

#define ShowAllCellNOTIFICATION @"ShowAllCellNOTIFICATION"
#define MAXNUMBER 0
#define CLColor(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define BOUNDS   [[UIScreen mainScreen] bounds]


/**全局配色*/
//#define BASE_COLOR MBBCOLOR(26, 25, 30)
#define BASE_COLOR MBBHEXCOLOR(0xe24e2b)
#define BASE_YELLOW MBBHEXCOLOR(0xfb6030)

#define BASE_GRAY_CLOR MBBHEXCOLOR(0x999999)
#define BASE_CELL_LINE_COLOR MBBHEXCOLOR(0xdddddd)
#define BASE_VC_COLOR MBBHEXCOLOR(0xf5f5f5)

#define BUTTON_COLOR MBBHEXCOLOR(0xe24e2b)
#define FONT_DARK MBBCOLOR(19,19,19)
#define FONT_LIGHT MBBCOLOR(155,155,155)
/** 全局字体 iOS9.0以前没有平方字体*/
#define MBBFONT(f) [UIFont fontWithName:@"PingFangSC-Light" size:f]
//设定大小
#define W(float) [UIView setWidth:(float)]
#define H(float) [UIView setHeight:(float)]
#define W6(float) [UIView set6Width:(float)]
#define H6(float) [UIView set6Height:(float)]

/** defines a weak `self` named `__weakSelf` */
#define MBBWeak(var, weakVar) __weak __typeof(&*var) weakVar = var
#define MBBWeakSelf MBBWeak(self, __weakSelf);

/** 设备判断 */
#define IS_IPHONE_4                                                            \
(fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)480) <    \
DBL_EPSILON)
#define IS_IPHONE_5                                                            \
(fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) <    \
DBL_EPSILON)
#define IS_IPHONE_6                                                            \
(fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)667) <    \
DBL_EPSILON)
#define IS_IPHONE_6plus                                                        \
(fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)736) <    \
DBL_EPSILON)
#define IS_IPHONE_X                                                        \
(fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)812) <    \
DBL_EPSILON)

/**ios系统版本大于等于9.0*/
#define QYQiOSGreaterThanNine                                                \
([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)

#pragma mark --------- /////////////////////////////////////////////// -----------------------------------

#define WeakSelf  __weak __typeof(&*self)weakSelf = self;

#define KEYWINDOW [UIApplication sharedApplication].keyWindow
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define isiPad [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

#pragma mark - 颜色
//颜色
#ifndef RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#endif

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

#define kGrayColor  RGBCOLOR(196, 197, 198)
#define kGreenColor RGBCOLOR(0, 201, 144)


#endif /* MBBDefines_h */
