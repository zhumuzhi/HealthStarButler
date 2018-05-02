//
//  MEDCompanyRankHeadView.m
//  健康之星管家
//
//  Created by 朱慕之 on 2017/8/19.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDCompanyRankHeadView.h"
#import "MEDCompanyRankModel.h"

@interface MEDCompanyRankHeadView ()

@property (weak, nonatomic) IBOutlet UIButton *rankLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *score;

@end

@implementation MEDCompanyRankHeadView


+ (instancetype)rankHeadView {
    return [[[NSBundle mainBundle] loadNibNamed:@"MEDCompanyRankHeadView" owner:nil options:nil] lastObject];
}

- (void)setRankModel:(MEDCompanyRankModel *)rankModel {
    _rankModel = rankModel;
    
    _rankModel = rankModel;
    
    [self.rankLabel setTitle:[NSString stringWithFormat:@"%ld",(long)rankModel.ranking] forState:UIControlStateNormal];
    self.nameLabel.text = rankModel.name;
    self.companyLabel.text = rankModel.orgName;
    self.score.text = [NSString stringWithFormat:@"%.1f",rankModel.personalTotalScore];
    if (rankModel.icon) {
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:rankModel.icon] placeholderImage:[UIImage imageNamed:@"list_denglutouxiang"]];
    }
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconView.layer.cornerRadius = 25;

}

@end
