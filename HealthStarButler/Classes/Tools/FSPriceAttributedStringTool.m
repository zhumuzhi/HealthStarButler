//
//  FSPriceAttributedStringTool.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/6.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSPriceAttributedStringTool.h"

@implementation FSPriceAttributedStringTool

+ (NSMutableAttributedString *)priceAttributedStringWithString:(NSString *)priceString
{

    // 为空防错判断
    if (([FSPriceAttributedStringTool isBlankString:priceString]) || priceString.length<2) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }

    NSString *cutStr = @"~";
    // 判断是价格中是否包含『~』
    if([priceString rangeOfString:cutStr].location != NSNotFound) { // 有切割字符
        // 切割为两个字符串，分别设置富文本
        NSArray *cutStrArray = [priceString componentsSeparatedByString:@"~"];
        //NSLog(@"得到的数组为:%@", cutStrArray);
        NSString *lowStr = [cutStrArray firstObject];
        NSMutableAttributedString *priceRich = [[FSPriceAttributedStringTool alloc] attributedStringWith:lowStr];

        NSString *heightStr = [cutStrArray lastObject];
        NSMutableAttributedString *heightRich = [[FSPriceAttributedStringTool alloc] attributedStringWith:heightStr];

        NSMutableAttributedString *cutRich = [[NSMutableAttributedString alloc] initWithString:cutStr];
        [priceRich appendAttributedString:cutRich];
        [priceRich appendAttributedString:heightRich];
        return priceRich;
    }else { // 无切割字符
        // 直接设置富文本
        NSMutableAttributedString *priceRich = [[FSPriceAttributedStringTool alloc] attributedStringWith:priceString];
        return priceRich;
    }
}


- (NSMutableAttributedString *)attributedStringWith:(NSString *)string
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(string.length-2, 2)];
    return attributedString;
}


+ (BOOL)isBlankString:(NSString *)string {

    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] == NO) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}


@end
