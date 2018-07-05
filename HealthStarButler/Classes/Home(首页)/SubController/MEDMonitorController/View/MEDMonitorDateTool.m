//
//  MEDMonitorDateTool.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/10/13.
//  Copyright © 2017年 Meridian. All rights reserved.
//  创建完不准备使用的工具类

#import "MEDMonitorDateTool.h"

@implementation MEDMonitorDateTool

+ (instancetype)shareMonitorDateTool {
    return [[self alloc] init];
}

static MEDMonitorDateTool *_instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

+ (NSString *)dateyyyyMMddStrFromDate:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)dateyyyyMMStrFromDate:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSDate *)dateFromDateyyyyMMStr:(NSString *)dateStr {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

//天数
+ (int)currentDaysWithString:(NSString *)dateStr {
    
    NSString *currentDateStr = [self dateyyyyMMStrFromDate:[NSDate date]];
    
    NSArray *array = [currentDateStr componentsSeparatedByString:@"-"];
    NSString *str = [NSString stringWithFormat:@"%@-%@",[array objectAtIndex:0],[array objectAtIndex:1]];
    if ([str isEqualToString:dateStr]) {
        return [[array objectAtIndex:2] intValue];
    } else{
        return [self numberDaysOfmonthWith:dateStr];
    }
}

//月的天数
+ (int)numberDaysOfmonthWith:(NSString *)dateStr  {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [self dateFromDateyyyyMMStr:dateStr];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    //    return (int)days.length+1;
    return (int)days.length;
}


@end
