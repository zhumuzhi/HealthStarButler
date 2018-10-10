//
//  NSArray+Empty.m
//  FangShengyun
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "NSArray+Empty.h"

@implementation NSArray (Empty)

+ (BOOL)isEmptyArr:(NSArray *)arr {
    if (!arr) {
        return YES;
    }
    if ([arr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!arr.count) {
        return YES;
    }
    if (arr == nil) {
        return YES;
    }
    if (arr == NULL) {
        return YES;
    }
    if (![arr isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
}

@end
