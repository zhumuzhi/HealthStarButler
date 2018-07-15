//
//  NSMutableAttributedString+Custom.h
//  Field
//
//  Created by 赵治玮 on 2017/11/14.
//  Copyright © 2017年 赵治玮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Custom)

+ (NSMutableAttributedString *)creatAttributedWithString: (NSString *)string font:(UIFont *)font color: (UIColor *)color range: (NSRange)range;

@end
