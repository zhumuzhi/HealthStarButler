//
//  MEDNetClient.m
//  yyy
//
//  Created by 朱慕之 on 16/6/12.
//  Copyright © 2016年 Meridian. All rights reserved.

//  此处只创建网络单例, 具体设置在MEDDataRequest中操作

#import "MEDNetClient.h"

@implementation MEDNetClient

+ (instancetype)sharedClient {
    
    static MEDNetClient *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MEDNetClient alloc] init];

    });
    
    return _sharedClient;
}


@end
