//
//  MBBNetworkManager.h
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "MBBRequest.h"

typedef void (^MBBRequestBlock)(YTKBaseRequest *request);

@interface MBBNetworkManager : NSObject
    
/** 检测网络状态*/
+ (NetworkStatus)checkCurrentNetWork;

#pragma mark - 我的 - 用户信息操作
/** 新用户注册获取验证码*/
+ (void)userRegisterPhoneMessage:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


/** 新用户注册*/
+ (void)userRegister:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 用户登陆*/
+ (void)userLogin:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 第三方快捷登陆*/
+ (void)thirdFastLogin:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 修改密码()*/
+ (void)userChangePassword:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 忘记密码*/
+ (void)userForgetPassword:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 用户更改个人信息*/
+ (void)userChangePersonalData:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


/** 我的发布(list)*/
+ (void)getMyPublishList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


/** 我的订单(list)*/
+ (void)getMyOrderList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 我的订单详情*/
+ (void)getMyOrderDetail:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 我的优惠券列表*/
+ (void)myCouponsList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 优惠券兑换*/
+ (void)userConvertCodeCoupons:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 优惠券查询(符合条件筛选)*/
+ (void)userCheckOutCoupons:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 收藏*/
+ (void)userCollectKeep:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 我的收藏*/
+ (void)userCollectionKeepList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 删除发布*/
+ (void)userRemovePublishNoPay:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 修改手机号*/
+ (void)changePhoneNumber:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

#pragma mark - 车辆服务
/** 获取车辆信息*/
+ (void)carServiceGetCarType:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 申请包车*/
+ (void)chaterCarOrder:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 发布约伴()*/
+ (void)myPublishGetPartnersTogether:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

#pragma mark - 服务
/** 学生家长服务()*/
+ (void)studentAndParentsServicesList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 学生家长服务(详情)*/
+ (void)studentAndParentsServicesDetail:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 生成服务订单*/
+ (void)userGetServiceOrder:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

#pragma mark - 首页 - 定制服务
/** 定制服务列表*/
+ (void)getCustomServiceList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 定制服务详情(Detail)*/
+ (void)getCustomServiceDetail:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 获取机场列表*/
+ (void)getAirportsList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 城市和机场列表*/
+ (void)getCitysList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 获取学校列表*/
+ (void)getSchoolsList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 获取服务案例列表*/
+ (void)getServiceCaseList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 获取服务案例详情列表*/
+ (void)getServiceCaseDetail:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 首页-约伴同行(list)*/
+ (void)getPartnersTogetherList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 首页-约伴同行详情(Detail)*/
+ (void)getPartnersTogetherDetail:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 首页- 服务搜索*/
+ (void)userSearchService:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 首页 - 搜索热门词汇*/
+ (void)userSearchHotWords:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 首页 - 服务购买*/
+ (void)userBuyService:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 我要定制*/
+ (void)userCustomService:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 首页 - 接机*/
+ (void)userGetTakePlane:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 获取邀请记录*/
+ (void)userGetInviteRecord:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;



/** 学生 家长服务购买*/
+ (void)studentOrParentsGetService:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


#pragma mark - 攻略 -
/** 新生攻略列表*/
+ (void)getStudentTacticsList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 师兄分享列表*/
+ (void)getBigBrotherShareList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 攻略分享详情*/
+ (void)getTacticsShareDetail:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


#pragma mark - 公共
/** 评论or回复评论()*/
+ (void)putCommentOrReply:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


/** 城市列表(list)*/
+ (void)putCityList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


/** 支付宝支付*/
+ (void)userPayAlipay:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


/** 微信支付*/
+ (void)userPayWechat:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 获取首页轮播图*/
+ (void)getHomePageBannerImages:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 获取服务图*/
+ (void)getServicePageImages:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


/** 获取邀请好友链接*/
+ (void)userGetInvitelink:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


/** 意见反馈*/
+ (void)userOpinionFeedBack:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


/** 订单评价*/
+ (void)userOrdeEevaluation:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


/** 活动图片*/
+ (void)userGetActivityPicture:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


/** 点赞(1,攻略 2,案例 3,约伴)*/
+ (void)userFavContent:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


/** 个人资料展示*/
+ (void)userPersonalInfoShow:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


/** 系统消息*/
+ (void)userSystemMessages:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


/** 国家地区*/
+ (void)areaNumberList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;


#pragma mark - 司机
/** 司机行程(空:已预约 1:进行中 2:已完成)*/
+ (void)userDriverDistanceOrderList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 司机账单*/
+ (void)userDriverAccountList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 司机提现*/
+ (void)userDriverGetcash:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 司机钱包信息*/
+ (void)userDriverWalletInfo:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 司机操作订单*/
+ (void)driverOperationDistanceOrder:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;

/** 司机(我的评价)*/
+ (void)driverMineEevaluationList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;
+ (void)butlerService:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock;
@end
