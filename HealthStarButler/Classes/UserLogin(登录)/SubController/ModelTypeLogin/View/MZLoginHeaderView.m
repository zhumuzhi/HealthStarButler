//
//  MZLoginHeaderView.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/9.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MZLoginHeaderView.h"

@interface MZLoginHeaderView ()
@property (nonatomic , strong) UIImageView *logo;
@end

@implementation MZLoginHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.logo];
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@100);
        make.height.equalTo(@60);
    }];
}

- (UIImageView *)logo {
    if (_logo == nil) {
        _logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo1"]];
        _logo.layer.masksToBounds = YES;
        _logo.layer.cornerRadius = 5;
        [_logo sizeToFit];
    }
    return _logo;
}


@end
