//
//  MEDBloodPressureCell.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/10/16.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDBloodPressureCell.h"
#import "MEDBloodpressureModel.h"

@interface MEDBloodPressureCell ()

@property (weak, nonatomic) IBOutlet UILabel *measDate;
@property (weak, nonatomic) IBOutlet UILabel *dataValue1;
@property (weak, nonatomic) IBOutlet UILabel *dataValue2;
@property (weak, nonatomic) IBOutlet UILabel *subDataValue;

@end

@implementation MEDBloodPressureCell

+ (instancetype)bloodPressureCellWithTableView:(UITableView *)tableView {
    static NSString *bloodPressureCellID = @"bloodPressureCell";
    MEDBloodPressureCell *cell = [tableView dequeueReusableCellWithIdentifier:bloodPressureCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MEDBloodPressureCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setModel:(MEDBloodpressureModel *)model {
    _model = model;
    
    //日期
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:model.meas_date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd日   HH:mm";
    NSString *DateStr = [formatter stringFromDate:date];
    self.measDate.text = DateStr;
    
    //数据值
    self.dataValue1.text = model.systolic;     //高低
    self.dataValue2.text = model.diastolic;    //低压
    NSString *subValueString = [NSString stringWithFormat:@"脉搏: %@ 次/分钟", model.heartrate];
    self.subDataValue.text = subValueString;   //心率
    
    //报警颜色 (0：告警，1：正常)
    if ([model.systolic_is_alarm intValue] == 0 ) {
        self.dataValue1.textColor = [UIColor redColor];
    }
    if ([model.diastolic_is_alarm intValue] == 0) {
        self.dataValue2.textColor = [UIColor redColor];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
}

@end
