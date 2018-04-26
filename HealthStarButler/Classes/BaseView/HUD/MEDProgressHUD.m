//
//  MEDProgressHUD.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/25.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDProgressHUD.h"

@implementation MEDProgressHUD

// 延迟时间
+ (void)delay {
    sleep(1.);
}
// 预留延时设置方法
- (void)delay:(float)time {
    sleep(time);
}

+ (void)dismissHUD {
    
    [SVProgressHUD dismiss];
}

+ (void) showHUDStatus {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:MEDLightGray];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD showWithStatus:nil];
}

+ (void)showHUDStatusTitle:(NSString *)Title {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:MEDLightGray];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    
    [SVProgressHUD showWithStatus:Title];
}

+ (void)dismissHUDSuccessTitle:(NSString *)Title {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    
    [SVProgressHUD showSuccessWithStatus:Title];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        [self delay];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
        });
        
    });
}



+ (void)dismissHUDWithTitle:(NSString *)Title {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    
    [SVProgressHUD showImage:[UIImage new] status:Title];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        [self delay];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
        });
        
    });
}




//+ (void)showSuccessWithStatus:(NSString*)status {
//    [self showImage:[self sharedView].successImage status:status];
//}


+ (void)dismissHUDErrorTitle:(NSString *)Title {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    
    [SVProgressHUD showErrorWithStatus:Title];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        [self delay];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
        });
        
    });
}

@end
