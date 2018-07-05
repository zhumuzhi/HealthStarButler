//
//  MEDHomePhysiologyBloodGlucoseCell.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEDHomePhysiologyBloodGlucoseCell : UITableViewCell
@property (nonatomic, strong) NSArray *bloodGlucoseData;
+ (instancetype)bloodGlucoseCellWithTableView:(UITableView *)tableView;

@end
