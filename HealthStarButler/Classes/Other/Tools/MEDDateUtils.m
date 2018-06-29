//
//  MEDDateUtils.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/8.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDDateUtils.h"

NSTimeInterval const dateUtilsMinuteTime    = 60;
NSTimeInterval const dateUtilsHourTime      = dateUtilsMinuteTime * 60;
NSTimeInterval const dateUtilsDayTime       = dateUtilsHourTime * 24;

@implementation MEDDateUtils

//当前是周几，按照美制周期，需要减一天
+ (int)currentWeekday
{
    NSDateComponents *comps = [MEDDateUtils compsFromNow];
    return (int)comps.weekday;
}

//获取当前时间的 时/分  将NSDate转换为字符串
+ (NSString *)timeStrFromDate:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

//获取当前时间的 月/日  将字符串转换为NSDate
+ (NSDate *)dateFromTimeStr:(NSString *)timeStr
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    return date;
}

//获取当前时间的 月/日  将NSDate转换为字符串
+ (NSString *)dateMMddStrFromDatePoint:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM.dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)dateYYMMddStrFromDatePoint:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}
//获取当前时间的 月/日  将NSDate转换为字符串
+ (NSString *)dateHHmmStrFromDatePoint:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSDate *)dateFromComponents:(NSDateComponents *)comp
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [calendar dateFromComponents:comp];
    return date;
}

+ (NSDateComponents *)compsFromNow
{
    NSDate *date = [NSDate date];
    NSDateComponents *comps = [MEDDateUtils compsFromDate:date];
    return comps;
}

+ (NSDateComponents *)compsFromDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear) fromDate:date];
    return comps;
}

+ (int)timeFromDateStr:(NSString *)dateStr
{
    NSDate *date = [MEDDateUtils dateFromTimeStr:dateStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger flagUnits = NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *comps = [calendar components:flagUnits fromDate:date];
    
    int hour = (int)comps.hour;
    int minute = (int)comps.minute;
    int time = hour*60+minute;
    return time;
}

+ (NSString *)dateYYMMFromDate:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)dateyyyyMMStrFromDate:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}


+ (NSDate *)dateFromDateyyyyMMStr:(NSString *)dateStr
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

// to 0:0:0
+ (NSDate *) dateAdjustZero:(NSDate *) date {
    NSDate *beginningOfWeek = nil;
    NSTimeInterval interval = 0;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&beginningOfWeek interval:&interval forDate: date];
    return beginningOfWeek;
}

+ (NSDate *)dateFromDateyyyyMMddStr:(NSString *)dateStr
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

+ (NSString *)dateyyyyMMddStrFromDate:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSDate *)dateFromDateMMddStr:(NSString *)dateStr
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

+ (NSString *)dateMMddStrFromDate:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSDate *)dateFromDateyyyyMMddHHmmssStr:(NSString *)dateStr
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

+ (NSString *)dateyyyyMMddHHmmssStrFromDate:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}


+ (NSDate *)getDayFromDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    return [gregorian dateFromComponents:dayComponents];
}

+ (NSDate *)getWeekFromDate:(NSDate *)date
{
    if (date == nil) {
        date = [NSDate date];
    }
    double interval = 0;
    __autoreleasing NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&beginDate interval:&interval forDate:date];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }
    return beginDate;
}

+ (NSDate *)getMonthFromDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
    return [gregorian dateFromComponents:dayComponents];
}

+ (NSDate *)getYearFromDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitYear fromDate:date];
    return [gregorian dateFromComponents:dayComponents];
}

+ (NSString *)formatDateStrWithDate:(NSDate *)date
{
    NSString *dateStr = nil;
    NSDate *curDate = [NSDate date];
    
    NSDate *monthDate = [MEDDateUtils getMonthFromDate:date];
    NSDate *curMonthDate = [MEDDateUtils getMonthFromDate:curDate];
    if ([monthDate isEqualToDate:curMonthDate]) {
        NSTimeInterval timeCha = [curDate timeIntervalSinceDate:date];
        if (timeCha < MINUTE_SECOND_TIMES) {
            dateStr = [NSString stringWithFormat:@"%.0f%@%@", timeCha, NSLocalStr("Second", "Common"), NSLocalStr("Before", "Common")];
        } else if (timeCha < HOUR_SECOND_TIMES) {
            dateStr = [NSString stringWithFormat:@"%.0f%@%@", timeCha / MINUTE_SECOND_TIMES, NSLocalStr("Minute", "Common"), NSLocalStr("Before", "Common")];
        } else if (timeCha < DAY_SECOND_TIMES) {
            dateStr = [NSString stringWithFormat:@"%.0f%@%@", timeCha / HOUR_SECOND_TIMES, NSLocalStr("Hour", "Common"), NSLocalStr("Before", "Common")];
        } else {
            dateStr = [NSString stringWithFormat:@"%.0f%@%@", timeCha / DAY_SECOND_TIMES, NSLocalStr("Day", "Common"), NSLocalStr("Before", "Common")];
        }
        if (timeCha < 0) {
            dateStr = NSLocalStr("GangGang", "Common");
        }
    } else {
        NSDate *yearDate = [MEDDateUtils getYearFromDate:date];
        NSDate *curYearDate = [MEDDateUtils getYearFromDate:curDate];
        if ([yearDate isEqualToDate:curYearDate]) {
            dateStr = [MEDDateUtils dateMMddStrFromDate:date];
        } else {
            dateStr = [MEDDateUtils dateyyyyMMddStrFromDate:date];
        }
    }
    
    return dateStr;
}

+ (NSString *) getFullStringFromDate:(NSDate *) date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

@end
