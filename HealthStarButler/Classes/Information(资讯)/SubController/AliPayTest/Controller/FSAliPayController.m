//
//  FSAliPayController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/7.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSAliPayController.h"
#import <AlipaySDK/AlipaySDK.h>

#import "GHHTTPManager.h"



#define AP_SUBVIEW_XGAP   (20.0f)
#define AP_SUBVIEW_YGAP   (30.0f)
#define AP_SUBVIEW_WIDTH  (([UIScreen mainScreen].bounds.size.width) - 2*(AP_SUBVIEW_XGAP))
#define AP_BUTTON_HEIGHT  (60.0f)
#define AP_INFO_HEIGHT    (200.0f)

@interface FSAliPayController ()

@end

@implementation FSAliPayController


#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark - configUI
- (void)configUI {
    [self configration];

    // NOTE: 支付按钮，模拟支付流程
    CGFloat originalPosY = [UIApplication sharedApplication].statusBarFrame.size.height + 80.0f;
    [self generateBtnWithTitle:@"支付宝-支付单" selector:@selector(getAPPayList) posy:originalPosY];

    // NOTE: 授权按钮，模拟授权流程
    originalPosY += (AP_BUTTON_HEIGHT + AP_SUBVIEW_YGAP);
    [self generateBtnWithTitle:@"支付流水单" selector:@selector(doAliPay) posy:originalPosY];
}

- (void)generateBtnWithTitle:(NSString*)title selector:(SEL)selector posy:(CGFloat)posy
{
    UIButton* tmpBtn = [[UIButton alloc]initWithFrame:CGRectMake(AP_SUBVIEW_XGAP, posy, AP_SUBVIEW_WIDTH, AP_BUTTON_HEIGHT)];
    tmpBtn.backgroundColor = [UIColor colorWithRed:81.0f/255.0f green:141.0f/255.0f blue:229.0f/255.0f alpha:1.0f];
    tmpBtn.layer.masksToBounds = YES;
    tmpBtn.layer.cornerRadius = 4.0f;
    [tmpBtn setTitle:title forState:UIControlStateNormal];
    [tmpBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tmpBtn];
}

#pragma mark - configration
- (void)configration {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"支付宝";
}




#pragma mark - Event

- (void)getAPPayList {

//    支付单-地址：http://192.168.65.106:8888/payment/app/save_pay_info
//    参数：{
//        "orderIds": "1000001",
//        "memberId": 10032,
//        "customerId": 23368888,
//        "customerCode": "06.02.0264",
//        "payType": 10,
//        "totalAmount": 10,
//        "accountFlag": 1
//    }
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@"1000001" forKey:@"orderIds"];
    [param setObject:@(10032) forKey:@"memberId"];
    [param setObject:@(23368888) forKey:@"customerId"];
    [param setObject:@"06.02.0264" forKey:@"customerCode"];
    [param setObject:@(10) forKey:@"payType"];
    [param setObject:@(10) forKey:@"totalAmount"];
    [param setObject:@(1) forKey:@"accountFlag"];
    NSLog(@"支付单请求参数:%@",param);
    [[GHHTTPManager sharedManager] requstSearchDataWithUrl:@"http://192.168.65.106:8888/payment/app/save_pay_info" parametes:param finishedBlock:^(id responseObject, NSError *error) {
        NSLog(@"支付单返回结果:%@", responseObject);
//        {
//            availableAccount = "96625.91";
//            needPayAmount = 1;
//            payId = 2180000159110;
//            systemTime = "2018-08-07 18:55:00";
//        }
//        if (res.errorCode == kGetShopListSuccess) { // 请求成功
//        }
        if (error) {
            NSLog(@"支付单错误:%@", error);
        }
    }];

}

- (void)doAliPay {

//    支付流水单-地址：http://192.168.65.106:8888/payment/app/combine_pay
//    参数：{
//        "params": [
//                   {
//                       "payId": 2180000152110,
//                       "platform": 20,
//                       "payWayName": "AliPay",
//                       "payableAmount": 0.01,
//                       "accountPwd": "MTExMTEx"
//                   }
//                   ]
//    }

    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@(2180000159110) forKey:@"payId"];
    [param setObject:@(20) forKey:@"platform"];
    [param setObject:@"AliPay" forKey:@"payWayName"];
    [param setObject:@(0.01) forKey:@"payableAmount"];

    NSMutableDictionary *bigParam = [[NSMutableDictionary alloc] init];
    NSArray *paramArray = @[param];
    [bigParam setObject:paramArray forKey:@"params"];

    NSLog(@"流水单请求参数:%@",bigParam);
//    [param setObject:@"MTExMTEx" forKey:@"accountPwd"]; //账期支付密码
    [[GHHTTPManager sharedManager] requstSearchDataWithUrl:@"http://192.168.65.106:8888/payment/app/combine_pay" parametes:bigParam finishedBlock:^(id responseObject, NSError *error) {
        NSLog(@"流水单返回结果:%@", responseObject);
        NSLog(@"获取到的签名：%@", responseObject[@"data"]);
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";

        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@",  responseObject[@"data"]];

        dispatch_async(dispatch_get_main_queue(), ^{
            // NOTE: 调用支付结果开始支付
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
            }];

        });

        if (error) {
            NSLog(@"流水单错误:%@", error);
        }
    }];
}




#pragma mark - LazyGet



@end
