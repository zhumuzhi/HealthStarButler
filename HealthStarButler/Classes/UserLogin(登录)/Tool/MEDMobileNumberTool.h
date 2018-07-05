//
//  MEDMobileNumberTool.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/25.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDMobileNumberTool : NSObject

+ (BOOL)isMobileNumber:(NSString *)mobileNum onlyMobile:(BOOL)onlyMobile;

@end
