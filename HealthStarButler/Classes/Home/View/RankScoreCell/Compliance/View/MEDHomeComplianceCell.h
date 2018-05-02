//
//  MEDHomeComplianceCell.h
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/15.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MEDHomeComplianceModel;
@interface MEDHomeComplianceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UILabel *fillNum;
@property (weak, nonatomic) IBOutlet UILabel *totleNum;

@property (nonatomic, strong) MEDHomeComplianceModel *complianceModel;

+ (instancetype)complianceCellWithTableView:(UITableView *)tableView;
@end
