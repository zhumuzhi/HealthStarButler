//
//  FSMineAllOrderView.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/20.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSMineAllOrderView.h"

@interface FSMineAllOrderView ()

@end

@implementation FSMineAllOrderView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

#pragma mark - ConfigUI

static CGFloat arrowW = 6.0;  //指示View宽度

- (void)configUI {

    /** 箭头 */
    [self addSubview:self.arrowImage];
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self);
        make.width.equalTo(@(arrowW));
        make.height.equalTo(@(kMargin10));
    }];

    /** 订单标题 */
    [self addSubview:self.orderLabel];
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self.arrowImage.mas_left).offset(-10);
    }];
}

#pragma mark - LazySet
- (UILabel *)orderLabel {
    if (_orderLabel == nil) {
        _orderLabel = [[UILabel alloc] init];
        _orderLabel.textAlignment = NSTextAlignmentRight;
        _orderLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _orderLabel.font = [UIFont systemFontOfSize:14.0];
        _orderLabel.text = @"全部订单";
    }
    return _orderLabel;
}

- (UIImageView *)arrowImage {
    if (_arrowImage == nil) {
        _arrowImage = [[UIImageView alloc] init];
        _arrowImage.image = [UIImage imageNamed:@"detail_good_right"];
    }
    return _arrowImage;
}

#pragma mark - SetData

#pragma mark - Event


@end
