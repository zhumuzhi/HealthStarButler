//
//  MEDStautsController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/5.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDStatusController.h"

@interface MEDStatusController ()

/** 状态栏样式 */
@property (assign, nonatomic) UIStatusBarStyle statusBarStyle;
/** 状态栏显示 */
@property (assign, nonatomic) BOOL  statusBarHidden;

@end

@implementation MEDStatusController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"StatusBarSet";

    [self configTestStatusBar];

    
}

/* 设置Statusbar */
- (void)configTestStatusBar {

    NSArray *array1 = @[@"黑字", @"白字"];
    UISegmentedControl *segment1 = [[UISegmentedControl alloc] initWithItems:array1];
    [self.view addSubview:segment1];

    [segment1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNavigationHeight+50);
        make.centerX.equalTo(self.view);
    }];
    [segment1 addTarget:self action:@selector(changeStyle:) forControlEvents:UIControlEventValueChanged];

    NSArray *array2 = @[@"显示", @"隐藏"];
    UISegmentedControl *segment2 = [[UISegmentedControl alloc] initWithItems:array2];
    [self.view addSubview:segment2];
    [segment2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segment1).offset(50);
        make.centerX.equalTo(self.view);
    }];
    [segment2 addTarget:self action:@selector(statusShowOrHidden:) forControlEvents:UIControlEventValueChanged];

}

- (void)changeStyle:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _statusBarStyle = UIStatusBarStyleDefault;
    } else {
        _statusBarStyle = UIStatusBarStyleLightContent;
    }
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)statusShowOrHidden:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _statusBarHidden = NO;
    } else {
        _statusBarHidden = YES;
    }
    [self setNeedsStatusBarAppearanceUpdate];
}


/**
 *  控制状态栏的样式
 *  要刷新状态栏，让其重新执行该方法需要调用{-setNeedsStatusBarAppearanceUpdate}
 *  @return 将要显示的状态栏样式
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    NSLog(@"导航栏-%s",__func__);
    // UIStatusBarStyleDefault
    return _statusBarStyle;
}
/**
 *  状态栏显示还是隐藏
 *  要刷新状态栏，让其重新执行该方法需要调用{-setNeedsStatusBarAppearanceUpdate}
 *  @return BOOL值
 */
- (BOOL)prefersStatusBarHidden
{
    NSLog(@"导航栏-%s",__func__);
    return _statusBarHidden;
}
/**
 *  状态栏改变的动画，这个动画只影响状态栏的显示和隐藏
 *  @return 动画效果
 */
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    NSLog(@"导航栏-%s",__func__);
    return UIStatusBarAnimationSlide;
}

@end
