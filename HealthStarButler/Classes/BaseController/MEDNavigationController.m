//
//  MEDNavigationController.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/8/8.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDNavigationController.h"

@interface MEDNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation MEDNavigationController

//+ (void)initialize
//{
//    UINavigationBar *bar = [UINavigationBar appearance];
//
//    //修改标题字体颜色及大小
//    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:25 / 255.0 green:153 / 255.0 blue:24 / 255.0 alpha:1.0]}];
//    //[bar setBackgroundImage:[UIImage imageNamed:@"home_nav"] forBarMetrics:0];
//    //[bar setBarTintColor:[UIColor orangeColor]];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航控制器为手势识别器的代理(解决自定义返回按钮后滑动手势失效的问题)
    self.interactivePopGestureRecognizer.delegate = self;
    //[self.navigationBar setBackgroundImage:[UIImage imageNamed:@"imageName"] forBarMetrics:UIBarMetricsDefault];
    
    //背景颜色
    [self.navigationBar setBarTintColor:MEDRGB(28,196,225)];
    //self.navigationBar.backgroundColor = MEDRGB(28,196,225);
    
    //字体颜色
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
//    [self.navigationBar setShadowImage:[[UIImage alloc] init]];//清空导航条的阴影线
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];//清空导航条的阴影线
    
}


/**
 *  重写push方法拦截所有push进来的子控制器
 *  @param viewController 刚刚push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    NSUInteger count = self.childViewControllers.count;
    
    //NSLog(@"子控制个数为:%zd", count);
    
    if (count > 0) { // 如果viewController不是最早push进来的子控制器
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        backButton.frame = CGRectMake(0, 0, 25, 25);
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // Nav左Item
        UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        //设置空隙Item
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItem.width = -15;
        viewController.navigationItem.leftBarButtonItems = @[spaceItem, leftBarBtn]; //同时加入
        
        // 隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
//    else if (count == 0){
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        //        backButton.frame = CGRectMake(0, 0, 25, 25);
//        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [backButton setImage:[UIImage imageNamed:@"nav_mine"] forState:UIControlStateNormal];
//        [backButton setImage:[UIImage imageNamed:@"nav_mine"] forState:UIControlStateHighlighted];
//        [backButton addTarget:self action:@selector(clickMineButton) forControlEvents:UIControlEventTouchUpInside];
//
//        // Nav左Item
//        UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//
//        //设置空隙Item
//        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        spaceItem.width = -15;
//        viewController.navigationItem.leftBarButtonItems = @[spaceItem, leftBarBtn]; //同时
//    }
    
    // 所有设置搞定后, 再push控制器 (这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem)
    [super pushViewController:viewController animated:animated];
    
    //解决iPhone X push页面时 tabBar上移的问题
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (void)clickMineButton {
    NSLog(@"点击按钮跳转至个人中心");
    
    MEDMineController *mimeController = [[MEDMineController alloc] init];
    [self.navigationController pushViewController:mimeController animated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}



#pragma mark - <UIGestureRecognizerDelegate>
/**
 *  手势识别器对象会调用这个代理方法来决定手势是否有效
 *  @return YES : 手势有效, NO : 手势无效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
}


@end
