//
//  MEDHomePhysiologyWaistlineCell.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/17.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDHomePhysiologyWaistlineCell.h"
#import "MEDHomePhysiologyModel.h"


@interface MEDHomePhysiologyWaistlineCell ()

@property (weak, nonatomic) IBOutlet UILabel *waist;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *dataTime;
@end

@implementation MEDHomePhysiologyWaistlineCell

static NSString *const cellID = @"homePhysiologyWaistlineCell";

+ (instancetype)waistlineCellWithTableView:(UITableView *)tableView {
    
    MEDHomePhysiologyWaistlineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MEDHomePhysiologyWaistlineCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setWaistlineData:(NSArray *)waistlineData {
    _waistlineData = waistlineData;
    
    if ((waistlineData != nil && ![waistlineData isKindOfClass:[NSNull class]] && waistlineData.count != 0)) {
        for (NSDictionary *dict in waistlineData) {
            MEDHomePhysiologyModel *model = [MEDHomePhysiologyModel physiologyWithDict:dict];
            
            if ([model.name isEqualToString:@"waistline"]) {
                self.waist.text = model.actualValue;
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
