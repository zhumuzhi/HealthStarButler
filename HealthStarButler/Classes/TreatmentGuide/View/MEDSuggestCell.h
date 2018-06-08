//
//  MEDSuggestCell.h
//  健康之星管家
//
//  Created by 夏帅 on 15/11/13.
//  Copyright (c) 2015年 Meridian. All rights reserved.

//   智能导诊选中病情提交之后的页面下面对应的cell

#import <UIKit/UIKit.h>
#import "KDGoalBar.h"

@interface MEDSuggestCell : UITableViewCell

@property (nonatomic, strong) KDGoalBar *firstGoalBar;

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UILabel *subLable;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)addPercent:(int)percent andTitle:(NSString *)title andSub:(NSString *)sub;

@end
