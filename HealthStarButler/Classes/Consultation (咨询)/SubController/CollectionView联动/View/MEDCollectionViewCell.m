//
//  MEDCollectionViewCell.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2018/3/20.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import "MEDCollectionViewCell.h"
#import "MEDCollectionCategoryModel.h"

@interface MEDCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *name;

@end

@implementation MEDCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, self.frame.size.width-4, self.frame.size.width-4)];
        self.imageV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageV];
    
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(2, self.frame.size.width+2, self.frame.size.width-4, 20)];
        self.name.font = [UIFont systemFontOfSize:13];
        self.name.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.name];
    }
    return self;
}

- (void)setModel:(MEDSubCategoryModel *)model
{
    _model = model;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
    self.name.text = model.name;
}


@end
