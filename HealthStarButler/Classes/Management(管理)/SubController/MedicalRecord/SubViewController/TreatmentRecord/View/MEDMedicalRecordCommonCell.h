//
//  MEDMedicalRecordCommonCell.h
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/5.
//  Copyright © 2017年 mmednet. All rights reserved.
//  两个列表使用的cell

@class MEDTreatmentRecordModel;
@class MEDTestReportModel;

#import <UIKit/UIKit.h>

@interface MEDMedicalRecordCommonCell : UITableViewCell

@property (nonatomic, strong) MEDTreatmentRecordModel *TreatmentRecordModel;
@property (nonatomic, strong) MEDTestReportModel *TestReportModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView Identifier:(NSString *)Identifier;

@end
