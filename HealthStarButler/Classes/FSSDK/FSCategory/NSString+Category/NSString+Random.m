//
//  NSString+Random.m
//  FXMOnLineAPP
//
//  Created by GHome on 2017/12/26.
//  Copyright © 2017年 GHome. All rights reserved.
//

#import "NSString+Random.h"

@implementation NSString (Random)
+ (NSInteger)creatRandomNumberWithCount: (NSInteger)count {
    NSInteger num = arc4random() % 2 + count * 10;
    return num;
}
+ (NSString *)creatRandomStringWithCount: (NSInteger)count {
    
    NSMutableString *content = [NSMutableString string];
    
    for (NSInteger index = 0; index < count ; index++) {
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSInteger randomH = 0xA1 + arc4random()%(0xFE - 0xA1+1);
        NSInteger randomL = 0xB0 + arc4random()%(0xF7 - 0xB0+1);
        NSInteger number = (randomH<<8)+randomL;
        NSData *data = [NSData dataWithBytes:&number length:2];
        NSString *string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
        [content appendString:string];
    }
    return content;
}
@end
