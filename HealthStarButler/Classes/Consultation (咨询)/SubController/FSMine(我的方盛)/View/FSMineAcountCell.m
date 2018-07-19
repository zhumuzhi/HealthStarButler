//
//  FSMineAcountCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/19.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSMineAcountCell.h"

@interface FSMineAcountCell ()

/** 背景图片 */
@property (nonatomic, strong) UIImageView *backImage;
/** 头像 */
@property (nonatomic, strong) UIImageView *icon;
/** 用户名 */
@property (nonatomic, strong) UILabel *acountName;
/** 账号类型 */
@property (nonatomic, strong) UILabel *acountType;
/** 箭头 */
@property (nonatomic, strong) UIImageView *arrow;

@end

@implementation FSMineAcountCell

#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        [self configuration];

    }
    return self;
}

#pragma mark - ConfigUI

static CGFloat Margin = 12.0; // 边距
static CGFloat iconW = 80.0;  // 头像宽高
static CGFloat arrowW = 6.0;  // 指示View宽度

- (void)configUI {

    /** 背景图*/
    [self.contentView addSubview:self.backImage];
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    
    /** 头像 */
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(Margin);
        make.width.height.equalTo(@(iconW));
    }];

    /** 用户名 */
    [self.contentView addSubview:self.acountName];
    [self.acountName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_top);
        make.left.equalTo(self.icon.mas_right).offset(Margin);
        make.right.equalTo(self).offset(-kAutoWithSize(Margin));
//        make.width.equalTo(@(200));
    }];

    /** 账号类型 */
    [self.contentView addSubview:self.acountType];
    [self.acountType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.acountName.mas_bottom).offset(Margin);
        make.left.equalTo(self.acountName);
        make.width.equalTo(self.acountName);
    }];

    /** 箭头 */
    [self.contentView addSubview:self.arrow];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-kAutoWithSize(Margin));
        make.width.equalTo(@(kAutoWithSize(arrowW)));
        make.height.equalTo(@(kAutoHeightSize(kMargin10)));
    }];


}

- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - SetData
- (void)setMineMData:(FSMineMData *)mineMData {
    _mineMData = mineMData;

    self.acountName.text = @"子账号: Miss001";
    self.acountType.text = @"账号类型: 子账号(下单账号)";
}

#pragma mark - Event



#pragma mark - LazySet

-(UIImageView *)backImage {
    if (_backImage == nil) {
        _backImage = [[UIImageView alloc] init];
        _backImage.image = [UIImage imageNamed:@"mine_Head"];
    }
    return _backImage;
}

- (UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"logo"];
        _icon.layer.cornerRadius = iconW*0.5;
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}

- (UILabel *)acountName {
    if (_acountName == nil) {
        _acountName = [[UILabel alloc] init];
        _acountName.font = [UIFont fontWithName:@"-apple-Bold" size:18];
        _acountName.textColor = [UIColor colorWithHexString:@"#101010"];
    }
    return _acountName;
}

- (UILabel *)acountType {
    if (_acountType == nil) {
        _acountType = [[UILabel alloc] init];
        _acountType.font = [UIFont fontWithName:@"-apple-system" size:12];
        _acountType.textColor = [UIColor colorWithHexString:@"#101010"];
    }
    return _acountType;
}

- (UIImageView *)arrow {
    if (_arrow == nil) {
        _arrow = [[UIImageView alloc] init];
        _arrow.image = [UIImage imageNamed:@"detail_good_right"];

    }
    return _arrow;
}

@end
