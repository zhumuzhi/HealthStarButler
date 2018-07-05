//
//  MEDBloodPressureCell.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/10/16.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MEDBloodpressureModel;

@interface MEDBloodPressureCell : UITableViewCell

@property (nonatomic, strong) MEDBloodpressureModel *model;

+ (instancetype)bloodPressureCellWithTableView:(UITableView *)tableView;

@end
