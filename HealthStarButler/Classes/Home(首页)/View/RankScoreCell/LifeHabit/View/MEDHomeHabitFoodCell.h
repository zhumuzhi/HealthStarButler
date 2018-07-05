//
//  MEDHomeHabitFoodCell.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDHomeHabitFoodCell : UITableViewCell

/** 查看详情 */
@property (weak, nonatomic) IBOutlet UIButton *SeeDetails;

@property (nonatomic, strong) NSArray *foodData;

+ (instancetype)habitFoodCellWithTableView:(UITableView *)tableView;

@end
