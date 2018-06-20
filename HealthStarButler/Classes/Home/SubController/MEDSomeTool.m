//
//  MEDSomeTool.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/15.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDSomeTool.h"

@implementation MEDSomeTool

static MEDSomeTool *_instance;

+ (instancetype)sharedSomeTools {
    return [[self alloc] init];  //考虑到继承
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (_instance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [super allocWithZone:zone]; //覆写系统方法应用super将系统的操作做完，在加入自己的逻辑
        });
    }
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

@end
