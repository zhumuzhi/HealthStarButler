//
//  MEDMonitorDateView.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/10/13.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDMonitorDateView.h"

@interface MEDMonitorDateView ()

@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UIButton *nextButton;
@property (nonatomic, weak) UIButton *previousButton;

/**
 当前日期String
 */
@property (nonatomic, copy) NSString *currentDateStr;

@end

@implementation MEDMonitorDateView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame textColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:15] previousButton:@"" NextButon:@""];
}

- (instancetype)initWithFrame:(CGRect)frame
                    textColor:(UIColor *)color
                     textFont:(UIFont *)font
               previousButton:(NSString *)previousImage
                    NextButon:(NSString *)nextImage {
    
    if (self = [super initWithFrame:frame]) {
        //背景View
        UIView *dateBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        dateBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:dateBackView];
//        dateBackView.backgroundColor = [UIColor brownColor];

        //日期Lanbel
        UILabel *dateLabel = [[UILabel alloc] init];
        [dateBackView addSubview:dateLabel];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.font = font;
        dateLabel.textColor = color;
        self.dateLabel = dateLabel;
        //初始化后需要拿到当日时间
        self.currentDateStr = [self dateyyyyMMStrFromDate:[NSDate date]];
        dateLabel.text = self.currentDateStr;
//        dateLabel.backgroundColor = [UIColor redColor];
        
        //上月按钮
        UIButton *preButton = [UIButton buttonWithType:UIButtonTypeCustom];
        preButton.adjustsImageWhenHighlighted = NO;
        preButton.backgroundColor = [UIColor whiteColor];
        [dateBackView addSubview:preButton];
        preButton.tag = 1;
        [preButton setImage:[UIImage imageNamed:previousImage] forState:UIControlStateNormal];
        [preButton addTarget:self action:@selector(dateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.previousButton = preButton;
//        preButton.backgroundColor = [UIColor blueColor];
    
        //下月按钮
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        nextButton.adjustsImageWhenHighlighted = NO;
        nextButton.backgroundColor = [UIColor whiteColor];
        [dateBackView addSubview:nextButton];
        nextButton.tag = 2;
        [nextButton setImage:[UIImage imageNamed:nextImage] forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(dateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.nextButton = nextButton;
//        nextButton.backgroundColor = [UIColor greenColor];
        
    }
    return self;
}

#pragma mark - layout
- (void)layoutSubviews {
    
    CGFloat FWidth = self.frame.size.width;
    CGFloat DateLblW = 120;
    CGFloat DateLblX = FWidth*0.5 - DateLblW*0.5;
    
    CGFloat BtnWH = self.frame.size.height;
    
    self.dateLabel.frame = CGRectMake(DateLblX, 0, DateLblW, BtnWH);
    self.previousButton.frame = CGRectMake(DateLblX-BtnWH, 0, BtnWH, BtnWH);
    self.nextButton.frame = CGRectMake(CGRectGetMaxX(self.dateLabel.frame), 0, BtnWH, BtnWH);
}


#pragma mark - Event
- (void)dateButtonClick:(UIButton *)dateButton {
    if (dateButton.tag == 1) {       //上个月
        //NSLog(@"点击了上个月按钮");
        NSDate *currentDate = [self dateFromDateyyyyMMStr:self.currentDateStr];
        NSDate *nextDate = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:currentDate];
        self.currentDateStr = [self dateyyyyMMStrFromDate:nextDate];
        
        //页面赋值
        self.dateLabel.text = self.currentDateStr;
        
        //起止日期
        NSString *startDateStr = [NSString stringWithFormat:@"%@-01",self.currentDateStr];
        NSString *endDateStr = [NSString stringWithFormat:@"%@-%d",self.currentDateStr,[self currentDays]];
    
        if(self.DateButtonClick) {
            self.DateButtonClick(startDateStr, endDateStr);
        }
        
    }else if (dateButton.tag == 2) { //下个月
        //NSLog(@"点击了下个月按钮");
        NSDate *currentDate = [self dateFromDateyyyyMMStr:self.currentDateStr];
        NSString *curStr = [self dateyyyyMMStrFromDate:[NSDate date]];
        if ([self.currentDateStr isEqualToString:curStr]) {
            self.currentDateStr = curStr;
            self.dateLabel.text = self.currentDateStr;
            return;
        }else {
            NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60*31 sinceDate:currentDate];
            self.currentDateStr = [self dateyyyyMMStrFromDate:nextDate];
        }
        
        //页面赋值
        self.dateLabel.text = self.currentDateStr;
        //起止日期
        NSString *startDateStr = [NSString stringWithFormat:@"%@-01",self.currentDateStr];
        NSString *endDateStr =[NSString stringWithFormat:@"%@-%d",self.currentDateStr,[self currentDays]];
        
        if(self.DateButtonClick) {
            self.DateButtonClick(startDateStr, endDateStr);
        }
    }
}

#pragma mark - initDate
- (void)getCurrrentDateResult:(void(^)(NSString *startDate,NSString *endDate))result {
    self.currentDateStr = [self dateyyyyMMStrFromDate:[NSDate date]];
    //起止日期
    NSString *startDateStr = [NSString stringWithFormat:@"%@-01",self.currentDateStr];
    NSString *endDateStr =[NSString stringWithFormat:@"%@-%d",self.currentDateStr,[self currentDays]];
    
    result(startDateStr ,endDateStr);
}


#pragma mark - 日期方法

- (NSString *)dateyyyyMMddStrFromDate:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

- (NSString *)dateyyyyMMStrFromDate:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

- (NSDate *)dateFromDateyyyyMMStr:(NSString *)dateStr {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

- (NSDate *)dateFromDateyyyyMMddStr:(NSString *)dateStr {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

//天数
- (int)currentDays {
    NSString *currentDateStr = [self dateyyyyMMddStrFromDate:[NSDate date]];
    NSArray *array = [currentDateStr componentsSeparatedByString:@"-"];
    NSString *str = [NSString stringWithFormat:@"%@-%@",[array objectAtIndex:0],[array objectAtIndex:1]];
    if ([str isEqualToString:self.dateLabel.text]) {
        return [[array objectAtIndex:2] intValue];
    } else{
        return [self numberDaysOfmonth];
    }
}

//月的天数
- (int)numberDaysOfmonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [self dateFromDateyyyyMMStr:self.dateLabel.text];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
//    return (int)days.length+1;
    return (int)days.length;
}

@end
