//
//  MEDHomePhysiologyBloodGlucoseCell.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDHomePhysiologyBloodGlucoseCell.h"
#import "MEDHomePhysiologyModel.h"

@interface MEDHomePhysiologyBloodGlucoseCell ()
@property (weak, nonatomic) IBOutlet UILabel *fbg;
@property (weak, nonatomic) IBOutlet UILabel *fbgDataTime;
@property (weak, nonatomic) IBOutlet UILabel *fbgState;

@property (weak, nonatomic) IBOutlet UILabel *meal2bg;
@property (weak, nonatomic) IBOutlet UILabel *meal2bgDataTime;
@property (weak, nonatomic) IBOutlet UILabel *meal2bgState;

@end

static NSString *const cellID = @"homePhysiologyBloodGlucoseCell";

@implementation MEDHomePhysiologyBloodGlucoseCell

+ (instancetype)bloodGlucoseCellWithTableView:(UITableView *)tableView {
    MEDHomePhysiologyBloodGlucoseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MEDHomePhysiologyBloodGlucoseCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)setBloodGlucoseData:(NSArray *)bloodGlucoseData {
    
    _bloodGlucoseData = bloodGlucoseData;
    
    if ((bloodGlucoseData != nil && ![bloodGlucoseData isKindOfClass:[NSNull class]] && bloodGlucoseData.count != 0)) {
        
        for (NSDictionary *dict in bloodGlucoseData) {
            MEDHomePhysiologyModel *model = [MEDHomePhysiologyModel physiologyWithDict:dict];
            
            if ([model.name isEqualToString:@"fbg"]) {
                self.fbg.text = model.actualValue;
                self.fbgDataTime.text = model.createTime;
                if (model.result == -1) {
                    self.fbgState.text = @"异常";
                    self.fbgState.textColor = MEDRGB(195, 103, 22);
                }
                if (model.result == 1) {
                    self.fbgState.text = @"达标";
                    self.fbgState.textColor = MEDRGB(145, 188, 15);
                }
            }
            
            if ([model.name isEqualToString:@"meal2bg"]) {
                self.meal2bg.text = model.actualValue;
                self.meal2bgDataTime.text = model.createTime;
                if (model.result == -1) {
                    self.meal2bgState.text = @"异常";
                    self.meal2bgState.textColor = MEDRGB(195, 103, 22);
                }
                if (model.result == 1) {
                    self.meal2bgState.text = @"达标";
                    self.meal2bgState.textColor = MEDRGB(145, 188, 15);
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
