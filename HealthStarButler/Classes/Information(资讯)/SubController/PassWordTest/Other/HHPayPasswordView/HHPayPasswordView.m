//
//  HHPayPasswordView.m
//  HHPayPasswordView
//
//  Created by xiaozuan on 2017/9/7.
//  Copyright © 2017年 xiaozuan. All rights reserved.
//

#import "HHPayPasswordView.h"

#import "HHTextField.h"
#import "HHPasswordErrorView.h"

static NSInteger const kDotsNumber = 6;
static CGFloat const kDotWith_height = 10;
#define kOperationH kScreenHeight * 0.8

@interface HHPayPasswordView()<UITextFieldDelegate>
/** 蒙版 */
@property (nonatomic, strong) UIView *coverView;
/** 输入View */
@property (nonatomic, strong) UIView *backView;
/** 关闭按钮 */
@property (nonatomic, strong) UIButton *closeButton;
/** 标题 */
@property (nonatomic, strong) UILabel *promptLabel;
/** 忘记密码 */
@property (nonatomic, strong) UIButton *forgetButton;
/** 线 */
@property (nonatomic, strong) UIView *line;
/** 输入框 */
@property (nonatomic, strong) HHTextField *passwordField;
/** 点-数组 */
@property (nonatomic, strong) NSMutableArray *passwordDotsArray;
/** 加载视图 */
@property (nonatomic, strong) UIImageView *loadingImgView;
/** 提示文字 */
@property (nonatomic, strong) UILabel *tipLabel;
/** 错误View */
@property (nonatomic, strong) HHPasswordErrorView *errorView;

/** 键盘的高度 */
@property (nonatomic,assign) CGFloat keyBoardHeight;
/** 表示在弹出键盘的时候只设置bottomView的高度一次 */
@property (nonatomic,assign) BOOL isFirst;

@end

@implementation HHPayPasswordView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self configuration];
        [self setupUI];
    }
    return self;
}

#pragma mark - configuration
- (void)configuration {
    // 监听键盘的位置改变
    // 监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //监听重新输入密码的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(againInputPassWord) name:@"againInputPassWord" object:nil];
    //监听忘记密码的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forgetPassWord) name:@"forgetInputPassWord" object:nil];
    //默认yes
    self.isFirst = YES;
}


#pragma mark - NSNotificationMethod

/** 键盘通知方法 */
- (void)keyboardWillChangeFrame:(NSNotification *)noty {
    CGRect keyboardFrame = [noty.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 重新设置弹出View的高度
    self.keyBoardHeight = keyboardFrame.size.height;
    if (self.isFirst) {
        self.isFirst = NO;
        //设置bottomView的高度为所有控件的高度和空隙之和
        CGRect bottomFrame = self.backView.frame;
//        bottomFrame.size.height = self.keyBoardHeight + CGRectGetMaxY(self.forgetPWBtn.frame);
        bottomFrame.origin.y = self.bounds.size.height - bottomFrame.size.height;
        self.backView.frame = bottomFrame;
    }
}

/** 重新输入密码的通知 */
- (void)againInputPassWord {
    //所有的代表密码的黑色圆点隐藏
    for (int i = 0; i < 6; i++) {
//        UIImageView *pwImageView = self.pwArray[i];
//        pwImageView.hidden = YES;
    }
    //存储密码的字符串置为空
//    self.pwStr = nil;
//    //payTextField置为空
//    self.payTextField.text = nil;
//    //输入密码个数置为0
//    self.pwCount = 0;
}

/** 忘记密码的通知 */
- (void)forgetPassWord  {
//    [self deleteClick:nil];
}



#pragma mark - ConfigUI

- (void)setupUI {

    self.backgroundColor = [UIColor clearColor];

    [self addSubview:self.coverView];
    [self addSubview:self.backView];

    [self.backView addSubview:self.closeButton];
    [self.backView addSubview:self.line];
    [self.backView addSubview:self.passwordField];
    [self.backView addSubview:self.loadingImgView];
    [self.backView addSubview:self.tipLabel];
    
    self.coverView.frame = self.bounds;

    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.backView).offset(10);
        make.width.equalTo(@(40));
        make.height.equalTo(@(30));
    }];

    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView);
        make.top.equalTo(self.backView).offset(50);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@(0.5));
    }];

//    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.backView).offset((kScreenWidth - 44 * 6)/2.0);
//        make.top.equalTo(self.backView).offset(80);
//        make.width.equalTo(@(44 * 6));
//        make.height.equalTo(@(44));
//    }];

    
    self.passwordField.frame = CGRectMake((kScreenWidth - 44 * 6)/2.0, 80, 44 * 6, 44);

    self.loadingImgView.frame = CGRectMake((kScreenWidth-40)/2, 140, 40, 40);

    self.tipLabel.frame = CGRectMake((kScreenWidth-100)/2, 190, 100, 30);

    // 添加密码黑点
    [self addDotsViews];
}

/** 添加密码黑点 */
- (void)addDotsViews {
    //密码输入框的宽度
    CGFloat passwordFieldWidth = CGRectGetWidth(self.passwordField.frame);
    //六等分 每等分的宽度
    CGFloat password_width = passwordFieldWidth / kDotsNumber;
    //密码输入框的高度
    CGFloat password_height = CGRectGetHeight(self.passwordField.frame);

    for (int i = 0; i < kDotsNumber; i ++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(i * password_width, 0, 0.5, password_height)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.passwordField addSubview:line];

        //假密码点的x坐标
        CGFloat dotViewX = (i + 1)*password_width - password_width / 2.0 - kDotWith_height / 2.0;
        CGFloat dotViewY = (password_height - kDotWith_height) / 2.0;
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(dotViewX, dotViewY, kDotWith_height, kDotWith_height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotWith_height/2.0;
        dotView.hidden = YES;
        [self.passwordField addSubview:dotView];
        [self.passwordDotsArray addObject:dotView];
    }
}
// 将所有的假密码点设置为隐藏状态
- (void)setDotsViewHidden {
    for (UIView *view in _passwordDotsArray){
        [view setHidden:YES];
    }
}
- (void)setDotsViewShow {
    for (UIView *view in _passwordDotsArray){
        [view setHidden:NO];
    }
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];

//    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self);
//        make.top.equalTo(self).offset(kScreenHeight);
//        make.width.equalTo(@(kScreenWidth));
//        make.height.equalTo(@(kAutoWithSize(400)));
//    }];
    self.backView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kAutoWithSize(kOperationH+kTabbarSafeBottomMargin));

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{

//        [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self);
//            make.top.equalTo(self).offset(kScreenHeight-500);
//            make.width.equalTo(@(kScreenWidth));
//            make.height.equalTo(@(kAutoWithSize(400)));
//        }];
        self.backView.frame = CGRectMake(0, kScreenHeight-kAutoWithSize(kOperationH+kTabbarSafeBottomMargin), kScreenWidth, kAutoWithSize(kOperationH+kTabbarSafeBottomMargin));
    } completion:^(BOOL finished) {
    }];
    [self.passwordField becomeFirstResponder];
}

- (void)hide {
    [self close];
}

- (void)close {
    [self.passwordField resignFirstResponder];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self);
//            make.top.equalTo(self).offset(kScreenHeight);
//            make.width.equalTo(@(kScreenWidth));
//            make.height.equalTo(@(kAutoWithSize(400)));
//        }];
        self.backView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kAutoWithSize(kOperationH+kTabbarSafeBottomMargin));
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)startLoading {
    self.loadingImgView.hidden = NO;
    self.tipLabel.hidden = NO;
    self.passwordField.hidden = YES;
    [self setDotsViewHidden];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.loadingImgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopLoading {
    self.tipLabel.hidden = YES;
}

// 弹出密码错误视图
- (void)showPasswordErrorWithLimit:(NSInteger )limit {
    [self stopLoading];
    self.errorView = [[HHPasswordErrorView alloc] init];
    self.errorView.limit = limit;
    [self.errorView.onceButton addTarget:self action:@selector(clickOnceButton) forControlEvents:UIControlEventTouchUpInside];
    [self.errorView.forgetPwdButton addTarget:self action:@selector(clickForgetPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.errorView showInView:self.backView];
}
#pragma mark - 支付成功
- (void)paySuccess {
    self.tipLabel.text = @"支付成功";
    self.loadingImgView.image = [UIImage imageNamed:@"password_success"];
    [self.loadingImgView.layer removeAllAnimations];
}
#pragma mark - 支付失败 密码错误
- (void)payFailureWithPasswordError:(BOOL)passwordError withErrorLimit:(NSInteger)limit {
    self.loadingImgView.hidden = YES;
    if (passwordError) {
        [self showPasswordErrorWithLimit:limit];
    }
}

// 点击重新输入
- (void)clickOnceButton {
    [self.errorView hide];
    self.passwordField.hidden = NO;
    self.passwordField.text = @"";
    [self.passwordField becomeFirstResponder];
}
// 点击忘记密码
- (void)clickForgetPwd {
    [self hide];

    if ([_delegate respondsToSelector:@selector(forgetPayPassword)]) {
        [_delegate forgetPayPassword];
    }
}

#pragma mark


- (void)passwordFieldDidChange:(UITextField *)field {
    [self setDotsViewHidden];
    
    for (int i = 0; i < _passwordField.text.length; i ++){
        if (_passwordDotsArray.count > i ) {
            UIView *dotView = _passwordDotsArray[i];
            [dotView setHidden:NO];
        }
    }
    
    if (_passwordField.text.length == 6) {
        NSLog(@"密码 %@",_passwordField.text);
        [self startLoading];
        [self.passwordField resignFirstResponder];
        if ([_delegate respondsToSelector:@selector(passwordView:didFinishInputPayPassword:)]) {
            [_delegate passwordView:self didFinishInputPayPassword:_passwordField.text];
        }
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //删除键
    if (string.length == 0){
        return YES;
    }
    
    if (_passwordField.text.length >= kDotsNumber){
        return NO;
    }
    return YES;
}
#pragma mark - 懒加载控件
/** 蒙版 */
- (UIView *)coverView {
    if (_coverView == nil){
        _coverView = [[UIView alloc] init];
        [_coverView setBackgroundColor:[UIColor blackColor]];
        _coverView.alpha = 0.4;
    }
    return _coverView;
}
/** 背景图 */
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1];
    }
    return _backView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _closeButton;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor lightGrayColor];
    }
    return _line;
}
- (HHTextField *)passwordField {
    if (_passwordField == nil) {
        _passwordField = [[HHTextField alloc] init];
        _passwordField.delegate = (id)self;
        _passwordField.backgroundColor = [UIColor whiteColor];
        _passwordField.textColor = [UIColor clearColor];
        _passwordField.tintColor = [UIColor clearColor];
        _passwordField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _passwordField.layer.borderWidth = 0.5;
        _passwordField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordField.secureTextEntry = YES;
    }
    [_passwordField addTarget:self action:@selector(passwordFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    return _passwordField;
}

- (NSMutableArray *)passwordDotsArray{
    if (nil == _passwordDotsArray){
        _passwordDotsArray = [[NSMutableArray alloc] initWithCapacity:kDotsNumber];
    }
    return _passwordDotsArray;
}
- (UIImageView *)loadingImgView {
    if (_loadingImgView == nil) {
        _loadingImgView = [[UIImageView alloc] init];
        _loadingImgView.image = [UIImage imageNamed:@"password_loading_a"];
        [_loadingImgView sizeToFit];
        _loadingImgView.hidden = YES;
    }
    return _loadingImgView;
}
- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"支付中...";
        _tipLabel.hidden = YES;
        _tipLabel.textColor = [UIColor darkGrayColor];
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [_tipLabel sizeToFit];
    }
    return _tipLabel;
}

/** 标题 */
- (UILabel *)promptLabel {
    if (_promptLabel == nil) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.text = @"输入六位支付密码";
        _promptLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _promptLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        [_promptLabel sizeToFit];
    }
    return _promptLabel;
}


/** 忘记密码 */
- (UIButton *)forgetButton {
    if (_forgetButton == nil) {
        _forgetButton = [[UIButton alloc] init];
        [_forgetButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetButton setTitleColor:[UIColor colorWithHexString:@"#F08327"] forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        [_forgetButton sizeToFit];
        [_forgetButton addTarget:self action:@selector(clickForgetPwd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}



@end
