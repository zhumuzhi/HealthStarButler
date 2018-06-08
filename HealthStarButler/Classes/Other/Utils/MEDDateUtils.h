//
//  MEDDateUtils.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/8.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DNUDatePickerMode)
{
    DNUDatePickerModeTime,           // Displays hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. 6 | 53 | PM)
    DNUDatePickerModeDate,           // Displays month, day, and year depending on the locale setting (e.g. November | 15 | 2007)
    DNUDatePickerModeDateAndTime,    // Displays date, hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. Wed Nov 15 | 6 | 53 | PM)
    DNUDatePickerModeCursoryDate     // Displays month, Year (e.g Nov | 2014)
};

extern NSTimeInterval const dateUtilsMinuteTime;
extern NSTimeInterval const dateUtilsHourTime;
extern NSTimeInterval const dateUtilsDayTime;

static NSTimeInterval const MINUTE_SECOND_TIMES = 60;
static NSTimeInterval const HOUR_SECOND_TIMES = 3600;
static NSTimeInterval const DAY_SECOND_TIMES = 86400;


@interface MEDDateUtils : NSObject

+ (NSString *)timeStrFromDate:(NSDate *)date;
+ (NSDate *)dateFromTimeStr:(NSString *)timeStr;

+ (int)currentWeekday;

+ (NSDateComponents *)compsFromNow;
+ (NSDateComponents *)compsFromDate:(NSDate *)date;

+ (NSDate *)dateFromComponents:(NSDateComponents *)comp;

+ (int)timeFromDateStr:(NSString *)dateStr;

+ (NSString *)dateyyyyMMStrFromDate:(NSDate *)date;
+ (NSString *)dateYYMMFromDate:(NSDate *)date;
+ (NSDate *)dateFromDateyyyyMMStr:(NSString *)dateStr;
+ (NSDate *) dateAdjustZero:(NSDate *) date;

+ (NSDate *)dateFromDateyyyyMMddStr:(NSString *)dateStr;
+ (NSString *)dateyyyyMMddStrFromDate:(NSDate *)date;

+ (NSDate *)dateFromDateMMddStr:(NSString *)dateStr;
+ (NSString *)dateMMddStrFromDate:(NSDate *)date;
+ (NSString *)dateHHmmStrFromDatePoint:(NSDate *)date;
+ (NSDate *)dateFromDateyyyyMMddHHmmssStr:(NSString *)dateStr;
+ (NSString *)dateyyyyMMddHHmmssStrFromDate:(NSDate *)date;

+ (NSString *)dateMMddStrFromDatePoint:(NSDate *)date;
+ (NSString *)dateYYMMddStrFromDatePoint:(NSDate *)date;

/**
 *  @Author Mr.Li, 14-10-13 12
 *
 *  @brief  获取某天的开始时间
 *
 *  @param date 任意时间
 *
 *  @return date当天的起始时间
 */
+ (NSDate *)getDayFromDate:(NSDate *)date;

/**
 *  @Author Mr.Li, 14-10-13 12
 *
 *  @brief  获取某个时间所在周的开始时间
 *
 *  @param date 任意时间
 *
 *  @return date 所在周的起始时间
 */
+ (NSDate *)getWeekFromDate:(NSDate *)date;

/**
 *  @Author Mr.Li, 14-10-13 12
 *
 *  @brief  获取某个时间所在月的开始时间
 *
 *  @param date 任意时间
 *
 *  @return date 所在月的起始时间
 */
+ (NSDate *)getMonthFromDate:(NSDate *)date;

/**
 *  @Author Mr.Li, 14-10-13 13
 *
 *  @brief  获取某个时间所在年的开始时间
 *
 *  @param date 任意时间
 *
 *  @return date 所在年的起始时间
 */
+ (NSDate *)getYearFromDate:(NSDate *)date;

+ (NSString *)formatDateStrWithDate:(NSDate *)date;

+ (NSString *) getFullStringFromDate:(NSDate *) date;


@end
