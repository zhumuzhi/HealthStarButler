//
//  FSChoseZoneCollectionCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/16.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSChoseZoneCollectionCell.h"
// Mdoel
#import "FSChoseZoneMData.h"

@interface FSChoseZoneCollectionCell ()
/** 城市 */
@property (nonatomic, strong) UILabel *cityName;

@end

@implementation FSChoseZoneCollectionCell


#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self configuration];
    }
    return self;
}

#pragma mark - ConfigUI
- (void)setupUI {
    [self addSubview:self.cityName];
    [self.cityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
}

- (void)configuration {
    self.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor colorWithHexString:@"#EFEFEF"].CGColor;
    self.layer.cornerRadius = 5.0;
    [self.layer masksToBounds];
}

#pragma mark - setData
- (void)setChoseZoneMData:(FSChoseZoneMData *)choseZoneMData {
    _choseZoneMData = choseZoneMData;
    self.cityName.text = choseZoneMData.cityName;
}

#pragma mark - LazyGet
- (UILabel *)cityName {
    if (_cityName == nil) {
        _cityName = [[UILabel alloc] init];
        _cityName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _cityName.textColor = [UIColor colorWithHexString:@"#333333"];
        _cityName.textAlignment = NSTextAlignmentCenter;
    }
    return _cityName;
}

@end
