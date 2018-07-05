//
//  MEDHomeHabitSportCell.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDHomeHabitSportCell.h"
#import "MEDHomePhysiologyModel.h"

@interface MEDHomeHabitSportCell ()
@property (weak, nonatomic) IBOutlet UILabel *suggestValue;
@property (weak, nonatomic) IBOutlet UILabel *actualValue;
@property (weak, nonatomic) IBOutlet UILabel *dataTime;
@property (weak, nonatomic) IBOutlet UILabel *state;

@end

@implementation MEDHomeHabitSportCell

static NSString *const homeHabitSportCellID = @"homeHabitSportCellID";

+ (instancetype)habitSportCellWithTableView:(UITableView *)tableView
{
    MEDHomeHabitSportCell *cell = [tableView dequeueReusableCellWithIdentifier:homeHabitSportCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MEDHomeHabitSportCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setSportData:(NSArray *)sportData {
    _sportData = sportData;
    if (sportData != nil && ![sportData isKindOfClass:[NSNull class]] && sportData.count != 0) {
        for (NSDictionary *dict in sportData) {
            MEDHomePhysiologyModel *model = [MEDHomePhysiologyModel physiologyWithDict:dict];
            if ([model.name isEqualToString:@"sport"]) {
                self.actualValue.text = model.actualValue;
                self.suggestValue.text = model.suggestValue;
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
