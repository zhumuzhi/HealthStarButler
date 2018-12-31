//
//  FSCycleViewCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/29.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSCycleViewCell.h"

@interface FSCycleViewCell ()

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UILabel *titleL;

@property (strong, nonatomic) UILabel *currentPageL;

@property (nonatomic, strong) UIView *titleBackgroundView;

@end

@implementation FSCycleViewCell

#pragma mark - SetData

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

#pragma mark - ConfigUI
- (void)configUI {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleBackgroundView];
    [self.titleBackgroundView addSubview:self.titleL];
    [self.titleBackgroundView addSubview:self.currentPageL];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.titleBackgroundView.frame = CGRectMake(0, self.height - 30, self.width, 30);
}

#pragma mark - LazyGet
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)titleL {
    if (_titleL == nil) {
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.width-80, 30)];
        _titleL.textColor = [UIColor whiteColor];
    }
    return _titleL;
}

- (UILabel *)currentPageL {
    if (_currentPageL == nil) {
        _currentPageL = [[UILabel alloc] initWithFrame:CGRectMake(self.width-80, 0, 70, 30)];
        _currentPageL.textAlignment = NSTextAlignmentRight;
        _currentPageL.textColor = [UIColor whiteColor];
    }
    return _currentPageL;
}

- (UIView *)titleBackgroundView {
    if (_titleBackgroundView == nil) {
        _titleBackgroundView = [[UIView alloc] init];
        _titleBackgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    }
    return _titleBackgroundView;
}

@end

