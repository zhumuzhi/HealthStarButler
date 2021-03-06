//
//  FSToastTool.m
//  FangShengyun
//
//  Created by 朱慕之 on 2018/7/18.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSToastTool.h"

static NSTimeInterval FSDefaultDuration = 2.0;

@implementation FSToastTool

/* 登录页面样式*/
+ (void)makeToast:(NSString *)message targetView:(UIView *)targetView {

    [targetView hideToast];

    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.messageFont = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0];
    style.verticalPadding = 20.0;
    style.messageColor = [UIColor colorWithHexString:@"#FFFFFF"];
    style.messageAlignment = NSTextAlignmentCenter;
    style.backgroundColor = [UIColor colorWithHexString:@"#333333" alpha:0.7];

    style.cornerRadius = 6.0;

    [targetView makeToast:message
                 duration:FSDefaultDuration
                 position:CSToastPositionCenter
                    style:style];
}


/* 登录页面样式待完成回调*/
+ (void)makeToast:(NSString *)message targetView:(UIView *)targetView completion:(void(^)(BOOL didTap))completion {

    [targetView hideToast];

    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.messageFont = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0];
    style.verticalPadding = 20.0;
    style.messageColor = [UIColor colorWithHexString:@"#FFFFFF"];
    style.messageAlignment = NSTextAlignmentCenter;
    style.backgroundColor = [UIColor colorWithHexString:@"#333333" alpha:0.7];
    style.cornerRadius = 6.0;

    [targetView makeToast:message duration:FSDefaultDuration position:CSToastPositionCenter title:nil image:nil style:style completion:completion];
}

+ (void)hideToast:(UIView *)targetView {
    [targetView hideToast];
}

/* 登录页面样式*/
+ (void)makeMBToast:(NSString *)message targetView:(UIView *)targetView {

    if (targetView == nil) targetView = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithHexString:@"#333333" alpha:0.7];

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 2秒之后再消失
    [hud hideAnimated:YES afterDelay:FSDefaultDuration];
}

+ (void)makeMBToast:(NSString *)message targetView:(UIView *)targetView completionBlock:(nullable MBProgressHUDCompletionBlock)completion {
    //MBProgressHUDCompletionBlock completionBlock
    if (targetView == nil) targetView = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithHexString:@"#333333" alpha:0.7];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.completionBlock = completion;
    // 2秒之后再消失
    [hud hideAnimated:YES afterDelay:FSDefaultDuration];
}

+ (void)hideMBToast:(UIView *)targetView {
    [MBProgressHUD hideHUDForView:targetView animated:YES];
}

+ (void)makeMBToastActivity:(UIView *)targetView {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithHexString:@"#333333" alpha:0.7];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
}

+ (void)hideMBToastActivity:(UIView *)targetView {
    [MBProgressHUD hideHUDForView:targetView animated:YES];
}

@end
