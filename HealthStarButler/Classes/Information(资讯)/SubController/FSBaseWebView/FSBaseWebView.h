//
//  FSBaseWebView.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/9/21.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - H5控制器类型枚举
/** 控制器类型 */
typedef NS_ENUM (NSUInteger, FSWebViewControllerType) {
    /** 注册 */
    FSWebViewControllerTypeRegister = 1,
    /** 忘记密码 */
    FSWebViewControllerTypeForgetPassword,
    /** 客服 */
    FSWebViewControllerTypeCustomerService,
    /** 我的订单 */
    FSWebViewControllerTypeMyOrder,
    /** 采购单-购物车 */
    FSWebViewControllerTypeShopCart,
    /** 账户升级 */
    FSWebViewControllerTypeAuthentication,
    /** 优惠券 */
    FSWebViewControllerTypeChangeCoupon,
    /** 修改登录密码 */
    FSWebViewControllerTypeChangeLoginPassword,
    /** 修改绑定手机号 */
    FSWebViewControllerTypeChangeBindPhoneNum
};


#pragma mark - JS交互方法名称
/** BaseUrl */
static NSString *kH5BaseURL = @"https://t.fsyuncai.com/h5/";

/** 返回 */
static NSString *kH5Method_goBack = @"goBack";
/** 去登陆 */
static NSString *kH5Method_toLogin = @"toLogin";
/** 修改密码成功 */
static NSString *kH5Method_passWordSucess = @"passWordSucess";
/** 去首页 */
static NSString *kH5Method_goHomePage = @"indexList";
/** 使用优惠券 */
static NSString *kH5Method_useCoupon = @"useCoupon";
/** 商品详情 */
static NSString *kH5Method_goodsDetaile = @"goodsDetaile";
/** 再次购买 */
static NSString *kH5Method_buyAgain = @"buyAgain";
/** 区域选择 */
static NSString *kH5Method_choseZone = @"region";
/** 提交订单 */
static NSString *kH5Method_confirmdata = @"confirmdata";
/** 去支付 */
static NSString *kH5Method_goPay = @"goPay";
/** 去确认 */
static NSString *kH5Method_goPayConfirm = @"goPayConfirm";
/** 返回我的方盛 */
static NSString *kH5Method_backMyfs = @"backMyfs";
/** 联系客服 */
static NSString *kH5Method_contactService = @"contactService";


@interface FSBaseWebView : UIViewController

/** 控制器类型 */
@property (nonatomic, assign) FSWebViewControllerType type;

@end
