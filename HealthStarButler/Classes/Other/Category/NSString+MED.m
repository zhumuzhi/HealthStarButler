//
//  NSString+MED.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/7.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "NSString+MED.h"

@implementation NSString (MED)

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithAttributes:@{NSFontAttributeName : font}];
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSDictionary *dic = @{NSFontAttributeName : font,
                          NSStrikethroughStyleAttributeName : @(lineBreakMode)};
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size;
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    return rect.size;
}


@end
