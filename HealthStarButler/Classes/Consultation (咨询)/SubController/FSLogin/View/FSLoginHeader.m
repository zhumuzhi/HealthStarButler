//
//  FSLoginHeader.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/14.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSLoginHeader.h"

@interface FSLoginHeader ()

@property (nonatomic, strong) UIImageView *logo;

@end


@implementation FSLoginHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.logo];
    
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.width.equalTo(@(100));
    }];
}

#pragma mark - LazyGet
- (UIImageView *)logo {
    if (_logo == nil) {
        _logo = [[UIImageView alloc] init];
        _logo.image = [UIImage imageNamed:@"logo"];
        _logo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _logo;
}



@end
