//
//  FSAddressContactsCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/12.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSAddressContactsCell.h"
#import "FSAddressListMData.h"

/** 电话号码长度 */
#define kPhoneLength 11

@interface FSAddressContactsCell ()

/** 姓名 */
@property (nonatomic, strong) UILabel *name;
/** 电话 */
@property (nonatomic, strong) UILabel *phone;

@end

@implementation FSAddressContactsCell

#pragma mark - SetData
- (void)setListMData:(FSAddressListMData *)listMData {
    _listMData = listMData;
    self.name.text = listMData.receiverName;
    if (![NSString isEmptyString:listMData.mobile]) {
        self.phone.text = listMData.mobile;
    }
    if (self.phone.text.length == kPhoneLength) {
        //        self.phone.text = [self.phone.text stringByReplacingCharactersInRange:NSMakeRange(3, 5)  withString:@"*****"];
    }
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
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kAutoWithSize(10));
        make.left.equalTo(self).offset(kAutoWithSize(10));
        make.width.equalTo(@(kAutoWithSize(120)));
    }];
    
    [self.contentView addSubview:self.phone];
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.name);
        make.left.equalTo(self.name.mas_right);
    }];
}

#pragma mark - Configuration
- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - LazyGet
- (UILabel *)name {
    if (_name == nil) {
        _name = [[UILabel alloc] init];
        _name.text = @"";
        _name.font = [UIFont boldSystemFontOfSize:kFont(14)];
        _name.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _name;
}

- (UILabel *)phone {
    if (_phone == nil) {
        _phone = [[UILabel alloc] init];
        _phone.text = @"";
        _phone.font = [UIFont boldSystemFontOfSize:kFont(14)];
        _phone.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _phone;
    
}

#pragma mark - Event

@end
