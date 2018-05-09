//
//  MEDFoodDateFeedbackCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/8.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDFoodDateFeedbackCell.h"

@implementation MEDFoodDateFeedbackCell

#pragma mark - init
+ (instancetype)feedbackCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"FoodDateFeedback";
    MEDFoodDateFeedbackCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //设置重用cell
    if (cell == nil) { //如果cell为空新建cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MEDFoodDateFeedbackCell" owner:nil options:nil] lastObject];
        }
        return cell;
    }

#pragma mark - setData
- (void)setFeedModel:(MEDFeedBackModel *)feedModel {
    
    self.feedModel = feedModel;
    
    self.caloricIntakeLabel.text = feedModel.actualInputEneger;
    self.basicMetabolismLabel.text = feedModel.inputEnergyMax;
    self.symbolImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",feedModel.symbolImage]];
    self.summarizelabel.text = feedModel.allSumStr;
    self.detailLabel.text = feedModel.infoString;
    
}


#pragma mark - system method

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
