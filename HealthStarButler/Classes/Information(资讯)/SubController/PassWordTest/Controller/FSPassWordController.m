//
//  FSPassWordController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/8.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSPassWordController.h"

#pragma mark ZJPayPasswordView
#import "FSPayPopupView.h"

#pragma mark HHPayPasswordView
#import "HHPayPasswordView.h"

#pragma mark JHCoverView
#import "FSPayPopMenu.h"

@interface FSPassWordController ()<
                                    FSPayPopupViewDelegate,
                                    HHPayPasswordViewDelegate,
                                    FSPayPopMenuDelegate
                                    >
@property (nonatomic, strong) FSPayPopupView *payPopupView;
@property (nonatomic, strong) FSPayPopMenu *coverView;

@end

@implementation FSPassWordController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];
}

#pragma mark - configUI
- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *ZJPayPass = [self createBtnTitle:@"ZJPayPass" Selector:@selector(buttonAction:)];
    ZJPayPass.tag = 0;
    [self.view addSubview:ZJPayPass];
    [ZJPayPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.height.mas_equalTo(50);
    }];

    UIButton *HHPayPass = [self createBtnTitle:@"HHPayPass" Selector:@selector(buttonAction:)];
    HHPayPass.tag = 1;
    [self.view addSubview:HHPayPass];
    [HHPayPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ZJPayPass.mas_left);
        make.right.equalTo(ZJPayPass.mas_right);
        make.top.equalTo(ZJPayPass.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];

    UIButton *JHCoverbtn = [self createBtnTitle:@"JHCoverView" Selector:@selector(buttonAction:)];
    JHCoverbtn.tag = 2;
    [self.view addSubview:JHCoverbtn];
    [JHCoverbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(HHPayPass.mas_left);
        make.right.equalTo(HHPayPass.mas_right);
        make.top.equalTo(HHPayPass.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];

    [self.view addSubview:self.coverView];
    self.coverView.frame = self.view.bounds;
}

/** 创建按钮 */
- (UIButton *)createBtnTitle:(NSString *)title Selector:(SEL)selector {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = MEDCommonBlue;
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)buttonAction:(UIButton *)button {
    if(button.tag == 0) {   // 展示FSPay
        self.payPopupView = [[FSPayPopupView alloc] init];
        self.payPopupView.delegate = self;
        [self.payPopupView showPayPopView];
    }else if (button.tag == 1) { // 展示HHPay
        HHPayPasswordView *payPasswordView = [[HHPayPasswordView alloc] init];
        payPasswordView.delegate = self;
        [payPasswordView showInView:self.view];
    }else if (button.tag == 2) {
        self.coverView.hidden = NO;
        [self.coverView.payTextField becomeFirstResponder];

    }
}

- (FSPayPopMenu *)coverView {
    if (_coverView == nil) {
        _coverView = [[FSPayPopMenu alloc] initWithFrame:self.view.bounds];
        _coverView.delegate = self;
        _coverView.hidden = YES;
        _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    }
    return _coverView;
}

#pragma mark - CommonDelegate

#pragma mark ---------------- FSPayPopMenuDelegate ----------------

/** 忘记密码 */
- (void)payPopMenuClickedForgetPassWord:(FSPayPopMenu *)payPopMenu {
    NSLog(@"跳转至忘记密码");
}
/** JHCoverViewDelegate的代理方法,密码输入错误 */
- (void)payPopMenuWrongPassWord:(FSPayPopMenu *)payPopMenu {
    UIAlertController *altertConl = [UIAlertController alertControllerWithTitle:@"" message:@"支付密码不正确，你还可以输入3次" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *againInputAction = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //通知重新输入密码的时候，以前输入的密码清空
        [[NSNotificationCenter defaultCenter] postNotificationName:@"againInputPassWord" object:nil];
    }];
    UIAlertAction *forgetPWAction = [UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        JHForgetPWViewController *forgetControl = [[JHForgetPWViewController alloc] init];
        //跳转忘记密码界面的时候，通知 输入密码关闭
        [[NSNotificationCenter defaultCenter] postNotificationName:@"forgetInputPassWord" object:nil];
//        [self.navigationController pushViewController:forgetControl animated:YES];
        NSLog(@"跳转至忘记密码");
    }];
    [altertConl addAction:againInputAction];
    [altertConl addAction:forgetPWAction];
    [self presentViewController:altertConl animated:YES completion:nil];
}

/** JHCoverViewDelegate的代理方法，密码输入正确 */
- (void)payPopMenuInputCorrect:(FSPayPopMenu *)payPopMenu {
    NSLog(@"跳转至成功");
}


#pragma mark ---------------- FSPayPopupViewDelegate ----------------
// 输入结束
- (void)payPopupViewPasswordInputFinished:(NSString *)password {
    if ([password isEqualToString:@"111111"]) {
        NSLog(@"输入的密码正确");
        
    }else {
        NSLog(@"输入错误:%@",password);
//        [self.payPopupView hidePayPopView];
        [self.payPopupView didInputPayPasswordError];
    }
}
// 忘记密码
- (void)payPopupViewDidClickForgetPasswordButton:(FSPayPopupView *)payPopupView {
    NSLog(@"点击了忘记密码");
}


#pragma mark ---------------- HHPayPasswordViewDelegate ----------------
- (void)passwordView:(HHPayPasswordView *)passwordView didFinishInputPayPassword:(NSString *)password{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([password isEqualToString:@"000000"]) {
            [passwordView paySuccess];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [passwordView hide];
                NSLog(@"支付成功控制器");
//                PaySuccessViewController *paySuccessVC = [[PaySuccessViewController alloc] init];
//                [self.navigationController pushViewController:paySuccessVC animated:YES];
            });
        }else{
            [passwordView payFailureWithPasswordError:YES withErrorLimit:3];
        }
    });
}

- (void)forgetPayPassword{
    NSLog(@"HH忘记密码");
}

#pragma mark - LazyGet

@end
