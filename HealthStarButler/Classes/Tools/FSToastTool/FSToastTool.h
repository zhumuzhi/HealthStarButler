//
//  FSToastTool.h
//  FangShengyun
//
//  Created by 朱慕之 on 2018/7/18.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Toast.h"
#import "MBProgressHUD.h"

/** Toast工具类 */
@interface FSToastTool : NSObject

+ (void)makeToast:(NSString *)message targetView:(UIView *)targetView;

+ (void)makeToast:(NSString *)message targetView:(UIView *)targetView completion:(void(^)(BOOL didTap))completion;

+ (void)hideToast:(UIView *)targetView;


/** 显示Toast+message */
+ (void)makeMBToast:(NSString *)message targetView:(UIView *)targetView;
/** 显示Toast+message+完成后执行代码块 */
+ (void)makeMBToast:(NSString *)message targetView:(UIView *)targetView completionBlock:(nullable MBProgressHUDCompletionBlock)completion;
/** 隐藏Toast */
+ (void)hideMBToast:(UIView *)targetView;
/** 指示器Toast */
+ (void)makeMBToastActivity:(UIView *)targetView;
/** 隐藏指示器Toast */
+ (void)hideMBToastActivity:(UIView *)targetView;

@end
