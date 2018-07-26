//
//  FSAccountSetHeadCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/24.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSAccountSetHeadCell.h"
#import "FSAccountSetMData.h"

@interface FSAccountSetHeadCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *companyName;
@property (nonatomic, strong) UILabel *accoutName;
@property (nonatomic, strong) UILabel *accoutType;

@end

@implementation FSAccountSetHeadCell

#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - configUI

static CGFloat Margin = 10;
static CGFloat IconW = 60;

- (void)setupUI {

    self.selectionStyle = UITableViewCellSelectionStyleNone;

    /** 头像 */
    [self.contentView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(Margin*2);
        make.width.height.equalTo(@(IconW));
    }];

    /** 公司 */
    [self.contentView addSubview:self.companyName];
    [self.companyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_top);
        make.left.equalTo(self.iconView.mas_right).offset(Margin*2);
        make.right.equalTo(self);
        make.height.equalTo(@(Margin*2));
    }];

    CGFloat subTitleH = 17.0;

    /** 权限 */
    [self.contentView addSubview:self.accoutType];
    [self.accoutType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconView.mas_bottom);
        make.left.equalTo(self.companyName);
        make.right.equalTo(self.companyName);
        make.height.equalTo(@(subTitleH));
    }];

    /** 账号 */
    [self.contentView addSubview:self.accoutName];
    [self.accoutName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.accoutType.mas_top);
        make.left.equalTo(self.accoutType.mas_left);
        make.height.equalTo(self.accoutType.mas_height);
    }];
}

#pragma mark - SetData

- (void)setAccountData:(FSAccountSetMData *)accountData {
    _accountData = accountData;
    self.companyName.text = accountData.companyName;
    self.accoutName.text = accountData.acountName;
    self.accoutType.text = accountData.permission;
    self.imageView.image = [UIImage imageNamed:accountData.iconUrl];
}

#pragma mark - Event

#pragma mark - LazyGet
- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"mine_cellArrowWhite"];
        _iconView.contentMode = UIViewContentModeCenter;

        _iconView.layer.cornerRadius = self.iconView.width/2;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)companyName {
    if (_companyName == nil) {
        _companyName = [[UILabel alloc] init];
        _companyName.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0];
        _companyName.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _companyName;
}

- (UILabel *)accoutName {
    if (_accoutName == nil) {
        _accoutName = [[UILabel alloc] init];
        _accoutName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0];
        _accoutName.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _accoutName;
}

- (UILabel *)accoutType {
    if (_accoutType == nil) {
        _accoutType = [[UILabel alloc] init];
        _accoutType.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0];
        _accoutType.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _accoutType;
}


@end
