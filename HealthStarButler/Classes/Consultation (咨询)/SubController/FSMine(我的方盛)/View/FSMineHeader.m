//
//  FSMineHeader.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/21.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSMineHeader.h"
#import "FSMineMData.h"

@interface FSMineHeader ()

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

@implementation FSMineHeader

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        // 添加点击手势触犯代理方法
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickHeader)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)didClickHeader {
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineHeader:mineModel:eventType:)]) {
        [self.delegate mineHeader:self mineModel:self.mineMData eventType:FSMineHeaderTypeHeader];
    }
}

#pragma mark - ConfigUI

static CGFloat Margin = 12.0; // 边距
static CGFloat iconW = 80.0;  // 头像宽高
static CGFloat arrowW = 20.0;  // 指示View宽度

- (void)configUI {

    /** 背景图*/
    [self addSubview:self.backImage];
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];


    CGFloat statusBarH = [[UIApplication sharedApplication] statusBarFrame].size.height;

    /** 头像 */
    [self addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(statusBarH/2);
        make.left.equalTo(self).offset(Margin);
        make.width.height.equalTo(@(iconW));
    }];

    /** 用户名 */
    [self addSubview:self.acountName];
    [self.acountName mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.icon.mas_top);
        make.centerY.equalTo(self.icon.mas_centerY).offset(-Margin);
        make.left.equalTo(self.icon.mas_right).offset(Margin);
        make.right.equalTo(self).offset(-kAutoWithSize(Margin));
    }];

    /** 账号类型 */
    [self addSubview:self.acountType];
    [self.acountType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.acountName.mas_bottom).offset(Margin*0.5);
        make.left.equalTo(self.acountName);
        make.width.equalTo(self.acountName);
    }];

    /** 箭头 */
    [self addSubview:self.arrow];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.acountName.mas_centerY);
        make.right.equalTo(self).offset(-kAutoWithSize(Margin));
        make.width.equalTo(@(kAutoWithSize(kMargin10)));
        make.height.equalTo(@(kAutoHeightSize(arrowW)));
    }];
}


#pragma mark - SetData
- (void)setMineMData:(FSMineMData *)mineMData {
    _mineMData = mineMData;

    // 真实赋值
    self.acountName.text = mineMData.acountName;
    self.acountType.text = mineMData.permission;
    self.icon.image = [UIImage imageNamed:mineMData.iconUrl];

    // 暂时赋值
//    self.acountName.text = @"账号：MEID123";
//    self.acountType.text = @"权限: 下单 结算 审批";

}

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
//        _icon.image = [UIImage imageNamed:@"list_denglutouxiang"];
        _icon.contentMode = UIViewContentModeCenter;
        _icon.layer.cornerRadius = iconW*0.5;
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}

- (UILabel *)acountName {
    if (_acountName == nil) {
        _acountName = [[UILabel alloc] init];
        _acountName.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18.0];
        _acountName.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    }
    return _acountName;
}

- (UILabel *)acountType {
    if (_acountType == nil) {
        _acountType = [[UILabel alloc] init];
        _acountType.font = [UIFont systemFontOfSize:12];
        _acountType.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0];
        _acountType.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    }
    return _acountType;
}

- (UIImageView *)arrow {
    if (_arrow == nil) {
        _arrow = [[UIImageView alloc] init];
        _arrow.image = [UIImage imageNamed:@"mine_cellArrowWhite"];
        _arrow.contentMode = UIViewContentModeCenter;
    }
    return _arrow;
}

@end
