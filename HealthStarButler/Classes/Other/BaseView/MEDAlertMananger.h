//
//  MEDAlertMananger.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/13.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDAlertMananger : NSObject

+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSArray *)actionTitles preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void(^)(NSUInteger buttonIndex, NSString *buttonTitle))handler;



@end
