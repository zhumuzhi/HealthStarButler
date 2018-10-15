//
//  FSAddressItem.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/15.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSAddressItem.h"

#import "FSAddressListMData.h"

@interface FSAddressItem()

@property (nonatomic, strong) UILabel *itemTitle;

@end

@implementation FSAddressItem

#pragma mark - setData
- (void)setRowMData:(FSAddressListMData *)rowMData {
    _rowMData = rowMData;
    self.itemTitle.text = rowMData.title;
    self.itemTitle.backgroundColor = rowMData.backgroundColor;
}

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self configUI];
        [self configuration];
    }
    return self;
}

#pragma mark - configUI
- (void)configUI {
    [self.contentView addSubview:self.itemTitle];
}

#pragma mark - configuration
- (void)configuration {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.itemTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}

#pragma mark - LazyGet
- (UILabel *)itemTitle {
    if (_itemTitle == nil) {
        _itemTitle = [[UILabel alloc] init];
        _itemTitle.textAlignment = NSTextAlignmentCenter;
        _itemTitle.text = @"默认";
        _itemTitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kFont(10)];
        _itemTitle.backgroundColor = [UIColor colorWithHexString:@"#4A90E2"];
        _itemTitle.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _itemTitle.layer.masksToBounds = YES;
        _itemTitle.layer.cornerRadius = 5;
    }
    return _itemTitle;
    
}



@end
