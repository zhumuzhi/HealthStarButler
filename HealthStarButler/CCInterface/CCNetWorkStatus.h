//
//  CCNetWorkStatus.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2019/8/14.
//  Copyright © 2019 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCNetWorkStatus : NSObject

+ (NetworkStatus)getNetWorkStatus;

/**
 *  是否是wifi环境
 *
 *  @return YES是/NO不是
 */
+(BOOL)isWifiEnable;

/**
 *  是否有网络连接
 *
 *  @return YES有/NO没有
 */
+(BOOL)isFi;

/**
 *  开启网络指示器
 */
+(void)startNetworkActivity;

/**
 *  关闭网络指示器
 */
+(void)stopNetworkActivity;


@end

NS_ASSUME_NONNULL_END
