//
//  MEDTagTool.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/8.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDTagTool.h"

static MEDTagTool *_instance;

@implementation MEDTagTool

+ (instancetype)sharedTagTools {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

@end
