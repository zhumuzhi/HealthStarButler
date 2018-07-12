//
//  MEDProgressHUD.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/25.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface MEDProgressHUD : NSObject

// 取消
+ (void)dismissHUD;
/** 提示状态 */
+ (void) showHUDStatus;
// 提示状态-无文字
+ (void)showHUDStatusTitle:(NSString *)Title;
// 提示成功
+ (void)dismissHUDSuccessTitle:(NSString *)Title;
// 提示错误
+ (void)dismissHUDErrorTitle:(NSString *)Title;
// 只提示文字
+ (void)dismissHUDWithTitle:(NSString *)Title;

@end
