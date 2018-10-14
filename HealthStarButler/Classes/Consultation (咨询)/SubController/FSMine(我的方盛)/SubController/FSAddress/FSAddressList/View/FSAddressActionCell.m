//
//  FSAddressActionCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/12.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSAddressActionCell.h"
#import "FSAddressListMData.h"

@interface FSAddressActionCell ()

/** 内容背景 */
@property (nonatomic, strong) UIView *backGround;

/** 勾选按钮 */
@property (nonatomic, strong) UIButton *check;

/** 编辑标题 */
@property (nonatomic, strong) UILabel *edit;
/** 编辑按钮 */
@property (nonatomic, strong) UIButton *actionEdit;

/** 设为默认标题 */
@property (nonatomic, strong) UILabel *defaultAddress;
/** 编辑图标 */
@property (nonatomic, strong) UIImageView *editIcon;
/** 设置默认按钮 */
@property (nonatomic, strong) UIButton *actionDefault;

@end

@implementation FSAddressActionCell



#pragma mark - SetData
- (void)setRowMData:(FSAddressListMData *)rowMData {
    _rowMData = rowMData;

    if (rowMData.is_default == FSAddressTypeDefault) {
        self.check.selected = YES;
    } else {
        self.check.selected = NO;
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
    
    [self.contentView addSubview:self.backGround];
    [self.backGround mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
    }];
    
    [self.backGround addSubview:self.check];
    [self.check mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backGround.mas_left).offset(kAutoWithSize(10));
        make.centerY.equalTo(self.backGround);
        make.width.height.equalTo(@(kAutoWithSize(16)));
    }];
    
    CGSize defaultAddressSize = [self.defaultAddress sizeThatFits:CGSizeMake(MAXFLOAT, 44)];
    [self.backGround addSubview:self.defaultAddress];
    [self.defaultAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.check.mas_right).offset(kAutoWithSize(10));
        make.centerY.equalTo(self.check);
        make.width.equalTo(@(defaultAddressSize.width));
    }];
    
    [self.backGround addSubview:self.actionDefault];
    [self.actionDefault mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.backGround);
        make.right.equalTo(self.defaultAddress);
    }];
    
    [self.backGround addSubview:self.editIcon];
    [self.editIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backGround.mas_right).offset(-kAutoWithSize(10));
        make.centerY.equalTo(self.backGround);
        make.width.height.equalTo(@(kAutoWithSize(16)));
    }];
    
    CGSize editSize = [self.edit sizeThatFits:CGSizeMake(MAXFLOAT, 44)];
    [self.backGround addSubview:self.edit];
    [self.edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.editIcon.mas_left).offset(-kAutoWithSize(10));
        make.centerY.equalTo(self.editIcon);
        make.width.equalTo(@(editSize.width));
        
    }];
    
    [self.backGround addSubview:self.actionEdit];
    [self.actionEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.backGround);
        make.left.equalTo(self.edit);
    }];
}



#pragma mark - Configuration
- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;


}


#pragma mark - Event
- (void)clickButton:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(addressActionCell:addressListMData:buttonType:)]) {
        [self.delegate addressActionCell:self addressListMData:self.rowMData buttonType:button.tag];
    }
}


#pragma mark - LazyGet

- (UIImageView *)editIcon {
    if (_editIcon == nil) {
        _editIcon = [[UIImageView alloc] init];
        _editIcon.image = [UIImage imageNamed:@"address_edit"];
    }
    return _editIcon;
}

- (UILabel *)edit {
    if (_edit == nil) {
        _edit = [[UILabel alloc] init];
        _edit.text = @"编辑";
        _edit.textColor = [UIColor colorWithHexString:@"#333333"];
        _edit.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kFont(12)];
    }
    return _edit;
}
- (UIButton *)actionEdit {
    if (_actionEdit == nil) {
        _actionEdit = [[UIButton alloc] init];
        _actionEdit.tag = FSAddressActionCellButtonTypeEdit;
        [_actionEdit addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionEdit;
    
}

- (UILabel *)defaultAddress {
    if (_defaultAddress == nil) {
        _defaultAddress = [[UILabel alloc] init];
        _defaultAddress.text = @"设为默认地址";
        _defaultAddress.textColor = [UIColor colorWithHexString:@"#333333"];
        _defaultAddress.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kFont(12)];
    }
    return _defaultAddress;
}

- (UIButton *)actionDefault {
    if (_actionDefault == nil) {
        _actionDefault = [[UIButton alloc] init];
        _actionDefault.tag = FSAddressActionCellButtonTypeDefault;
        [_actionDefault addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionDefault;
    
}


- (UIButton *)check {
    if (_check == nil) {
        _check = [[UIButton alloc] init];
        [_check setImage:[UIImage imageNamed:@"address_check_selected"] forState:UIControlStateSelected];
        [_check setImage:[UIImage imageNamed:@"address_check_normal"] forState:UIControlStateNormal];
        _check.userInteractionEnabled = NO;
    }
    return _check;
}

- (UIView *)backGround {
    if (_backGround == nil) {
        _backGround = [[UIView alloc] init];
        _backGround.backgroundColor = [UIColor whiteColor];
    }
    return _backGround;
}

@end
