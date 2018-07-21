//
//  FSMineOrderItem.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/20.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSMineOrderItem.h"

@interface FSMineOrderItem ()


@end

@implementation FSMineOrderItem

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

#pragma mark - ConfigUI

- (void)configUI {

    /** item标题 */
    [self addSubview:self.itemTitle];
    [self.itemTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(20));
    }];

    /** item图片 */
    [self addSubview:self.itemImage];
    [self.itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self.itemTitle.mas_top);
    }];

}

#pragma mark - LazySet

- (UIImageView *)itemImage {
    if (_itemImage == nil) {
        _itemImage = [[UIImageView alloc] init];
        _itemImage.contentMode = UIViewContentModeCenter;
    }
    return _itemImage;
}

- (UILabel *)itemTitle {
    if (_itemTitle == nil) {
        _itemTitle = [[UILabel alloc] init];
        _itemTitle.textAlignment = NSTextAlignmentCenter;
        _itemTitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _itemTitle.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _itemTitle;
}



#pragma mark - SetData


#pragma mark - Event


@end
