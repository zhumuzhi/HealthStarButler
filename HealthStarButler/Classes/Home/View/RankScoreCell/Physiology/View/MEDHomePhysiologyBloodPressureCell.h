//
//  MEDHomePhysiologyBloodPressureCell.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDHomePhysiologyBloodPressureCell : UITableViewCell

@property (nonatomic, strong) NSArray *bloodPressureData;

+ (instancetype)bloodPressureCellWithTableView:(UITableView *)tableView;

@end
