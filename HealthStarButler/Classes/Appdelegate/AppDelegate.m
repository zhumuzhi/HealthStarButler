//
//  AppDelegate.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "AppDelegate.h"

#import "MEDTabBarControllerConfig.h"
#import "MEDTabBarMidButton.h"
#import "MEDUserLoginController.h"
#import "MEDNavigationController.h"


@interface AppDelegate () <UITabBarControllerDelegate, CYLTabBarControllerDelegate>
{
    CYLTabBarController * _tabBarController;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    //设置中间按钮
    [MEDTabBarMidButton registerPlusButton];
    // 开启后默认选中首页 搜索 『设置按钮默认选中』 设置
    [MEDTabBarMidButton.plusButton setSelected:NO];

    MEDTabBarControllerConfig *tabBarControllerConfig = [[MEDTabBarControllerConfig alloc] init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    _tabBarController = tabBarController;
    
    [self mainTabBarSwitch];
    [self.window makeKeyAndVisible];

    return YES;

}

/** 根据登录情况切换主页 */
- (void)mainTabBarSwitch {

    self.window.rootViewController = _tabBarController;
    _tabBarController.delegate = self;
    // 设置TabBar
    [MEDTabBarControllerConfig customizeInterfaceWithTabBarController:_tabBarController];
    [_tabBarController setSelectedIndex:4]; // 方便使用

/** 根据登录情况切换主页 */
//    NSString *loginStr = [kUserDefaults objectForKey:Login];
//    if (kStringIsEmpty(loginStr)||([loginStr isEqualToString:LoginFailed])){
//        MEDUserLoginController *loginController = [[MEDUserLoginController alloc]init];
//        MEDNavigationController *loginNavC = [[MEDNavigationController alloc]initWithRootViewController:loginController];
//        self.window.rootViewController = loginNavC;
//    } else {
//        self.window.rootViewController = _tabBarController;
//        _tabBarController.delegate = self;
//        // 设置TabBar
//        [MEDTabBarControllerConfig customizeInterfaceWithTabBarController:_tabBarController];
//        [_tabBarController setSelectedIndex:1]; // 方便使用
//    }
/** 根据登录情况切换主页 */

}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}

#pragma mark - CYLTabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    
    UIView *animationView;
    
    if ([control cyl_isTabButton]) {
        //更改红标状态
        animationView = [control cyl_tabImageView];
    }
    
    // 即使 PlusButton 也添加了点击事件，点击 PlusButton 后也会触发该代理方法。
    if ([control cyl_isPlusButton]) {
        UIButton *button = CYLExternPlusButton;
        animationView = button.imageView;
    }
    
    if (!([self cyl_tabBarController].selectedIndex == 2)) {
        //缩放动画
        //旋转动画
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
