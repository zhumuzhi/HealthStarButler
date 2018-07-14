//
//  NSString+MED.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/7.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MED)

//复写iOS7.0之前方法
- (CGSize)sizeWithFont:(UIFont *)font;

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;



/** 判断字符串是否为空 */
+ (BOOL)isBlankString:(NSString *)string;

/** 计算文件大小 */
- (unsigned long long)fileSize;

@end
