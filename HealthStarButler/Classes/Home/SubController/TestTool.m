//
//  TestTool.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/6.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "TestTool.h"

@implementation TestTool
static TestTool * _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //使用super去调用是因为牵扯到内存地址分配 需要从内存当中找到一个可以使用的地址给当前的对象
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)shareTool {
    return [[self alloc] init];
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

@end
