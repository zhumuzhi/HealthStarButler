//
//  MEDHomePhysiologyBloodPressureCell.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDHomePhysiologyBloodPressureCell.h"
#import "MEDHomePhysiologyModel.h"

@interface MEDHomePhysiologyBloodPressureCell ()

@property (weak, nonatomic) IBOutlet UILabel *sbp;
@property (weak, nonatomic) IBOutlet UILabel *dbp;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *dataTime;

@end

static NSString *const cellID = @"homePhysiologyBloodPressureCell";

@implementation MEDHomePhysiologyBloodPressureCell

+ (instancetype)bloodPressureCellWithTableView:(UITableView *)tableView {
    MEDHomePhysiologyBloodPressureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MEDHomePhysiologyBloodPressureCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)setBloodPressureData:(NSArray *)bloodPressureData {
    _bloodPressureData = bloodPressureData;
    
    NSLog(@"数组的结果为:%@", bloodPressureData);
    
    if ((bloodPressureData != nil && ![bloodPressureData isKindOfClass:[NSNull class]] && bloodPressureData.count != 0)) {
        
        for (NSDictionary *dict in bloodPressureData) {
            MEDHomePhysiologyModel *model = [MEDHomePhysiologyModel physiologyWithDict:dict];
            
            if ([model.name isEqualToString:@"sbp"]) {
                self.sbp.text = model.actualValue;
                self.dataTime.text = model.createTime;
                if (model.result == -1) {
                    self.state.text = @"异常";
                    self.state.textColor = MEDRGB(195, 103, 22);
                }
                if (model.result == 1) {
                    self.state.text = @"达标";
                    self.state.textColor = MEDRGB(145, 188, 15);
                }
            }
            
            if ([model.name isEqualToString:@"dbp"]) {
                self.dbp.text = model.actualValue;
                self.dataTime.text = model.createTime;
                if (model.result == -1) {
                    self.state.text = @"异常";
                    self.state.textColor = MEDRGB(195, 103, 22);
                }
                if (model.result == 1) {
                    self.state.text = @"达标";
                    self.state.textColor = MEDRGB(145, 188, 15);
                }
            }
        }
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
