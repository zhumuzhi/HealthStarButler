//
//  MEDMonitorDateView.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/10/13.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MEDMonitorDateView : UIView
/** 月份变化的按钮点击 */
typedef void(^DateButtonAction)(NSString *startDate, NSString *endDate);

@property (nonatomic, copy) DateButtonAction DateButtonClick;

- (instancetype)initWithFrame:(CGRect)frame;

/**
 初始化方法
 @param frame           日期选择器的frame
 @param color           日期标题颜色
 @param font            日期标题字体
 @param previousImage   上个月按钮图片
 @param nextImage       下个月按钮图片
 */
- (instancetype)initWithFrame:(CGRect)frame
                    textColor:(UIColor *)color
                     textFont:(UIFont *)font
               previousButton:(NSString *)previousImage
                    NextButon:(NSString *)nextImage;

/**
 获取当前日期方法
 @param result 返回开始与结束日期字符串
 */
- (void)getCurrrentDateResult:(void(^)(NSString *startDate,NSString *endDate))result;

#pragma mark - 时间方法
/** 天数 */
- (int)currentDays;
/** 月的天数 */
- (int)numberDaysOfmonth;
- (NSString *)dateyyyyMMddStrFromDate:(NSDate *)date;
- (NSString *)dateyyyyMMStrFromDate:(NSDate *)date;
- (NSDate *)dateFromDateyyyyMMStr:(NSString *)dateStr;
- (NSDate *)dateFromDateyyyyMMddStr:(NSString *)dateStr;


@end
