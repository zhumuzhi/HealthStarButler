//
//  NSObject+runtime.m
//  BaiKeOStar
//
//  Created by NegHao on 2016/10/13.
//  Copyright © 2016年 facebac. All rights reserved.
//

#import "NSObject+runtime.h"
#import <objc/runtime.h>

@implementation NSObject (runtime)

// ********** 防止数据越界崩溃 **********
+ (void)swizzleClassMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getClassMethod(class, otherSelector);
    Method originMehtod = class_getClassMethod(class, originSelector);
    // 交换2个方法的实现
    method_exchangeImplementations(otherMehtod, originMehtod);
}

+ (void)swizzleInstanceMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getInstanceMethod(class, otherSelector);
    Method originMehtod = class_getInstanceMethod(class, originSelector);
    // 交换2个方法的实现
    method_exchangeImplementations(otherMehtod, originMehtod);
}

@end

@implementation NSArray (runtime)

+ (void)load
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayI") originSelector:@selector(objectAtIndex:) otherSelector:@selector(mz_objectAtIndex:)];
    });
}

- (id)mz_objectAtIndex:(NSInteger)index
{
    
    if (index < self.count) {
     
        return [self mz_objectAtIndex:index];
    } else {

    //NSAssert(NO, @"beyond the boundary");
        NSLog(@"数组越界，发生错误");
    
        
        return nil;
    }
}

@end

@implementation NSMutableArray (runtime)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(insertObject:atIndex:) otherSelector:@selector(mz_insertObject:atIndex:)];
        [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(objectAtIndex:) otherSelector:@selector(mz_objectAtIndex:)];
    });
}

- (void)mz_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject != nil && index<=self.count) {
        [self mz_insertObject:anObject atIndex:index];
    }
}

- (id)mz_objectAtIndex:(NSInteger)index
{
    if (index < self.count) {
        return [self mz_objectAtIndex:index];
    } else {
//        [NHCallStackSymbols callStackSymbols:self andObjectValue:[NSString stringWithFormat:@"NSMutableArray:%ld",index]];
        NSLog(@"数组越界，发生错误");

        return nil;
    }
}

@end

@implementation NSDictionary (runtime)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSClassFromString(@"__NSPlaceholderDictionary") originSelector:@selector(initWithObjects:forKeys:count:) otherSelector:@selector(mz_initWithObjects:forKeys:count:)];
    });
}

- (instancetype)mz_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt
{
    for (int i=0; i<cnt; i++) {
        if (objects[i] == nil) {
//            [NHCallStackSymbols callStackSymbols:self andObjectValue:[NSString stringWithFormat:@"NSDictionary value: key:"]];
            return nil;
        }
    }
    return [self mz_initWithObjects:objects forKeys:keys count:cnt];
}

@end

@implementation NSMutableDictionary (runtime)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSClassFromString(@"__NSDictionaryM") originSelector:@selector(setObject:forKey:) otherSelector:@selector(mz_setObject:forKey:)];
    });
}

- (void)mz_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject!=nil) {
        [self mz_setObject:anObject forKey:aKey];
    } else {
//        [NHCallStackSymbols callStackSymbols:self andObjectValue:[NSString stringWithFormat:@"NSMutableDictionary value:%@ key:%@",anObject,aKey]];
        NSLog(@"设置了字典的value为nil");
      
    }
}
// ********** 防止数据越界崩溃 **********








@end
