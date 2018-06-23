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

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;

@end

@implementation MEDShopCartCell

// set data
- (void)setGoods:(MEDShopCartModel *)goods {
    _goods = goods;
    self.goodImageView.image = [UIImage imageNamed:goods.image];
    self.nameLabel.text = goods.name;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@", goods.money];
    
    // 根据模型的count属性决定countLabel显示的文字
    self.countLabel.text = [NSString stringWithFormat:@"%d",goods.count];
    // 根据模型的count属性决定减号按钮是否能点击
    self.minusButton.enabled = goods.count > 0;
    
}


#pragma mark - event

- (IBAction)plusClick {
    
    self.goods.count++;
//    [self setGoods:[self goods]];
//    self.goods = self.goods;
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.goods.count];
    self.minusButton.enabled = YES;
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"plusClickNotification" object:self];
}


- (IBAction)minusClick {
    
    self.goods.count--;
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.goods.count];
    if (self.goods.count == 0) {
        self.minusButton.enabled = NO;
    }
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"minusClickNotification" object:self];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
