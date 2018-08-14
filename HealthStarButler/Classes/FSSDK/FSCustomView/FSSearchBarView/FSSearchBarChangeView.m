//
//  FSSearchBarChangeView.m
//  FangShengyun
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSSearchBarChangeView.h"

@interface FSSearchBarChangeView()<UITextFieldDelegate,FSLocationChangeViewDelegate>
@property (nonatomic , strong) UITextField *searchBar;
@property (nonatomic , strong) UILabel *placeholderLabel;
@property (nonatomic , assign) CGFloat finalX;

@end
@implementation FSSearchBarChangeView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
//        self.layer.shadowColor = [UIColor blackColor].CGColor;
//        self.layer.shadowOffset = CGSizeMake(2, 2);
//        self.layer.shadowOpacity = 0.4;
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.searchBar];
    [self addSubview:self.locationChangeView];
    [self.searchBar addSubview:self.placeholderLabel];

}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.searchBar.frame = CGRectMake(self.finalX  + kAutoWithSize(6) + kAutoWithSize(3) + kAutoWithSize(5), (self.bounds.size.height -kAutoWithSize(32)) * 0.5 , kAutoWithSize(268), kAutoWithSize(32));
}
- (void)locationChangeView: (FSLocationChangeView *)locationChangeView finalX: (CGFloat)finalX{
    self.finalX = finalX;
    [UIView animateWithDuration:0.25 animations:^{
        self.searchBar.x = self.finalX +kAutoWithSize(6) + kAutoWithSize(3) + kAutoWithSize(5) + 20;;
    }];
    
}
- (void)clickButton: (UIButton *)button {
    // GHLog(@"点击定位按钮");
//    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarChangeViewDidClick:)]) {
//        [self.delegate searchBarChangeViewDidClick:self];
//    }
}
- (FSLocationChangeView *)locationChangeView {
    if (_locationChangeView == nil) {
        _locationChangeView = [[FSLocationChangeView alloc]init];
        _locationChangeView.frame = CGRectMake(kAutoWithSize(18), 12, 50, 20);
        [_locationChangeView addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _locationChangeView.delegate = self;
    }
    return _locationChangeView;
}
- (UILabel *)placeholderLabel {
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.textColor =[UIColor colorWithHexString:@"#999999"];
        _placeholderLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kFont(12)];
        _placeholderLabel.frame = CGRectMake(kAutoWithSize(29), (kAutoWithSize(32) -kAutoWithSize(17) ) * 0.5 , kAutoWithSize(232), kAutoWithSize(17));
        _placeholderLabel.text = @"请输入商品名称、品牌名称、型号、sku码";
        _placeholderLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _placeholderLabel;
}
- (UITextField *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[UITextField alloc]init];
        _searchBar.frame = CGRectMake(kAutoWithSize(77), 6, kAutoWithSize(280), 32);
        _searchBar.backgroundColor = [UIColor colorWithHexString:@"#ECECEC"];
        _searchBar.layer.masksToBounds = YES;
        _searchBar.layer.cornerRadius = 16;
        UIView *leftView = [[UIView alloc]init];
        leftView.frame = CGRectMake(0, 0, kAutoWithSize(29), kAutoWithSize(32));
        UIImageView *iconView = [[UIImageView alloc]init];
        [leftView addSubview:iconView];
        iconView.image = [UIImage imageNamed:@"home_search"];
        iconView.frame = CGRectMake(kAutoWithSize(12), (kAutoWithSize(32) - kAutoWithSize(14)) * 0.5, kAutoWithSize(14), kAutoWithSize(14));
        _searchBar.leftViewMode = UITextFieldViewModeAlways;
        _searchBar.leftView = leftView;
        _searchBar.delegate = self;
    }
    return _searchBar;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarChangeViewDidClick:)]) {
        [self.delegate searchBarChangeViewDidClick:self];
    }
    return NO;
}

@end
