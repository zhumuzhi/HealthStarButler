//
//  MEDHomeHabitFoodCell.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDHomeHabitFoodCell.h"
#import "MEDHomePhysiologyModel.h"


@interface MEDHomeHabitFoodCell ()
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *dataTime;

@end


@implementation MEDHomeHabitFoodCell

static NSString *const homeHabitFoodCellID = @"homeHabitFoodCell";

+ (instancetype)habitFoodCellWithTableView:(UITableView *)tableView
{
    MEDHomeHabitFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:homeHabitFoodCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MEDHomeHabitFoodCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setFoodData:(NSArray *)foodData {
    _foodData = foodData;
    
    if ((foodData != nil && ![foodData isKindOfClass:[NSNull class]] && foodData.count != 0)) {
        for (NSDictionary *dict in foodData) {
            MEDHomePhysiologyModel *model = [MEDHomePhysiologyModel physiologyWithDict:dict];
            
            if ([model.name isEqualToString:@"food"]) {
                self.state.text = model.actualValue;
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
