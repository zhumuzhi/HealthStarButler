//
//  MEDHomeHabitSleepCell.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDHomeHabitSleepCell : UITableViewCell

@property (nonatomic, strong) NSArray *sleepData;

+ (instancetype)habitSleepCellWithTableView:(UITableView *)tableView;

@end
