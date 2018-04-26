//
//  MEDMineController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDMineController.h"
#import "AppDelegate.h"

@interface MEDMineController ()

@end

@implementation MEDMineController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    [self navigationConfig];
    
}

- (void)navigationConfig
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    rightButton.frame = CGRectMake(0, 0, 60, 44);
    [rightButton addTarget:self action:@selector(clickQuitButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)clickQuitButton
{
    UIAlertController *quitAlert = [UIAlertController alertControllerWithTitle:@"退出确认" message:@"请问您是够确定退出？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消退出");
    }];
    UIAlertAction *confimAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [kUserDefaults setObject:LoginFailed forKey:Login];
        [kAppDelegate mainTabBarSwitch];
        
    }];
    [quitAlert addAction:cancelAction];
    [quitAlert addAction:confimAction];
    
    [kRootViewController presentViewController:quitAlert animated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    NSLog(@"个人中心收到内存警告");
    
}


@end
