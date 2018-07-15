//
//  NSMutableAttributedString+Custom.m
//  Field
//
//  Created by 赵治玮 on 2017/11/14.
//  Copyright © 2017年 赵治玮. All rights reserved.
//

#import "NSMutableAttributedString+Custom.h"

@implementation NSMutableAttributedString (Custom)
+ (NSMutableAttributedString *)creatAttributedWithString: (NSString *)string
                                                    font: (UIFont *)font
                                                   color: (UIColor *)color
                                                   range: (NSRange) range{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    [attString addAttributes:@{NSForegroundColorAttributeName:color} range:range];
    return attString;
}

@end
