//
//  MEDBloodPressureCodeCell.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/11/8.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDBloodPressureCodeCell.h"
#import "MEDBloodpressureModel.h"

@interface MEDBloodPressureCodeCell ()

@property (nonatomic, weak) UIImageView *image;
@property (nonatomic, weak) UILabel *date;
@property (nonatomic, weak) UILabel *type;
@property (nonatomic, weak) UILabel *value1;
@property (nonatomic, weak) UILabel *separator;
@property (nonatomic, weak) UILabel *value2;
@property (nonatomic, weak) UILabel *subValue;
@property (nonatomic, weak) UILabel *unit;

@end

@implementation MEDBloodPressureCodeCell

+ (instancetype)bloodPressureCellWithTableView:(UITableView *)tableView
{
    static NSString *bloodPressureCellID = @"bloodPressureCell";
    MEDBloodPressureCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:bloodPressureCellID];
    if (cell == nil) {
        cell = [[MEDBloodPressureCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bloodPressureCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        self.image = image;
        
        UILabel *date = [[UILabel alloc] init];
        date.font = [UIFont systemFontOfSize:13];
        date.textColor = MEDGrayColor(102);
        [self.contentView addSubview:date];
        self.date = date;
        
        UILabel *type = [[UILabel alloc] init];
        type.font = [UIFont systemFontOfSize:13];
        type.textColor = MEDGrayColor(40);
        [self.contentView addSubview:type];
        self.type = type;
        
        UILabel *systolic = [[UILabel alloc] init];
        systolic.font = [UIFont systemFontOfSize:13];
        systolic.textColor = MEDGrayColor(40);
        [self.contentView addSubview:systolic];
        self.value1 = systolic;
        
        UILabel *separator = [[UILabel alloc] init];
        separator.font = [UIFont systemFontOfSize:13];
        separator.textColor = MEDGrayColor(40);
        [self.contentView addSubview:separator];
        self.separator = separator;
        
        UILabel *diastolic = [[UILabel alloc] init];
        diastolic.font = [UIFont systemFontOfSize:13];
        diastolic.textColor = MEDGrayColor(40);
        [self.contentView addSubview:diastolic];
        self.value2 = diastolic;
        
        UILabel *unit = [[UILabel alloc] init];
        unit.font = [UIFont systemFontOfSize:13];
        unit.textColor = MEDGrayColor(40);
        [self.contentView addSubview:unit];
        self.unit = unit;
        
        UILabel *heartRate = [[UILabel alloc] init];
        heartRate.font = [UIFont systemFontOfSize:13];
        heartRate.textColor = MEDGrayColor(40);
        [self.contentView addSubview:heartRate];
        self.subValue = heartRate;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imageFX = 10;
    CGFloat imageFY = 10;
    CGFloat imageFW = 10;
    CGFloat imageFH = 10;

    CGFloat dateFX = 30;
    CGFloat dateFY = imageFY;
    CGFloat dateFW = 80;
    CGFloat dateFH = 20;
    self.date.frame = CGRectMake(dateFX, dateFY, dateFW, dateFH);
    [self.date sizeToFit];
    
    self.image.frame = CGRectMake(imageFX, imageFY, imageFW, imageFH);
    self.image.image = [UIImage imageNamed:@"homeCellPoint"];
    self.image.centerY = self.date.centerY;
    
    CGFloat typeFX = self.date.right + 30;
    CGFloat typeFY = imageFY;
    CGFloat typeFW = 40;
    CGFloat typeFH = 20;
    self.type.frame = CGRectMake(typeFX, typeFY, typeFW, typeFH);
    self.type.centerY = self.image.centerY;
    self.type.text = @"血压:";
    [self.type sizeToFit];
    
    CGFloat systolicFX = self.type.right;
    CGFloat systolicFY = imageFY;
    CGFloat systolicFW = 30;
    CGFloat isystolicFH = 20;
    self.value1.frame = CGRectMake(systolicFX, systolicFY, systolicFW, isystolicFH);
    self.value1.centerY = self.image.centerY;
    [self.value1 sizeToFit];
    
    CGFloat separatorFX = self.value1.right;
    CGFloat separatorFY = imageFY;
    CGFloat separatorFW = 10;
    CGFloat separatorFH = 20;
    self.separator.frame = CGRectMake(separatorFX, separatorFY, separatorFW, separatorFH);
    self.separator.centerY = self.image.centerY;
    self.separator.text = @"/";
    [self.separator sizeToFit];
    
    CGFloat diastolicFX = self.separator.right;
    CGFloat diastolicFY = imageFY;
    CGFloat diastolicFW = 30;
    CGFloat diastolicFH = 20;
    self.value2.frame = CGRectMake(diastolicFX, diastolicFY, diastolicFW, diastolicFH);
    self.value2.centerY = self.image.centerY;
    [self.value2 sizeToFit];
    
    CGFloat unitFX = self.value2.right;
    CGFloat unitFY = imageFY;
    CGFloat unitFW = 45;
    CGFloat unitFH = 20;
    self.unit.frame = CGRectMake(unitFX, unitFY, unitFW, unitFH);
    self.unit.centerY = self.image.centerY;
    self.unit.text = @"mmHg";
    [self.unit sizeToFit];
    
    CGFloat heartRateFX = self.type.left;
    CGFloat heartRateFY = self.type.bottom + 10;
    CGFloat heartRateFW = 100;
    CGFloat heartRateFH = 20;
    self.subValue.frame = CGRectMake(heartRateFX, heartRateFY, heartRateFW, heartRateFH);
    [self.subValue sizeToFit];
    
}

-(void)setBloodpressureModel:(MEDBloodpressureModel *)bloodpressureModel {
    _bloodpressureModel = bloodpressureModel;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:bloodpressureModel.meas_date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd日   HH:mm";
    NSString *DateStr = [formatter stringFromDate:date];
    self.date.text = DateStr;
    
    self.value1.text = bloodpressureModel.systolic;
    self.value2.text = bloodpressureModel.diastolic;
    
    self.subValue.text = [NSString stringWithFormat:@"脉搏:%@次/分钟",bloodpressureModel.heartrate];
    
    //报警颜色 (0：告警，1：正常)
    if ([bloodpressureModel.systolic_is_alarm intValue] == 0 ) {
        self.value1.textColor = [UIColor redColor];
    }
    if ([bloodpressureModel.diastolic_is_alarm intValue] == 0) {
        self.value2.textColor = [UIColor redColor];
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
