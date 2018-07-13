//
//  MEDTableChooseCell.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/19.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDTableChooseCell.h"

#define HorizonGap 15
#define TilteBtnGap 10
#define ColorRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MEDTableChooseCell

//MARK:- initializer
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupCellUI];
    }
    return self;
}

//MARK:- UI
- (void)setupCellUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.selectIconBtn];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top);
        make.height.equalTo(self.contentView.mas_height);
    }];
    
    [self.selectIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.titleLabel.mas_top);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(self.contentView.mas_height);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIButton *)selectIconBtn {
    if (!_selectIconBtn) {
        _selectIconBtn = [[UIButton alloc] init];
        [_selectIconBtn setImage:[UIImage imageNamed:@"table_SelectCheck"] forState:UIControlStateNormal]; //@"table_SelectCheck" forState:UIControlStateNormal];
        [_selectIconBtn setImage:[UIImage imageNamed:@"table_UnSelect"] forState:UIControlStateSelected];
        _selectIconBtn.userInteractionEnabled = NO;
    }
    return _selectIconBtn;
}

- (void)updateCellWithState:(BOOL)select {
    self.selectIconBtn.selected = select;
    _isSelected = select;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //NSLog(@"%s", __func__);
}

@end
