//
//  NSObject+MED.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/25.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "NSObject+MED.h"

@implementation NSObject (MED)

-(BOOL)isNotEmpty{
    return !(self == nil
             || [self isKindOfClass:[NSNull class]]
             || ([self respondsToSelector:@selector(length)]
                 && [(NSData *)self length] == 0)
             || ([self respondsToSelector:@selector(count)]
                 && [(NSArray *)self count] == 0));
    
}

@end
