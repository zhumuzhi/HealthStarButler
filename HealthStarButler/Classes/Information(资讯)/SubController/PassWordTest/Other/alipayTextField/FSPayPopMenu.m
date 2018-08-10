//
//  FSPayPopMenu.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/9.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSPayPopMenu.h"


@interface FSPayPopMenu ()<UITextFieldDelegate>
/** 背景View */
@property (nonatomic, strong) UIView *backView;
/** 头部视图 */
@property (nonatomic, strong) UIView *headerView;
/** 标题 */
@property (nonatomic, strong) UILabel *promptLabel;
/** 忘记密码 */
@property (nonatomic, strong) UIButton *forgetPWBtn;

/** 显示密码的数量 */
@property (nonatomic,assign) int pwCount;

/** 存放背景颜色是 黑色点 的UIImageView */
@property (nonatomic, strong) NSMutableArray *pwArray;

/** 键盘的高度 */
@property (nonatomic,assign) CGFloat keyBoardHeight;

/** 表示在弹出键盘的时候只设置bottomView的高度一次 */
@property (nonatomic,assign) BOOL isFirst;
/** 存储密码 */
@property (nonatomic,copy) NSMutableString *pwStr;

@end

@implementation FSPayPopMenu

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 监听键盘的位置改变
        // 监听键盘的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        //监听重新输入密码的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(againInputPW) name:@"againInputPassWord" object:nil];
        //监听忘记密码的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forgetPassWord) name:@"forgetInputPassWord" object:nil];
        //默认yes
        self.isFirst = YES;
        //默认是0，就是密码没有输入
        self.pwCount = 0;
        //创建UI
        [self configUI];
    }
    return self;
}

#pragma mark - NSNotificationMethod

/** 键盘通知方法 */
- (void)keyboardWillChangeFrame:(NSNotification *)noty {
    CGRect keyboardFrame = [noty.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyBoardHeight = keyboardFrame.size.height;

    if (self.isFirst) {
        self.isFirst = NO;
        //设置bottomView的高度为所有控件的高度和空隙之和
        CGRect bottomFrame = self.backView.frame;
        bottomFrame.size.height = self.keyBoardHeight + CGRectGetMaxY(self.forgetPWBtn.frame);
        bottomFrame.origin.y = self.bounds.size.height - bottomFrame.size.height;
        self.backView.frame = bottomFrame;
    }
}

/** 重新输入密码的通知 */
- (void)againInputPW {
    //所有的代表密码的黑色圆点隐藏
    for (int i = 0; i < 6; i++) {
        UIImageView *pwImageView = self.pwArray[i];
        pwImageView.hidden = YES;
    }
    //存储密码的字符串置为空
    self.pwStr = nil;
    //payTextField置为空
    self.payTextField.text = nil;
    //输入密码个数置为0
    self.pwCount = 0;
}

/** 忘记密码的通知 */
- (void)forgetPassWord  {
    [self deleteClick:nil];
}

#pragma mark - configUI
/** 创建UI */
- (void)configUI {

    CGFloat Margin = kAutoWithSize(10.f) ;
    CGFloat headerH = kAutoWithSize(42.f);

    //创建白色view
    [self addSubview:self.backView];
    CGFloat bottomH = kAutoWithSize(100.f);
    CGFloat bottomY = self.bounds.size.height - bottomH;
    self.backView.frame = CGRectMake(0, bottomY, self.bounds.size.width, bottomH);

    //创建白色头上的提示view
    [self.backView addSubview:self.headerView];
    self.headerView.frame = CGRectMake(0, 0, self.backView.bounds.size.width, headerH);

    CGFloat lineH = 1.0f;
    //灰色的横线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lineView.frame = CGRectMake(0, self.headerView.bounds.size.height-lineH, self.headerView.bounds.size.width, lineH);
    [self.headerView addSubview:lineView];

    CGFloat buttonH = kAutoWithSize(40.0f);
    //删除(左上角的叉号)
    UIButton *deleteBtn = [[UIButton alloc] init];
    deleteBtn.bounds = CGRectMake(0, 0, buttonH, buttonH);
    deleteBtn.center = CGPointMake(deleteBtn.bounds.size.width/2 + Margin, self.headerView.bounds.size.height/2);
    [deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:deleteBtn];

    //输入密码提示
    [self.headerView addSubview:self.promptLabel];
    self.promptLabel.center = CGPointMake(self.headerView.bounds.size.width/2, self.headerView.bounds.size.height/2);

    CGFloat TextFieldMargin = kAutoWithSize(20.0f);
    //FSPayTextField
    [self.backView addSubview:self.payTextField];
    //payTextField的高度为6等份的宽度
    self.payTextField.frame = CGRectMake(Margin, CGRectGetMaxY(self.headerView.frame) + TextFieldMargin, self.backView.bounds.size.width - TextFieldMargin, (self.backView.bounds.size.width - TextFieldMargin) / 6);
    //创建5条竖线来分割payTextField
    for (int i = 0; i < 5; i++) {
        UIImageView *lineImageView = [[UIImageView alloc] init];
        CGFloat lineX = self.payTextField.bounds.size.width / 6;
        lineImageView.frame = CGRectMake(lineX * (i + 1) + Margin, self.payTextField.frame.origin.y, 1, self.payTextField.bounds.size.height);
        lineImageView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        [self.backView addSubview:lineImageView];
    }
    //在分割好的6个框中间都放入一个 黑色的圆点 来代表输入的密码
    for (int i = 0; i < 6; i++) {
        UIImageView *passWordImageView = [[UIImageView alloc] init];
        CGFloat pwX = self.payTextField.bounds.size.width / 6;
        passWordImageView.bounds = CGRectMake(0, 0, Margin, Margin);
        passWordImageView.center = CGPointMake(pwX/2 + pwX * i + Margin, self.payTextField.frame.origin.y + self.payTextField.bounds.size.height/2);
        passWordImageView.backgroundColor = [UIColor blackColor];
        passWordImageView.layer.cornerRadius = Margin/2;
        passWordImageView.clipsToBounds = YES;
        passWordImageView.hidden = YES;
        [self.backView addSubview:passWordImageView];
        [self.pwArray addObject:passWordImageView];
    }
    //忘记密码
    [self.backView addSubview:self.forgetPWBtn];
    self.forgetPWBtn.frame = CGRectMake(self.backView.bounds.size.width - self.forgetPWBtn.bounds.size.width - Margin, CGRectGetMaxY(self.payTextField.frame) + Margin, self.forgetPWBtn.bounds.size.width, self.forgetPWBtn.bounds.size.height);
}

#pragma mark - Event

/** 删除方法，即是左上角的叉号的方法 */
- (void)deleteClick:(UIButton *)sender {
    //    [self.coverView removeFromSuperview];
    //隐藏
    self.hidden = YES;
    //退出键盘
    [self.payTextField endEditing:YES];
    //所有的代表密码的黑色圆点隐藏
    for (int i = 0; i < 6; i++) {
        UIImageView *pwImageView = self.pwArray[i];
        pwImageView.hidden = YES;
    }
    //存储密码的字符串置为空
    self.pwStr = nil;
    //payTextField置为空
    self.payTextField.text = nil;
    //输入密码个数置为0
    self.pwCount = 0;
}

/** 忘记密码 */
- (void)forgetPWclick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(payPopMenuClickedForgetPassWord:)]) {
        [self deleteClick:nil];
        [self.delegate payPopMenuClickedForgetPassWord:self];
    }
}

/** UITextFieldDelegate代理方法 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {//点击的是键盘的删除按钮
        //输入密码的个数－1
        self.pwCount--;
        //deleteCharactersInRange: 删除存储密码的字符串pwStr的最后一位
        [self.pwStr deleteCharactersInRange:NSMakeRange(self.pwStr.length-1, 1)];
        return YES;
    }else if (self.pwCount == 6)//输入的密码个数最多是6个
    {
        return NO;//返回no，不能够在输入
    } else {
        //在存储密码的字符串的后面假如一位输入的数字
        [self.pwStr appendString:string];
        //输入密码的个数＋1
        self.pwCount = self.pwCount + 1;
    }
    return YES;
}

/** UIControlEventEditingChanged的方法 */
- (void)textChange:(UITextField *)textField {
    //每一次输入密码的时候，都把payTextField设置为空
    self.payTextField.text = nil;

    //根据输入的密码的个数(pwCount)，来给payTextField设置@" "，这样就看不见payTextField里面的内容，也就是用@" "来代替输入的数字
    NSString *str = [NSString string];
    for (int i = 0; i < self.pwCount; i++) {
        str = [str stringByAppendingString:@" "];
        //输入多少个数字，那么pwArray中存储的UIImageView就有多少个显示
        UIImageView *pwImageView = self.pwArray[i];
        pwImageView.hidden = NO;
    }
    //其余的pwArray中存储的UIImageView就不显示
    for (int i = 5; i >= self.pwCount; i--) {
        UIImageView *pwImageView = self.pwArray[i];
        pwImageView.hidden = YES;
    }
    self.payTextField.text =str;
    NSLog(@"textChange==%@",self.pwStr);
    if (self.pwStr.length == 6) {
        if ([self.pwStr isEqualToString:@"199103"]) {//如果输入的密码是199103表示输入密码正确
            NSLog(@"密码正确==%@",self.pwStr);
            if ([self.delegate respondsToSelector:@selector(payPopMenuInputCorrect:)]) {
                [self deleteClick:nil];
                [self.delegate payPopMenuInputCorrect:self];
            }
        }else{
            NSLog(@"密码错误＝＝%@",self.pwStr);
            if ([self.delegate respondsToSelector:@selector(payPopMenuWrongPassWord:)]) {
                [self.delegate payPopMenuWrongPassWord:self];
            }
        }
    }
}

#pragma mark - LizyGet
- (NSMutableArray *)pwArray {
    if (_pwArray == nil) {
        _pwArray = [NSMutableArray array];
    }
    return _pwArray;
}
- (NSMutableString *)pwStr {
    if (_pwStr == nil) {
        _pwStr = [NSMutableString string];
    }
    return _pwStr;
}

/** backView */
- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

/** HeadView */
-(UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
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

/** PayTextField */
- (FSPayTextField *)payTextField {
    if (_payTextField == nil) {
        _payTextField = [[FSPayTextField alloc] init];
        //设置样式
        _payTextField.borderStyle =  UITextBorderStyleNone;
        _payTextField.layer.borderWidth = 1.0f;
        //payTextField.layer.cornerRadius = 0.0f;
        _payTextField.layer.borderColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1].CGColor;
        //设置payTextField的键盘
        _payTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _payTextField.keyboardType = UIKeyboardTypeNumberPad;
        //取消payTextField的光标
        _payTextField.tintColor = [UIColor clearColor];
        //    [payTextField becomeFirstResponder];
        _payTextField.delegate = self;
        //UIControlEventEditingChanged的方法
        [_payTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _payTextField;
}

/** 忘记密码 */
- (UIButton *)forgetPWBtn {
    if (_forgetPWBtn == nil) {
        _forgetPWBtn = [[UIButton alloc] init];
        [_forgetPWBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetPWBtn setTitleColor:[UIColor colorWithHexString:@"#F08327"] forState:UIControlStateNormal];
        _forgetPWBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        [_forgetPWBtn sizeToFit];
        [_forgetPWBtn addTarget:self action:@selector(forgetPWclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPWBtn;
}




@end
