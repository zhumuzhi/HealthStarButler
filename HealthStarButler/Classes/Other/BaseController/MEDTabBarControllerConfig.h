//
//  MEDTabBarControllerConfig.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2018/4/9.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"

@interface MEDTabBarControllerConfig : NSObject

@property (nonatomic, strong, readonly) CYLTabBarController *tabBarController;
@property (nonatomic, copy) NSString *context;

+ (void)customizeInterfaceWithTabBarController:(CYLTabBarController *)tabBarController; 

@end
