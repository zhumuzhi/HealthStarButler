//
//  MEDUserLoginController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/24.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDUserLoginController.h"
#import "MEDMobileNumberTool.h"
#import "AppDelegate.h"

@interface MEDUserLoginController ()<UITextFieldDelegate>
{
    /** 头像 */
    UIImageView *_headImageView;
    /** 用户名密码 */
    UITextField *_userName,*_passWord;
    /** 点击事件 */
    UIControl *_loginControl;
}

@end

@implementation MEDUserLoginController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /** 视图配置 */
    [self configUIView];
}

#pragma mark - UI Config
/** 设置界面 */
- (void)configUIView
{
    //头像
    CGFloat headImageW = 70.0f;
    CGFloat headImageX = (SCREEN_WIDTH*0.5)-(headImageW*0.5);
    CGFloat headImageY = SCREEN_HEIGHT/8;
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headImageX, headImageY, headImageW, headImageW)];
    _headImageView = headImageView;
    
    NSString *photoURL = [MEDUserModel sharedUserModel].userPhoto;
    if ((photoURL.length == 0) || ([photoURL isEqualToString:@"http://miot.mmednet.comnull"]))  {
            _headImageView.image = [UIImage imageNamed:@"list_denglutouxiang"];
    }else {
        NSURL *url = [NSURL URLWithString:photoURL];
        _headImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    }
    _headImageView.layer.cornerRadius  = 35;
    _headImageView.layer.masksToBounds = YES;
    [self.view addSubview:headImageView];
    
    CGFloat EdgePadding = 17.5f;
    CGFloat TextFieldBorderW = 0.5f;
    CGFloat TextFieldCornerR = 5.0f;
    UIColor *TextFieldColor = MEDGrayColor(170);
    UIColor *TextFieldBoderColor = MEDGrayColor(229);
    UIFont *TextFieldFont = MEDSYSFont(16);
    
    //手机号/用户名
    CGFloat UserNameX = EdgePadding;
    CGFloat UserNameY = CGRectGetMaxY(_headImageView.frame) + 75.0f;
    CGFloat UserNameW = SCREEN_WIDTH - (EdgePadding * 2);
    CGFloat UserNameH = 39.0f;
    UITextField *userName = [[UITextField alloc] initWithFrame:CGRectMake(UserNameX, UserNameY, UserNameW, UserNameH)];
    _userName = userName;
    _userName.layer.cornerRadius = TextFieldCornerR;
    _userName.layer.masksToBounds = YES;
    _userName.layer.borderWidth = TextFieldBorderW;
    _userName.layer.borderColor = TextFieldBoderColor.CGColor;
    UIImageView *userImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_shoujihao"]];//image
    userImage.frame = CGRectMake(0, 0, 30, 30);
    _userName.leftView = userImage;
    _userName.leftViewMode = UITextFieldViewModeAlways;
    _userName.placeholder = @"手机号";//text
    _userName.textColor = TextFieldColor;
    _userName.font = TextFieldFont;
    _userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userName.keyboardType = UIKeyboardTypeNumberPad;
    _userName.delegate = self;
    [self.view addSubview:_userName];
    
    //密码
    CGFloat PassWordX = EdgePadding;
    CGFloat PassWordY = CGRectGetMaxY(_userName.frame)+12.0f;
    CGFloat PassWordW = SCREEN_WIDTH - (EdgePadding*2);
    CGFloat PassWordH = UserNameH;
    _passWord = [[UITextField alloc]initWithFrame:CGRectMake(PassWordX, PassWordY, PassWordW, PassWordH)];
    _passWord.layer.cornerRadius = TextFieldCornerR;
    _passWord.layer.masksToBounds = YES;
    _passWord.layer.borderWidth = TextFieldBorderW;
    _passWord.layer.borderColor = TextFieldBoderColor.CGColor;
    UIImageView *passImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_mima"]];//image
    passImage.frame = CGRectMake(0, 0, 30, 30);
    _passWord.leftView = passImage;
    _passWord.leftViewMode = UITextFieldViewModeAlways;
    _passWord.placeholder = @"密码";
    _passWord.textColor = TextFieldColor;
    _passWord.font = TextFieldFont;
    _passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passWord.secureTextEntry = YES;
    _passWord.clearsOnBeginEditing = YES;
    _passWord.delegate = self;
    [self.view addSubview:_passWord];
    
    //登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor = MEDCommonBlue;
    loginBtn.frame = CGRectMake(EdgePadding, CGRectGetMaxY(_passWord.frame) + 30, _passWord.frame.size.width, _passWord.frame.size.height);
    loginBtn.layer.cornerRadius = 5;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTintColor:MEDGrayColor(238)];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    //忘记密码
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize forgetBtnSize =   [@"忘记密码?" sizeWithAttributes:@{NSFontAttributeName : MEDSYSFont(20)                                                                   }];
    CGFloat ForgetBtnX = SCREEN_WIDTH - forgetBtnSize.width - EdgePadding;
    CGFloat ForgetBtnY = CGRectGetMaxY(loginBtn.frame)+12;
    CGFloat ForgetBtnW = forgetBtnSize.width;
    CGFloat ForgetBtnH = 30;
    forgetBtn.frame = CGRectMake(ForgetBtnX, ForgetBtnY, ForgetBtnW, ForgetBtnH);
    
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = MEDSYSFont(12);
    [forgetBtn setTitleColor:MEDGrayColor(102) forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    [self closeKeyBoardSet];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationItem.hidesBackButton = YES;
}


#pragma mark - Custom Method


#pragma mark - UITextFieldDelegate
//这两个代理方法主要实现输入时弹出键盘6以下机型不会挡住控件
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = - 40;
        self.view.frame = frame;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
}

#pragma mark - Action 响应事件

/** 登录 */
- (void)loginBtnClick
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //过滤空格
    NSString *phoneNum = [_userName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([_userName.text isEqualToString:@""]){
        [MEDProgressHUD dismissHUDErrorTitle:@"请输入用户名或手机号"];
        return;
    } else if (![MEDMobileNumberTool isMobileNumber:phoneNum onlyMobile:YES]) {
        [MEDProgressHUD dismissHUDErrorTitle:@"请输入正确手机号"];
        return;
    } else {
        // 文本框获取账号
        [param setObject:_userName.text forKey:TELEPHONE_NUMBER];
    }
    
    if ([_passWord.text isEqualToString:@""]) {
        [MEDProgressHUD dismissHUDErrorTitle:@"请重新输入密码"];
        return;
    } else {
        // 从文本框获取密码
        [param setObject:_passWord.text forKey:PASSWORD];
    }
    
    [param setObject:@"2" forKey:@"system_type"];
    [param setObject:@"1" forKey:@"apply_type"];
    
    //偏好设置
    NSMutableDictionary *userDefaulsDict = [NSMutableDictionary dictionary];
    [userDefaulsDict setObject:_userName.text forKey:TELEPHONE_NUMBER];
    [userDefaulsDict setObject:_passWord.text forKey:PASSWORD];
    
    BOOL deviceTokenNotEmpty = [[kUserDefaults objectForKey:DEVICETOKEN] isNotEmpty];
    if (deviceTokenNotEmpty) {
        [param setObject:[kUserDefaults objectForKey:DEVICETOKEN] forKey:Identity];
    }
    [kUserDefaults setObject:userDefaulsDict forKey:LoginInfo];
    [kUserDefaults synchronize];
    
    //NSLog(@"登录的参数字典:%@", param);
    [MEDDataRequest POST:MED_USER_LOGIN params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        [self loginControlClick:self->_loginControl];
        //NSLog(@"登录页面返回的信息:%@",responseObject);
        if (NetStatusSuccessful(responseObject)) {
            MEDUserModel *userModel = [MEDUserModel sharedUserModel];
            NSDictionary *userInfoDict = responseObject[Data];
            userModel = [MEDUserModel mj_objectWithKeyValues:userInfoDict];
            //NSLog(@"登录成功后模型%@", userModel);
            
            //用户信息中有<null>值("im_username": null)，直接用UserDefaults保存会报错，所以转换为字符串保存; 尝试调整模型后直接保存用户模型
            NSString *dataString = [self convertToJSONData:userInfoDict];
            [kUserDefaults setObject:dataString forKey:UserInfo]; //保存用户信息Str
            
            
            [kUserDefaults setObject:userModel.uid forKey:UID];  //保存uid,方便使用
            [kUserDefaults setObject:LoginSuccessful forKey:Login];// 保存登录状态
            [kUserDefaults synchronize];
            //切换首页(根据登录状态判断)
            [kAppDelegate mainTabBarSwitch];
            
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"登录失败,错误参数:%@", error);

        [MEDProgressHUD dismissHUDErrorTitle:@"登录失败\n请重新登陆"];
        [kUserDefaults setObject:LoginFailed forKey:Login];
        [kUserDefaults synchronize];
//        [kAppDelegate mainTabBarSwitch];
        
    }];
    
}

/** 忘记密码 */
- (void)forgetBtnClick
{
    [self loginControlClick:_loginControl];
}

/** 键盘退出设置 */
- (void)closeKeyBoardSet {
    _loginControl = [[UIControl alloc] initWithFrame:self.view.bounds];
    [_loginControl addTarget:self action:@selector(loginControlClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginControl];
    [self.view sendSubviewToBack:_loginControl];
}

- (void)loginControlClick:(UIControl *)control
{
    [_loginControl resignFirstResponder];
    [_userName resignFirstResponder];
    [_passWord resignFirstResponder];
}


@end
