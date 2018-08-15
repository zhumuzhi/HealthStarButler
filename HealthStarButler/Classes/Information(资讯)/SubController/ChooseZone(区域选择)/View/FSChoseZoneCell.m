//
//  FSChoseZoneCell.m
//  FangShengyun
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSChoseZoneCell.h"

#import "FSChoseZoneMData.h"
#define kLocationIcon @"common_zone"

@interface FSChoseZoneCell()<UITextFieldDelegate>
/** 标题 */
@property (nonatomic , strong) UILabel *title;
/** 线 */
@property (nonatomic , strong) UIView *line;
/** 对号 */
@property (nonatomic , strong) UIImageView *icon;
/** 定位图标 */
@property (nonatomic , strong) UITextField *textField;
@end

@implementation FSChoseZoneCell
#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self configuration];
    }
    return self;
}

#pragma mark - Configuration
- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


#pragma mark - set
- (void)setRowMData:(FSChoseZoneMData *)rowMData {
    _rowMData = rowMData;
    self.textField.text = rowMData.cityName;
//    self.title.text = rowMData.cityName;
/** 定位 */
    if (rowMData.choseZoneCellType == FSChoseZoneCellTypePosition) {
        self.icon.hidden = YES;
        self.textField.leftViewMode = UITextFieldViewModeAlways;
/** 定位 */
    } else if (rowMData.choseZoneCellType == FSChoseZoneCellTypeChoseCity) {
        self.icon.hidden = !rowMData.seleted;
    } else if (rowMData.choseZoneCellType == FSChoseZoneCellTypeSearchCity) {
        self.icon.hidden = YES;
        self.textField.leftViewMode = UITextFieldViewModeNever;
    } else {
        self.icon.hidden = YES;

        self.textField.leftViewMode = UITextFieldViewModeNever;
    }
}

- (void)setupUI {

    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kMargin10 * 2);
        make.right.equalTo(self).offset(-kMargin10 * 2);
        make.top.bottom.right.equalTo(self);
    }];
    
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    [self addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self);
        make.height.width.equalTo(@(kAutoWithSize(20)));
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.rowMData.choseZoneCellType == FSChoseZoneCellTypePosition) {
        if (self.rowMData.isComplete == NO) {
            return NO;
        }
    }
    /** 禁止编辑 */
    if (self.delegate && [self.delegate respondsToSelector:@selector(choseZoneCell:choseZoneMData:)]) {
        [self.delegate choseZoneCell:self choseZoneMData:self.rowMData];
    }
    return NO;
}
#pragma mark - get
- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc]init];
        _textField.delegate = self;
        UIView *leftView = [[UIView alloc]init];
        leftView.frame = CGRectMake(0, 0, kAutoWithSize(24), kAutoWithSize(30));
        UIImage *image = [UIImage imageNamed:kLocationIcon];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, (leftView.height - kAutoWithSize(14)) * .5, kAutoWithSize(14), kAutoWithSize(14));
        imageView.image = image;
        [leftView addSubview:imageView];
        _textField.leftView = leftView;
        _textField.leftViewMode = UITextFieldViewModeNever;
    }
    return _textField;
}
- (UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc]init];
        _icon.image = [UIImage imageNamed:@"check"];
    }
    return _icon;
}
- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kFont(14)];
        _title.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _title;
}
- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    }
    return _line;
}
@end
