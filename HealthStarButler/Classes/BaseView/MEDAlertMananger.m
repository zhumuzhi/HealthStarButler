//
//  MEDAlertMananger.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/13.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#define kRootViewController [UIApplication sharedApplication].keyWindow.rootViewController

#import "MEDAlertMananger.h"

@interface MEDAlertMananger()

@end

static MEDAlertMananger *_managerInstance;

@implementation MEDAlertMananger

//MARK:- 新建的弹出视图
+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSArray *)actionTitles preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void(^)(NSUInteger buttonIndex, NSString *buttonTitle))handler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        handler(0, @"取消");
    }];
    
    [alert addAction:cancelAction];
    
    for (int i = 0; i<actionTitles.count; i++) {
        
        UIAlertAction *confimAction = [UIAlertAction actionWithTitle:actionTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            handler((i+1), actionTitles[i]);
        }];
        [alert addAction:confimAction];
    }
    
    [kRootViewController presentViewController:alert animated:YES completion:^{
        
    }];
}




@end
