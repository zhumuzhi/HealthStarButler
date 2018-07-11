//
//  MZSettingCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/11.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZSettingItem;

@interface MZSettingCell : UITableViewCell

@property (nonatomic, strong) MZSettingItem *item;

+ (id)settingCellWithTableView:(UITableView *)tableView;

@end
