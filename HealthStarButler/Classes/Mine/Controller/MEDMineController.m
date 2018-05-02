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
    [MEDAlertMananger presentAlertWithTitle:@"退出" message:@"确认退出" actionTitle:@[@"确认"] preferredStyle:UIAlertControllerStyleAlert handler:^(NSUInteger buttonIndex, NSString *buttonTitle) {
        NSLog(@"@@~~ : %lu, %@", (unsigned long)buttonIndex, buttonTitle);
        
        if (buttonIndex==1) {
            [kUserDefaults setObject:LoginFailed forKey:Login];
            [kAppDelegate mainTabBarSwitch];
        }
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    NSLog(@"个人中心收到内存警告");
    
}


@end
