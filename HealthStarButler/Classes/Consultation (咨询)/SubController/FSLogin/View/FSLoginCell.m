//
//  FSLoginCell.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/14.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSLoginCell.h"
#import "FSLoginMData.h"

@interface  FSLoginCell()<UITextFieldDelegate>

/** 提示文字 */
@property (nonatomic , strong) UILabel *title;
/** 详情 */
@property (nonatomic , strong) UITextField *textField ;
/** 登录 */
@property (nonatomic , strong) UIButton *login;
/** 线 */
@property (nonatomic , strong) UIView *line;
/** 忘记密码 */
@property (nonatomic , strong) UILabel *forget;

@end

@implementation FSLoginCell

#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - DataSet

- (void)setRowMData:(FSLoginMData *)rowMData {
    
    _rowMData = rowMData;
    self.title.text = rowMData.title;
    self.textField.placeholder = rowMData.placeholder;
    self.login.enabled = rowMData.enabled;
    self.forget.text = rowMData.title;
    /** 用户名 */
    if (rowMData.loginCellType == FSLoginCellTypeUserAcount) {
        self.textField.hidden = NO;
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        //        [self.textField becomeFirstResponder];
        self.textField.leftView = [FSTextFieldItem creatTextFieldItemWithFrame:CGRectMake(0, 0, 30, 20) normalImageName:@"user" seletedImageName:@"user" itemType:FSTextFieldItemTypeLeft];
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        self.textField.rightView = [FSTextFieldItem creatTextFieldItemWithFrame:CGRectMake(0, 0, 30, 20) normalImageName:@"login_up" seletedImageName:@"login_up" itemType:FSTextFieldItemTypeRight];
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        /** 密码 */
    } else if (rowMData.loginCellType == FSLoginCellTypePassword) {
        self.textField.hidden = NO;
        self.textField.keyboardType = UIKeyboardTypeASCIICapable;
        self.textField.secureTextEntry = YES;
        self.textField.leftView = [FSTextFieldItem creatTextFieldItemWithFrame:CGRectMake(0, 0, 30, 20) normalImageName:@"password" seletedImageName:@"password" itemType:FSTextFieldItemTypeLeft];
        
        self.textField.rightView = [FSTextFieldItem creatTextFieldItemWithFrame:CGRectMake(0, 0, 30, 20) normalImageName:@"eye_close" seletedImageName:@"eye_open" itemType:FSTextFieldItemTypeRight];
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        /** 登录 */
    }else if (rowMData.loginCellType == FSLoginCellTypeLogin) {
        self.textField.hidden = YES;
        self.login.hidden = NO;
        self.line.hidden = YES;
    } else if (rowMData.loginCellType == FSLoginCellTypeCode) {
        self.textField.hidden = NO;
        self.login.hidden = YES;
        self.line.hidden = YES;
        self.forget.hidden = NO;
        self.textField.leftView = [FSTextFieldItem creatTextFieldItemWithFrame:CGRectMake(0, 0, 30, 20) normalImageName:@"code" seletedImageName:@"code" itemType:FSTextFieldItemTypeLeft];
        self.textField.leftViewMode = UITextFieldViewModeAlways;
    }else if (rowMData.loginCellType == FSLoginCellTypeForget) {
        self.textField.hidden = YES;
        self.login.hidden = YES;
        self.line.hidden = YES;
        self.forget.hidden = NO;
    }
    
}
- (void)configurationCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.textField];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    
    if ([self.delegate respondsToSelector:@selector(FSLoginCellDelegateDidClick:)]) {
        [self.delegate FSLoginCellDelegateDidClick:self];
    }
}

- (void)textChange: (NSNotification *)noti {
    if (self.textField.text.length) {
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        
    } else {
        self.textField.rightViewMode = UITextFieldViewModeNever;
    }
    NSInteger kMaxLength = 5;
    NSString *toBeString = self.textField.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [self.textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self.textField positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > kMaxLength) {
                self.textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        else{//有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            self.textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
    
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(loginCell:loginMData:textField:)]) {
    //        [self.delegate loginCell:self loginMData:self.rowMData textField:self.details];
    //    }
    
}

#pragma mark - 监听login按钮的状态
- (void)changeStatueWithStatue: (BOOL)statue {
    self.login.enabled = statue;
    if (statue) {
        [self.login setTitleColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] forState:UIControlStateNormal];
        
        [self.login setBackgroundColor:[UIColor colorWithHexString:@"#FFA200"] forState:UIControlStateNormal];
    } else {
        [self.login setTitleColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.4] forState:UIControlStateDisabled];
        [self.login setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.3] forState:UIControlStateDisabled];
    }
}

#pragma mark - ConfigUI

- (void)configUI {
    
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kAutoWithSize(kMargin32));
        make.right.equalTo(self).offset(-kAutoWithSize(kMargin32));
        make.top.equalTo(self).offset(kAutoHeightSize(kMargin10));
        make.bottom.equalTo(self).offset(-kAutoHeightSize(kMargin10));
    }];
    
    [self addSubview:self.login];
    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField);
        make.top.equalTo(self).offset(kAutoHeightSize(kMargin10));
        make.right.equalTo(self).offset(-kAutoWithSize(kMargin32));
        if (iPhoneX) {
            make.height.equalTo(@(kAutoHeightSize(40)));
        } else {
            make.height.equalTo(@(kAutoHeightSize(kMargin44)));
        }
    }];
    
    [self addSubview:self.forget];
    [self.forget mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.textField);
        make.centerY.equalTo(self);
    }];
    //
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField);
        make.right.equalTo(self.textField);
        make.bottom.equalTo(self).offset(0.5);
        make.height.equalTo(@0.5);
    }];
}



#pragma mark - Event
#pragma mark 点击事件
- (void)clickButton: (UIButton *)button {
    //    if (button.tag == XFSLoginCellButtonTypeclear) {
    //        self.textField.text = nil;
    //        return;
    //    }
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(loginCell:buttonType:)]) {
    //        [self.delegate loginCell:self buttonType:button.tag];
    //    }
}

#pragma mark - LazyGet

- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        _line.alpha = 0.4;
    }
    return _line;
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _title.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    }
    return _title;
}

- (UIButton *)login {
    if (_login == nil) {
        _login = [[UIButton alloc] init];
        [_login setTitle:@"登 录" forState:UIControlStateNormal];
        // _login.tag = XFSLoginCellButtonTypeLogin;
        [_login setTitleColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5] forState:UIControlStateNormal];
        [_login addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _login.hidden = YES;
        _login.backgroundColor = [UIColor colorWithHexString:@"#FFA200"];
        // [_login setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.3] forState:UIControlStateDisabled];
        _login.layer.masksToBounds = YES;
        _login.layer.cornerRadius = 2;
        _login.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    }
    return _login;
}

- (UILabel *)forget {
    if (_forget == nil) {
        _forget = [[UILabel alloc]init];
        _forget.hidden = YES;
        _forget.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    }
    return _forget;
}

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc]init];
        _textField.delegate = self;
        _textField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        // clear.tag = XFSLoginCellButtonTypeclear;
        _textField.tintColor = [UIColor colorWithHexString:@"#FFA200"];
    }
    return _textField;
}


@end
