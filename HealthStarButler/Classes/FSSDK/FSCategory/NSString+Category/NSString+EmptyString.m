//
//  NSString+EmptyString.m
//  FXMOnLineAPP
//
//  Created by GHome on 2018/1/17.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "NSString+EmptyString.h"

@implementation NSString (EmptyString)
- (void)isHaveEmptyString: (NSString *)string
                                result: (void(^)(bool isHave,NSRange range))result {
    NSRange range = [string rangeOfString:@" "];
    if (range.location != NSNotFound) {
        result (YES,range);
    } else {
        result (NO,NSMakeRange(0, 0));
    }
}

@end
