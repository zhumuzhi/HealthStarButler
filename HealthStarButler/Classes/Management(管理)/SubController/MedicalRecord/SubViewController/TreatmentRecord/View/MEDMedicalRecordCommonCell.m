//
//  MEDMedicalRecordCommonCell.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/5.
//  Copyright © 2017年 mmednet. All rights reserved.
//  两个列表使用的cell

#import "MEDMedicalRecordCommonCell.h"
#import "MEDTestReportModel.h"
#import "MEDTreatmentRecordModel.h"


@interface MEDMedicalRecordCommonCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@end
@implementation MEDMedicalRecordCommonCell

+ (instancetype)cellWithTableView:(UITableView *)tableView Identifier:(NSString *)Identifier
{
    MEDMedicalRecordCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MEDMedicalRecordCommonCell" owner:nil options:nil] lastObject];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setTreatmentRecordModel:(MEDTreatmentRecordModel *)TreatmentRecordModel
{
    self.timeLbl.text = TreatmentRecordModel.diagnosisRreatTime;
    self.nameLbl.text = @"诊疗记录";
}

- (void)setTestReportModel:(MEDTestReportModel *)TestReportModel
{
    self.timeLbl.text = TestReportModel.detectionTime;
    self.nameLbl.text = @"检测报告";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
