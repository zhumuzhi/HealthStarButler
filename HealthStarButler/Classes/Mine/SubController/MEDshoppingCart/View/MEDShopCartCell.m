//
//  MEDShopCartCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/21.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDShopCartCell.h"
#import "MEDShopCartModel.h"

@interface MEDShopCartCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;

@end

@implementation MEDShopCartCell

- (void)setGoods:(MEDShopCartModel *)goods {
    _goods = goods;
    self.goodImageView.image = [UIImage imageNamed:goods.image];
    self.nameLabel.text = goods.name;
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@", goods.money];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
