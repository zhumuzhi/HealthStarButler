//
//  FSLocationView.m
//  FangShengyun
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSLocationView.h"
#import "NSString+Size.h"

@interface FSLocationView()
@property (nonatomic , strong) UIImageView *icon;
@property (nonatomic , strong) UILabel *location;
@property (nonatomic , strong) UIImageView *arrow;

@end
@implementation FSLocationView

- (void)setLocationCity:(NSString *)locationCity {
    _locationCity = locationCity;
    self.location.text = locationCity;
    self.location.width = [locationCity sizeWithFont:[UIFont fontWithName:@"PingFangSC-Regular" size:kFont(14)] maxSize:CGSizeZero].width;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
#pragma mark - 创建UI
- (void)setupUI {
    [self addSubview:self.icon];
    [self addSubview:self.location];
    [self addSubview:self.arrow];

}
- (void)layoutSubviews {
    [super layoutSubviews];
    [UIView animateWithDuration:0.25 animations:^{
        self.arrow.x = self.location.width + self.location.x + kAutoWithSize(3);
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationView:finalX:)]) {
        [self.delegate locationView:self finalX:self.arrow.x];
    }
}
#pragma mark - get
- (UIImageView *)arrow {
    if (_arrow == nil) {
        _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(self.location.width + self.location.x + kAutoWithSize(3), kAutoWithSize(8), kAutoWithSize(6), kAutoWithSize(4))];
        _arrow.image = [UIImage imageNamed:@"home_arrow"];
    }
    return _arrow;
}
- (UILabel *)location {
    if (_location == nil) {
        _location = [[UILabel alloc]init];
        _location.frame = CGRectMake(self.icon.width +self.icon.x + kAutoWithSize(3) , 0, kAutoWithSize(29), kAutoWithSize(20));
        _location.text = @"正在定位";
        _location.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _location.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kFont(14)];
    }
    return _location;
}
- (UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"home_location"];
        _icon.frame = CGRectMake(0, 3.5, kAutoWithSize(11), kAutoWithSize(14));
    }
    return _icon;
}
@end
