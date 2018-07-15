//
//  NSString+Util.m
//  FXMOnLineAPP
//
//  Created by GHome on 2017/12/28.
//  Copyright © 2017年 GHome. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)
+ (BOOL)isBlankString:(NSString *)str {
    NSString *string = str;
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    return NO;
}

@end
