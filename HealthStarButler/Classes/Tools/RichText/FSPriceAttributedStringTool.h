//
//  FSPriceAttributedStringTool.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/6.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSPriceAttributedStringTool : NSObject
/* 根据价格字符串返回富文本 */
+ (NSMutableAttributedString *)priceAttributedStringWithString:(NSString *)priceString;
@end
