//
//  MEDHomeMonitorCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/3.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDHomeMonitorCell : UITableViewCell

@property (nonatomic, copy) void (^monitorBtnClicked)(UIButton *button);

+ (instancetype)homeMonitorCellWithTableView:(UITableView *)tableView;

@end
