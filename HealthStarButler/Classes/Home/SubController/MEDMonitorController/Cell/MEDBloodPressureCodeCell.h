//
//  MEDBloodPressureCodeCell.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/11/8.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MEDBloodpressureModel;

@interface MEDBloodPressureCodeCell : UITableViewCell

@property (nonatomic, strong) MEDBloodpressureModel *bloodpressureModel;
+ (instancetype)bloodPressureCellWithTableView:(UITableView *)tableView;

@end
