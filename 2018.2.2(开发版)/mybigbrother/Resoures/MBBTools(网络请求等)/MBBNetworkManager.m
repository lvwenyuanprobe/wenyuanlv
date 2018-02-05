//
//  MBBNetworkManager.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBNetworkManager.h"
#import "MBBUserInfoModel.h"

/** 获取验证码*/
#define Register_Ver  @"/home/register/obtaincode?"
/** 注册*/
#define Register_Reg  @"/home/register/register?"
/** 登陆*/
#define Register_Log  @"/home/register/login?"

/** 第三方快捷登陆*/
#define Register_Third  @"/home/register/thirdlogin?"

/** 修改密码*/
#define Register_Privacy  @"/home/register/privacy?"

/** 忘记密码*/
#define Register_ForgetPwd  @"/home/register/forgetpwd?"


/** 更改个人信息*/
#define Register_Per  @"/home/register/personaldata?"


/** 优惠券兑换*/
#define Register_Exchange_cou  @"/home/register/exchange?"

/** 获取车辆信息*/
#define CarService_CarType  @"/home/cartype/cartype"
/** 申请包车*/
#define CarService_Car  @"/home/car/car"

/** 发布约伴*/
#define PublishPartner_Pub  @"/home/release/releaseadd"

/** 学生家长服务*/
#define Services_List  @"/home/serve/servelist?"

/** 学生家长服务详情*/
#define Services_Detail  @"/home/serve/serveinfo?"

/** 生成服务订单*/
#define Services_GetOrder  @"/home/serve/pay"


/** 定制服务列表*/
#define Home_CustomService_List  @"/home/made/madelist?"
/** 定制服务详情*/
#define Home_CustomService_Detail  @"/home/made/madeinfo?"

/** 机场列表*/
#define Home_Airport_List  @"/home/Place/airport"

/** 城市和机场列表*/
#define Home_Citys_List  @"/home/Place/citys"

/** 我要定制*/
#define Home_CustomService_Phone  @"/home/made/madeAdd?"
/** 学校列表*/
#define Home_School_List  @"/home/Place/schools"

/** 约伴同行列表*/
#define Home_PartnerTogether_List  @"/home/release/rhome?"

/** 约伴同行详情*/
#define Home_PartnerTogether_Detail  @"/home/release/homeinfo?"

/** 接机(生成订单)*/
#define Home_TakePlane  @"/home/aircraft/aircraft?"

/** 首页搜索*/
#define Home_Search  @"/home/index/search?"

/** 首页搜索hotwords*/
#define Home_Search_Hotwords  @"/home/index/hotwords"

/** 首页 服务购买*/
#define Home_Service_Buy  @"/home/index/purchase?"

/** 学生 家长购买服务 */
#define Home_SP_Service_Buy  @"/home/serve/pay"

/** 首页 邀请记录*/
#define Home_InviteRecord  @"/home/invitation/record"



/** 我的发布列表*/
#define My_Publish_List  @"/home/release/releaselist?"
/** 我的订单列表*/
#define My_Order_List  @"/home/order/order?"

/** 我的订单详情*/
#define My_Order_Detail  @"/home/order/orderInfo?"


/** 订单评价*/
#define My_Order_Evaluate  @"/home/order/evaluate"

/** 我的优惠券列表*/
#define My_Coupons_List  @"/home/order/mycoupon?"

/** 我的优惠券列表*/
#define My_Coupons_Check  @"/home/index/querycoupon?"

/** 支付宝支付*/
#define My_Alipay_Pay  @"/home/pay/pay?"

/** 微信支付*/
#define My_Wechat_Pay  @"/home/pay/wepay?"



/** 收藏*/
#define My_Collect  @"/home/collection/keep"

/** 我的收藏*/
#define My_Collections  @"/home/collection/collection"

/** 删除发布*/
#define My_Del_PublishNopay  @"/home/release/releasedel"


/** 服务案例列表*/
#define Home_ServiceCase_List  @"/home/case/caselist"

/** 服务案例详情*/
#define Home_ServiceCase_Detail  @"/home/case/caseInfo?"


/** 新生攻略列表*/
#define TacTics_StudentTactics_List  @"/home/raider/newList"

/** 师兄分享列表*/
#define TacTics_BigBrotherShare_List  @"/home/raider/bigList"

/** 攻略分享详情*/
#define TacTics_TacticsShare_Detial  @"/home/raider/newInfo?"


/** 评论 or 回复 */
#define Public_CommentOrReply  @"/home/release/discuss?"

/** 点赞*/
#define Public_UserFav  @"/home/raider/fabulous"

/** 个人资料展示*/
#define Public_UserPersonalinfoShow @"/home/release/userinfo"


/** 个人资料展示*/
#define Public_System_Message @"/home/index/system"

/** 城市列表*/
#define Public_CityList  @"/home/Place/city"

/** 国家地区 */
#define Public_AreaCode  @"/home/index/areacode"

/** 修改手机号 */
#define Public_ChangPhone  @"/home/register/mobile"

/** 首页图*/
#define Banner_HomePage  @"/home/index/indexbanner"

/** 服务一级图*/
#define Banner_SevericePage  @"/home/index/sbanner"

#pragma mark - 司机

#define ButlerService  @"/home/ButlerService/add"

/** 司机行程*/
#define Driver_OrderList  @"/home/driver/order"
/** 司机的评价*/
#define Driver_EvaluationList  @"/home/driver/mevaluate"
/** 司机账单*/
#define Driver_AccountList  @"/home/driver/bill"
/** 司机提现*/
#define Driver_GetCash  @"/home/driver/withdrawals"
/** 司机钱包*/
#define Driver_Wallet  @"/home/driver/balance"
/** 司机操作订单*/
#define Driver_Operation_Order  @"/home/driver/operation"


/** 邀请好友的链接*/
#define Invite_Friend_Link  @"/home/invitation/invitelink"

/** 意见反馈*/
#define Opion_FeedBack  @"/home/index/feedback"

/** 活动图片*/
#define Home_Activity_Pic  @"/home/index/activity"




@implementation MBBNetworkManager
    
/** 检测网络状态*/
+ (NetworkStatus)checkCurrentNetWork {
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    return status;
}

/** 获取验证码*/
+ (void)userRegisterPhoneMessage:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Register_Ver
                                                andRMethod:YTKRequestMethodGET
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
    
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 新用户注册*/
+ (void)userRegister:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Register_Reg
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 新用户登陆*/
+ (void)userLogin:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Register_Log
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}
/** 修改密码()*/
+ (void)userChangePassword:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Register_Privacy
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 忘记密码*/
+ (void)userForgetPassword:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Register_ForgetPwd
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 用户更改个人信息*/
+ (void)userChangePersonalData:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Register_Per
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 获取车辆信息*/
+ (void)carServiceGetCarType:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:CarService_CarType
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}


/** 申请包车(生成订单)*/
+ (void)chaterCarOrder:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:CarService_Car
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 发布约伴()*/
+ (void)myPublishGetPartnersTogether:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:PublishPartner_Pub
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 学生家长服务()*/
+ (void)studentAndParentsServicesList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Services_List
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 学生家长服务(详情)*/
+ (void)studentAndParentsServicesDetail:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Services_Detail
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 定制服务列表(List)*/
+ (void)getCustomServiceList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_CustomService_List
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 定制服务详情(Detail)*/
+ (void)getCustomServiceDetail:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_CustomService_Detail
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 我的发布(list)*/
+ (void)getMyPublishList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
     MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    if (model.token) {
        param[@"token"] = model.token;
    }
    [param addEntriesFromDictionary:rArgument];
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:My_Publish_List
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:param];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 获取机场列表*/
+ (void)getAirportsList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_Airport_List
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 城市和机场列表*/
+ (void)getCitysList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock {
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_Citys_List
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}


/** 获取学校列表*/
+ (void)getSchoolsList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_School_List
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}


/** 获取服务案例列表*/
+ (void)getServiceCaseList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_ServiceCase_List
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 获取服务案例详情列表*/
+ (void)getServiceCaseDetail:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_ServiceCase_Detail
                                                andRMethod:YTKRequestMethodGET
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 新生攻略列表*/
+ (void)getStudentTacticsList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:TacTics_StudentTactics_List
                                                andRMethod:YTKRequestMethodGET
                                              andRArgument:rArgument];
    [request loadCacheWithError:nil];
    
    NSLog(@"%@",[request responseJSONObject]);
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 师兄分享列表*/
+ (void)getBigBrotherShareList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:TacTics_BigBrotherShare_List
                                                andRMethod:YTKRequestMethodGET
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 攻略分享详情*/
+ (void)getTacticsShareDetail:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:TacTics_TacticsShare_Detial
                                                andRMethod:YTKRequestMethodGET
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 我的订单列表*/
+ (void)getMyOrderList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:My_Order_List
                                                andRMethod:YTKRequestMethodGET
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 我的订单详情*/
+ (void)getMyOrderDetail:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:My_Order_Detail
                                                andRMethod:YTKRequestMethodGET
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}


/** 首页-约伴同行(list)*/
+ (void)getPartnersTogetherList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_PartnerTogether_List
                                                andRMethod:YTKRequestMethodGET
                                              andRArgument:rArgument];
    [request loadCacheWithError:nil];
    
    
    
    
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 首页-约伴同行详情(Detail)*/
+ (void)getPartnersTogetherDetail:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_PartnerTogether_Detail
                                                andRMethod:YTKRequestMethodGET
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}


/** 评论or回复评论()*/
+ (void)putCommentOrReply:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Public_CommentOrReply
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}


/** 城市列表(list)*/
+ (void)putCityList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Public_CityList
                                                andRMethod:YTKRequestMethodGET
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 第三方快捷登陆*/
+ (void)thirdFastLogin:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Register_Third
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 我的优惠券列表*/
+ (void)myCouponsList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:My_Coupons_List
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 接机*/
+ (void)userGetTakePlane:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_TakePlane
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 优惠券兑换*/
+ (void)userConvertCodeCoupons:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Register_Exchange_cou
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 我要定制*/
+ (void)userCustomService:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_CustomService_Phone
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 首页- 服务搜索*/
+ (void)userSearchService:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_Search
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}
/** 首页 - 搜索热门词汇*/
+ (void)userSearchHotWords:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_Search_Hotwords
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}
/** 服务购买*/
+ (void)userBuyService:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_Service_Buy
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 优惠券查询*/
+ (void)userCheckOutCoupons:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:My_Coupons_Check
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 支付宝支付*/
+ (void)userPayAlipay:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:My_Alipay_Pay
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}


/** 获取首页轮播图*/
+ (void)getHomePageBannerImages:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock {
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Banner_HomePage
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request loadCacheWithError:nil];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}
/** 获取服务图*/
+ (void)getServicePageImages:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Banner_SevericePage
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 司机行程(空:已预约 1:进行中 2:已完成)*/
+ (void)userDriverDistanceOrderList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Driver_OrderList
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}
/** 司机账单*/
+ (void)userDriverAccountList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Driver_AccountList
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 司机提现*/
+ (void)userDriverGetcash:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Driver_GetCash
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}
/** 司机钱包信息*/
+ (void)userDriverWalletInfo:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Driver_Wallet
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 微信支付*/
+ (void)userPayWechat:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:My_Wechat_Pay
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 司机操作订单*/
+ (void)driverOperationDistanceOrder:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Driver_Operation_Order
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}


/** 获取邀请好友链接*/
+ (void)userGetInvitelink:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Invite_Friend_Link
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 意见反馈*/
+ (void)userOpinionFeedBack:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Opion_FeedBack
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}


/** 活动图片*/
+ (void)userGetActivityPicture:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_Activity_Pic
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}



/** 生成服务订单*/
+ (void)userGetServiceOrder:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Services_GetOrder
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}


/** 获取邀请记录*/
+ (void)userGetInviteRecord:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_InviteRecord
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 订单评价*/
+ (void)userOrdeEevaluation:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:My_Order_Evaluate
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 司机(我的评价)*/
+ (void)driverMineEevaluationList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Driver_EvaluationList
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}


/** 赞*/
+ (void)userFavContent:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Public_UserFav
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 个人资料展示*/
+ (void)userPersonalInfoShow:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Public_UserPersonalinfoShow
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}


/** 系统消息*/
+ (void)userSystemMessages:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Public_System_Message
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}


/** 收藏*/
+ (void)userCollectKeep:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:My_Collect
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 我的收藏*/
+ (void)userCollectionKeepList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:My_Collections
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}


/** 删除发布*/
+ (void)userRemovePublishNoPay:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:My_Del_PublishNopay
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 学生 家长服务购买*/
+ (void)studentOrParentsGetService:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Home_SP_Service_Buy
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}

/** 国家地区*/
+ (void)areaNumberList:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Public_AreaCode
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}
/** 修改手机号*/
+ (void)changePhoneNumber:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:Public_ChangPhone
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}
/** 司机行程(空:已预约 1:进行中 2:已完成)*/
+ (void)butlerService:(NSDictionary *)rArgument responseResult:(MBBRequestBlock)resultBlock{
    
    MBBRequest *request = [[MBBRequest alloc] initWithRUrl:ButlerService
                                                andRMethod:YTKRequestMethodPOST
                                              andRArgument:rArgument];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        resultBlock(request);
    }];
}
@end
