//
//  FSAddressShipAddressCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/12.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSAddressShipAddressCell.h"
#import "FSAddressListMData.h"

@interface FSAddressShipAddressCell ()

/** 地址 */
@property (nonatomic, strong) UILabel *address;
/** 图标 */
@property (nonatomic, strong) UIImageView *icon;

@end


@implementation FSAddressShipAddressCell

#pragma mark - SetData
- (void)setRowMData:(FSAddressListMData *)rowMData {
    _rowMData = rowMData;
    self.address.text = [NSString stringWithFormat:@"%@%@%@%@", rowMData.provinceName.length ?rowMData.provinceName:@"" ,rowMData.cityName.length?rowMData.cityName:@"",rowMData.areaName.length ?rowMData.areaName:@"",rowMData.detail_address.length ?rowMData.detail_address:@""];
}

#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        [self configuration];
    }
    return self;
}

#pragma mark - ConfigUI
- (void)configUI {
    
    [self.contentView addSubview:self.address];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kAutoWithSize(5));
        make.left.equalTo(self).offset(kAutoWithSize(10));
        make.right.equalTo(self).offset(-kAutoWithSize(10));
    }];
    
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.equalTo(self);
        make.height.equalTo(@(1));
    }];
    
    
}

#pragma mark - Configuration
- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

#pragma mark - LazyGet
- (UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"addressList_icon"];
    }
    return _icon;
}

- (UILabel *)address {
    if (_address == nil) {
        _address = [[UILabel alloc] init];
        _address.textColor = [UIColor colorWithHexString:@"#333333"];
        _address.font = [UIFont fontWithName:@"PingFangSC-Light" size:kFont(12)];
        _address.numberOfLines = 0;
    }
    return _address;
}

#pragma mark - Event

@end
