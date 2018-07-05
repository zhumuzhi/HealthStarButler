//
//  MEDCompanyRankCell.m
//  健康之星管家
//
//  Created by 朱慕之 on 2017/8/19.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDCompanyRankCell.h"
#import "MEDCompanyRankModel.h"

@interface MEDCompanyRankCell ()


@property (weak, nonatomic) IBOutlet UIButton *rankButton;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation MEDCompanyRankCell

static  NSString *cellID = @"CompanyRankingCell";

+ (instancetype)rankCellWithTableView:(UITableView *)tableView {
    MEDCompanyRankCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MEDCompanyRankCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setRankModel:(MEDCompanyRankModel *)rankModel {
    _rankModel = rankModel;
    
    if (rankModel.ranking == 1) {
        [self.rankButton setImage:[UIImage imageNamed:@"No1"] forState:UIControlStateNormal];
        [self.rankButton setTitle:@"" forState:UIControlStateNormal];
    }else if (rankModel.ranking == 2) {
        [self.rankButton setImage:[UIImage imageNamed:@"No2"] forState:UIControlStateNormal];
        [self.rankButton setTitle:@"" forState:UIControlStateNormal];
    }else if (rankModel.ranking == 3) {
        [self.rankButton setImage:[UIImage imageNamed:@"No3"] forState:UIControlStateNormal];
        [self.rankButton setTitle:@"" forState:UIControlStateNormal];
    }else {
        [self.rankButton setTitle:[NSString stringWithFormat:@"%ld",(long)rankModel.ranking] forState:UIControlStateNormal];
        [self.rankButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }

    self.nameLabel.text = rankModel.name;
    self.companyLabel.text = rankModel.orgName;
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f",rankModel.personalTotalScore];
    if (rankModel.icon) {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:rankModel.icon]placeholderImage:[UIImage imageNamed:@"list_denglutouxiang"]];
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.icon.layer.cornerRadius = 15;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
