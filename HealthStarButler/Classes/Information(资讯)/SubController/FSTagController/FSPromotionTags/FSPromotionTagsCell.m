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

#pragma mark - setData

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self cofignUIWith:(CGRect)frame];
        [self configration];
    }
    return self;
}

#pragma mark - configUI
- (void)cofignUIWith:(CGRect)frame {
    [self.contentView addSubview:self.title];
    self.title.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.title.layer.cornerRadius = frame.size.height/2;
}

#pragma mark - configration
- (void)configration {
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - LazyGet
- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor orangeColor];
        _title.backgroundColor = [UIColor whiteColor];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:kFont(10)];
        _title.layer.borderWidth = 1;
        _title.layer.borderColor = [UIColor orangeColor].CGColor;
        _title.layer.masksToBounds = YES;
    }
    return _title;
}

@end
