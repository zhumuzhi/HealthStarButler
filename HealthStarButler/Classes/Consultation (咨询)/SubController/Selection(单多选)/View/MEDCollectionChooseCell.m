//
//  MEDCollectionChooseCell.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/28.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDCollectionChooseCell.h"

#define SelectNum_ItemHeight 51
#define SelectNum_ItemWidth 77
#define ItemFont1 17
#define ItemFont2 16

@implementation MEDCollectionChooseCell

//MARK:- init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    //按钮
    _selectIconBtn = [[UIButton alloc] init];
    _selectIconBtn.userInteractionEnabled = NO;
    [_selectIconBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_selectIconBtn setBackgroundImage:[UIImage imageNamed:@"back_wxz"] forState:UIControlStateNormal];
    [_selectIconBtn setBackgroundImage:[UIImage imageNamed:@"back_xz"] forState:UIControlStateSelected];
    [self.contentView addSubview:_selectIconBtn];
    
    [_selectIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
    //标题
    _titleLab = [[UILabel alloc] init];
    _titleLab.textColor = [UIColor darkGrayColor];
    _titleLab.font = [UIFont systemFontOfSize:16];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLab];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}

- (void)UpdateCellWithState:(BOOL)select {
    self.selectIconBtn.selected = select;
    _isSelected = select;
}

@end
