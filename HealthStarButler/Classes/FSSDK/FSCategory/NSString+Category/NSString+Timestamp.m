//
//  NSString+Timestamp.m
//  XFSSalesSecretary
//
//  Created by mac on 2018/5/23.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "NSString+Timestamp.h"

@implementation NSString (Timestamp)
//字符串时间——时间戳
+ (NSString *)timestampFromString:(NSString *)theTime {
    //theTime __@"%04d-%02d-%02d %02d:%02d:00"
    
    //装换为时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    //        [formatter setTimeZone:timeZone];
    NSDate* dateTodo = [formatter dateFromString:theTime];
    NSString *timeSp = [NSString stringWithFormat:@"%ld000", (long)[dateTodo timeIntervalSince1970]];
    
    return timeSp;
}
+ (NSString *)timetimestampToString:(NSString *)timestamp {
    
    timestamp = [timestamp substringToIndex:10];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp.longLongValue];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *string=[dateFormat stringFromDate:confromTimesp];
    return string;
}
@end
