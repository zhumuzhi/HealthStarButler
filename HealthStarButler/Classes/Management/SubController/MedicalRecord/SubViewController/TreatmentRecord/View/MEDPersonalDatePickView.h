//
//  MEDPersonalDatePickView.h
//  健康之星管家
//
//  Created by 朱慕之 on 2017/07/03.
//  Copyright © 2016年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MyBlockType)(NSString *selectDate);

@interface MEDPersonalDatePickView : UIView

/** 距离当前日期最大年份差（>0小于当前日期，<0 当前日期） */
@property(assign, nonatomic) NSInteger maxYear;

/** 距离当前日期最小年份差 */
@property(assign, nonatomic) NSInteger minYear;

/** 默认显示日期 */
@property (strong, nonatomic) NSDate *date;

/** 日期回调 */
@property(copy, nonatomic) MyBlockType completeBlock;

/** 设置确认/取消字体颜色(默认为黑色) */
@property (strong, nonatomic) UIColor *fontColor;

/** 设置系统模式 */
@property (nonatomic, assign) UIDatePickerMode mode;

@property (nonatomic, copy) NSString *dateFormatter;

//配置
- (void)configuration;

@end
