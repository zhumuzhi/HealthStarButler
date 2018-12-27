//
//  FSPromotionTagsCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/27.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSPromotionTagsCell.h"

@interface FSPromotionTagsCell ()



@end

@implementation FSPromotionTagsCell

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self cofignUI];
        [self configration];
    }
    return self;
}

#pragma mark - configUI
- (void)cofignUI {
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
}

#pragma mark - configration
- (void)configration {
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor randomColor];
}

#pragma mark - LazyGet
- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor whiteColor];
        _title.backgroundColor = [UIColor lightGrayColor];
    }
    return _title;
}

@end
