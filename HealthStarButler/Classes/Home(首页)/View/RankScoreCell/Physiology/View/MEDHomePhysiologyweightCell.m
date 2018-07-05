//
//  MEDHomePhysiologyweightCell.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDHomePhysiologyweightCell.h"
#import "MEDHomePhysiologyModel.h"


static NSString *const cellID = @"homePhysiologyWieghtCell";

@interface MEDHomePhysiologyweightCell ()

@property (weak, nonatomic) IBOutlet UILabel *height;
@property (weak, nonatomic) IBOutlet UILabel *weight;
@property (weak, nonatomic) IBOutlet UILabel *BMI;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *dataTime;

@end

@implementation MEDHomePhysiologyweightCell

+ (instancetype)weightCellWithTableView:(UITableView *)tableView {

    MEDHomePhysiologyweightCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MEDHomePhysiologyweightCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setWeightData:(NSArray *)weightData {
    _weightData = weightData;
    if ((weightData != nil && ![weightData isKindOfClass:[NSNull class]] && weightData.count != 0)) {
        for (NSDictionary *dict in weightData) {
            MEDHomePhysiologyModel *model = [MEDHomePhysiologyModel physiologyWithDict:dict];
            
            if ([model.name isEqualToString:@"height"]) {
                self.height.text = model.actualValue;
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
            
            if ([model.name isEqualToString:@"weight"]) {
                self.weight.text = model.actualValue;
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
            
            if ([model.name isEqualToString:@"bmi"]) {
                self.BMI.text = model.actualValue;
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
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
