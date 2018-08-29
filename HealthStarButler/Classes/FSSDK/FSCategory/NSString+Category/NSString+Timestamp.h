//
//  NSString+Timestamp.h
//  XFSSalesSecretary
//
//  Created by mac on 2018/5/23.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Timestamp)

+ (NSString *)timestampFromString:(NSString *)theTime;
+ (NSString *)timetimestampToString:(NSString *)timestamp;


/** 将某个时间转化成 时间戳 */
+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

/** 将某个时间戳转化成 时间 */
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

@end
