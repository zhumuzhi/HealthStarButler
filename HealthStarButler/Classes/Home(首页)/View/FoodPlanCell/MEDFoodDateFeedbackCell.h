//
//  MEDFoodDateFeedbackCell.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/8.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEDFeedBackModel.h"

@interface MEDFoodDateFeedbackCell : UITableViewCell
 
@property (weak, nonatomic) IBOutlet UILabel *summarizelabel;

@property (weak, nonatomic) IBOutlet UILabel *caloricIntakeLabel;

@property (weak, nonatomic) IBOutlet UILabel *basicMetabolismLabel;

@property (weak, nonatomic) IBOutlet UIImageView *symbolImageView;

@property (weak, nonatomic) IBOutlet UITextView *detailLabel;

@property (nonatomic, strong) MEDFeedBackModel *feedModel;

+ (instancetype)feedbackCellWithTableView:(UITableView *)tableView;




@end
