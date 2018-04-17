//
//  MEDNetClient.h
//  yyy
//
//  Created by 朱慕之 on 16/6/12.
//  Copyright © 2016年 Meridian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface MEDNetClient : AFHTTPSessionManager

/**
 * 全局网络请求单例
 */
+ (instancetype)sharedClient;

@end
