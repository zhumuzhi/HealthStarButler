//
//  GHHTTPManager.h
//  Field
//
//  Created by 赵治玮 on 2017/11/8.
//  Copyright © 2017年 赵治玮. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void (^FinishedBlock)(id responseObject,NSError *error);
@interface GHHTTPManager : AFHTTPSessionManager
/** 单利 */
+ (instancetype)sharedManager;
/**
 
 @param url url
 @param parametes 参数字典
 @param finishedBlock 请求回调
 */

- (void)requstDataWithUrl: (NSString *)url parametes: (NSDictionary *)parametes finishedBlock: (FinishedBlock)finishedBlock;

- (void)requstSearchDataWithUrl: (NSString *)url parametes: (NSDictionary *)parametes finishedBlock: (FinishedBlock)finishedBlock ;

- (void)requstGoodDetailsWithUrl: (NSString *)url finishedBlock: (FinishedBlock)finishedBlock;
@end
