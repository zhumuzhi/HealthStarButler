//
//  MEDPersonalDatePickView.m
//  健康之星管家
//
//  Created by 朱慕之 on 2017/07/03.
//  Copyright © 2016年 Meridian. All rights reserved.
//

#import "MEDPersonalDatePickView.h"

@interface MEDPersonalDatePickView()
{
    NSString *_dateStr;
}
@property(strong, nonatomic) UIDatePicker *medDatePicker;

@end

@implementation MEDPersonalDatePickView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.227 alpha:0.5];
//        [self createPickerView];
    }
    return self;
}

#pragma mark -- 选择器
- (void)configuration {
    //时间选择器
    UIView *dateBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 200, [UIScreen mainScreen].bounds.size.width, 200)];
    dateBgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:dateBgView];
    
    //titleView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    titleView.backgroundColor = MEDRGBA(170, 170, 170, 1);
    [dateBgView addSubview:titleView];
    
    //确定按钮
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(dateBgView.bounds.size.width - 50, 0, 40, 44);
    commitBtn.tag = 1;
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(pressentPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [dateBgView addSubview:commitBtn];
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10, 0, 40, 44);
    cancelBtn.tag = 2;
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(pressentPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [dateBgView addSubview:cancelBtn];
    
    //日期选择View
    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 38, [UIScreen mainScreen].bounds.size.width, 162)];
    datePicker.datePickerMode = self.mode;
    NSDate *currentDate = [NSDate date];
    datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CHS_CN"]; //zh_CHS_CN
    
    if (self.fontColor) {
        [commitBtn setTitleColor:self.fontColor forState:UIControlStateNormal];
        [cancelBtn setTitleColor:self.fontColor forState:UIControlStateNormal];
    }
    
    //设置默认日期
    if (!self.date) {
        self.date = currentDate;
    }
    datePicker.date = self.date;
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    
    [formater setDateFormat:self.dateFormatter]; //设置日期格式
    
    _dateStr = [formater stringFromDate:self.date];
    
    NSString *tempStr = [formater stringFromDate:self.date];
    NSArray *dateArray = [tempStr componentsSeparatedByString:@"-"];
    
    datePicker.maximumDate = [NSDate date];
    
    //设置日期选择器最大可选日期
    if (self.maxYear) {
        NSInteger maxYear = [dateArray[0] integerValue] - self.maxYear;
//        NSLog(@"self的最大为:%ld", self.maxYear);
//        NSLog(@"最大可选日期为:%ld", maxYear);
        NSString *maxStr = [NSString stringWithFormat:@"%ld-%@-%@",(long)maxYear,dateArray[1],dateArray[2]];
        NSDate *maxDate = [formater dateFromString:maxStr];
        datePicker.maximumDate = maxDate;
    }

    //设置日期选择器最小可选日期
    if (self.minYear) {
        
        NSInteger minYear = [dateArray[0] integerValue] - self.minYear;
        NSString *minStr = [NSString stringWithFormat:@"%ld-%@-%@",(long)minYear,dateArray[1],dateArray[2]];
        NSDate* minDate = [formater dateFromString:minStr];
        datePicker.minimumDate = minDate;
    }
    
    [dateBgView addSubview: datePicker];
    self.medDatePicker = datePicker;
    
    [self.medDatePicker addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark -- 时间选择器确定/取消
- (void)pressentPickerView:(UIButton *)button {
    if (button.tag == 1) { //1确定2取消
        self.completeBlock(_dateStr);
    }
    [self removeFromSuperview];
}

#pragma mark -- 时间选择器日期改变
-(void)selectDate:(id)sender {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:self.dateFormatter];
    _dateStr =[outputFormatter stringFromDate:self.medDatePicker.date];
    
}

@end
