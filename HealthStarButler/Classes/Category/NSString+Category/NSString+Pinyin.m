//
//  NSString+Pinyin.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/15.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "NSString+Pinyin.h"

@implementation NSString (Pinyin)

//汉字的拼音
- (NSString *)pinyin{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);

    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
