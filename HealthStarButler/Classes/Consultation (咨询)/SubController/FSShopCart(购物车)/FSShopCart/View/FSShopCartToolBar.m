//
//  FSShopCartToolBar.m
//  FangShengyun
//
//  Created by 朱慕之 on 2018/7/27.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSShopCartToolBar.h"

@interface FSShopCartToolBar ()

@end

@implementation FSShopCartToolBar

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

#pragma mark - ConfigUI

static CGFloat Margin = 10;

- (void)configUI {

    /** 全选按钮 */
    [self addSubview:self.allClickBtn];
    [self.allClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(Margin);
        make.top.bottom.equalTo(self);
//        make.width.equalTo(@(31));
    }];

    /** 操作按钮-结算/删除 */
    [self addSubview:self.operationBtn];
    [self.operationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.width.equalTo(@(91));
    }];

    /** 全部价格 */
    [self addSubview:self.price];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.operationBtn.mas_left);
        make.top.equalTo(self);
        make.height.equalTo(@(self.height/2));
    }];

    [self addSubview:self.freight];
    [self.freight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.operationBtn.mas_left);
        make.bottom.equalTo(self);
        make.height.equalTo(@(self.height/2));
    }];
}

- (void)configration {

}

#pragma mark - SetData
- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.allClickBtn.selected = isSelected;
}

#pragma mark - Event
- (void)allSelectedBtnClick:(UIButton *)button {
    button.selected = !button.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(shopCartToolBarSelectedAllClick)]) {
        [self.delegate shopCartToolBarSelectedAllClick];
   }
}

- (void)clearingBtnClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shopCartToolBarClearingClick)]) {
        [self.delegate shopCartToolBarClearingClick];
    }
}



#pragma mark - LazySet
- (UIButton *)allClickBtn {
    if (_allClickBtn == nil) {
        _allClickBtn = [[UIButton alloc] init];
        [_allClickBtn setImage:[UIImage imageNamed:@"shopcart_unChoose"] forState:(UIControlStateNormal)];
        [_allClickBtn setImage:[UIImage imageNamed:@"shopcart_choose"] forState:(UIControlStateSelected)];
        [_allClickBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allClickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_allClickBtn addTarget:self action:@selector(allSelectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allClickBtn;
}
- (UILabel *)price {
    if (_price == nil) {
        _price = [[UILabel alloc] init];
        _price.textAlignment = NSTextAlignmentRight;
        _price.text = @"￥100.00";

    }
    return _price;
}
- (UIButton *)operationBtn {
    if (_operationBtn == nil) {
        _operationBtn = [[UIButton alloc] init];
        [_operationBtn setTitle:@"结算" forState:UIControlStateNormal];
        _operationBtn.backgroundColor = [UIColor orangeColor];
        [_operationBtn addTarget:self action:@selector(clearingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _operationBtn;
}

- (UILabel *)freight {
    if (_freight == nil) {
        _freight = [[UILabel alloc] init];
        _freight.text = @"全部运费";
    }
    return _freight;
}

@end
