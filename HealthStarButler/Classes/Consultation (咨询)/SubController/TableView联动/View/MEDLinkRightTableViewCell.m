//
//  MEDLinkRightTableViewCell.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2018/3/20.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import "MEDLinkRightTableViewCell.h"
#import "MEDCategoryModel.h"

@interface MEDLinkRightTableViewCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation MEDLinkRightTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        [self.contentView addSubview:self.imageV];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 30)];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.nameLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, 200, 30)];
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        self.priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceLabel];
    }
    return self;
}

- (void)setModel:(MEDFoodModel *)model {
    _model = model;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.picture]];
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"$%@",@(model.min_price)];
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
