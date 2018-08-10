//
//  FSPayPopupView.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/8.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//  

#import "FSPayPopupView.h"
#import "FSPayPasswordView.h"

#define kAnimationTimeInterval 0.3

@interface FSPayPopupView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UIView *payPopupView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *forgetPasswordButton;

@property (nonatomic, strong) FSPayPasswordView *payPasswordView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation FSPayPopupView

#pragma mark - lifeCycle

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [self createUI];
    }
    return self;
}

- (void)createUI {

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.superView];
    [self.superView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(window);
    }];

    [self.superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.superView);
        make.top.equalTo(self.superView.mas_top).with.offset(kAutoWithSize(230));
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(kAutoWithSize(16));
        make.centerX.equalTo(self);
    }];
    
    [self addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(kAutoWithSize(16));
        make.centerY.equalTo(self.titleLabel);
        make.width.mas_equalTo(kAutoWithSize(14));
        make.height.mas_equalTo(kAutoWithSize(14));
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).with.offset(kAutoWithSize(48));
        make.height.mas_equalTo(kAutoWithSize(1));
    }];
    
    [self addSubview:self.payPasswordView];
    [self.payPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.mas_top).with.offset(kAutoWithSize(70));
        make.height.mas_equalTo(kAutoWithSize(50));
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    [self addSubview:self.forgetPasswordButton];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(kAutoWithSize(-16));
        make.top.equalTo(self.payPasswordView.mas_bottom).with.offset(kAutoWithSize(16));
        make.height.mas_equalTo(kAutoWithSize(20));
        make.width.mas_equalTo(kAutoWithSize(60));
    }];
}

#pragma mark - Private
#pragma mark - 隐藏支付窗口
- (void)forgetPasswordAction {
    [self hidePayPopView];

    if (self.delegate && [self.delegate respondsToSelector:@selector(payPopupViewDidClickForgetPasswordButton:)]) {
        [self.delegate payPopupViewDidClickForgetPasswordButton:self];
    }
}

#pragma mark - Public

- (void)showPayPopView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kAnimationTimeInterval animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    } completion:nil];
}

- (void)hidePayPopView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kAnimationTimeInterval animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.alpha = 0.0;
        strongSelf.frame = CGRectMake(strongSelf.frame.origin.x, kScreenHeight, strongSelf.frame.size.width, strongSelf.frame.size.height);
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.superView removeFromSuperview];
        strongSelf.superView = nil;
    }];
}

- (void)didInputPayPasswordError {
    [self.payPasswordView didInputPasswordError];
}

#pragma mark - Setter/Getter
- (FSPayPasswordView *)payPasswordView {
    if (!_payPasswordView) {
        _payPasswordView = [[FSPayPasswordView alloc] init];
        __weak typeof(self) weakSelf = self;
        _payPasswordView.completionBlock = ^(NSString *password) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if ([strongSelf.delegate respondsToSelector:@selector(payPopupViewPasswordInputFinished:)]) {
                [strongSelf.delegate payPopupViewPasswordInputFinished:password];
            }
        };
    }
    return _payPasswordView;
}

- (UIView *)superView {
    if (!_superView) {
        _superView = [[UIView alloc] init];
    }
    return _superView;
}

- (UIView *)payPopupView {
    if (!_payPopupView) {
        _payPopupView = [[UIView alloc] init];
        _payPopupView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    }
    return _payPopupView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        _titleLabel.text = @"输入六位支付密码";
    }
    return _titleLabel;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal]; //back_back
        [_closeButton addTarget:self action:@selector(hidePayPopView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#E7E7E7"];
    }
    return _lineView;
}

- (UIButton *)forgetPasswordButton {
    if (!_forgetPasswordButton) {
        _forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPasswordButton setTitleColor:[UIColor colorWithHexString:@"#F08327"] forState:UIControlStateNormal];
        _forgetPasswordButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        [_forgetPasswordButton addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPasswordButton;
}

@end
