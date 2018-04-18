//
//  MEDTabBarControllerConfig.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2018/4/9.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import "MEDTabBarControllerConfig.h"
//NavigationController
#import "MEDNavigationController.h"
//引入各个模块
#import "MEDManagementController.h"
#import "MEDConsultationController.h"
#import "MEDTreatmentGuideController.h"
#import "MEDInformationController.h"


//static CGFloat const MEDTabBarControllerHeight = 40.f;

@interface MEDTabBarControllerConfig()<UITabBarControllerDelegate>

@property (nonatomic, strong, readwrite) CYLTabBarController *tabBarController;
@end

@implementation MEDTabBarControllerConfig

- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        
        /**
         以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。(推荐)*/
        UIEdgeInsets imageInsets = UIEdgeInsetsZero; //UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        UIOffset titlePositionAdjustment = UIOffsetZero; //UIOffsetMake(0, MAXFLOAT);
        
        CYLTabBarController *tabBarController =
        
        [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                             imageInsets:imageInsets
                                                                                 titlePositionAdjustment:titlePositionAdjustment
                                                                                                 context:self.context
                                                 ];
        
        [self customizeTabBarAppearance:tabBarController];
        [self setNavBarAppearence];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}


- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    //自定义 TabBar高度
//    tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
    // 普通/选中状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = MEDCommonBlue;
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    //设置bar shadow image
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
        [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // 设置背景图片
    UITabBar *tabBarAppearance = [UITabBar appearance];
    UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"tab_bar"];
    UIImage *scanedTabBarBackgroundImage = [[self class] scaleImage:tabBarBackgroundImage toScale:1.0];
     [tabBarAppearance setBackgroundImage:scanedTabBarBackgroundImage];
    
    // 去除 TabBar 自带的顶部阴影
    // iOS10 后 需要使用 `-[CYLTabBarController hideTabBadgeBackgroundSeparator]` 见 AppDelegate 类中的演示;
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (NSArray *)viewControllers {
    
    MEDManagementController *managementController = [[MEDManagementController alloc] init];
    UIViewController *firstNavigationController = [[MEDNavigationController alloc] initWithRootViewController:managementController];
    
    MEDConsultationController *consultationController = [[MEDConsultationController alloc] init];
    UIViewController *secondNavigationController = [[MEDNavigationController alloc] initWithRootViewController:consultationController];
    
//    MEDManagementController *magenmentController = [[MEDManagementController alloc] init];
//    UIViewController *thirdNavigationController = [[MEDNavigationController alloc] initWithRootViewController:magenmentController];
    
    MEDInformationController *informationController = [[MEDInformationController alloc] init];
    UIViewController *fourthNavigationController = [[MEDNavigationController alloc] initWithRootViewController: informationController];
    
    MEDTreatmentGuideController *guideController = [[MEDTreatmentGuideController alloc] init];
    UIViewController *fifthNavigationController = [[MEDNavigationController alloc] initWithRootViewController:guideController];
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
//                                 thirdNavigationController,
                                 fourthNavigationController,
                                 fifthNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    
    NSDictionary *firstTabBarItemsAttributes = @{

                                                 CYLTabBarItemTitle : @"管理",
                                                 CYLTabBarItemImage : @"tab_management", CYLTabBarItemSelectedImage : @"tab_management_selsected",
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                                                                    CYLTabBarItemTitle : @"咨询",
                                                  CYLTabBarItemImage : @"tab_consultation",
                                                  CYLTabBarItemSelectedImage : @"tab_consultation _selected",
                                                  };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                                                                    CYLTabBarItemTitle : @"资讯",
                                                  CYLTabBarItemImage : @"tab_information",
                                                  CYLTabBarItemSelectedImage : @"tab_information_selected"
                                                  };
    NSDictionary *fifthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"导诊",
                                                  CYLTabBarItemImage : @"tab_guide",
                                                  CYLTabBarItemSelectedImage : @"tab_guide_selected"
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes,
                                       fifthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

/** 设置图片使用方法 */
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (void)customizeInterfaceWithTabBarController:(CYLTabBarController *)tabBarController {
    
    [tabBarController hideTabBadgeBackgroundSeparator];
    //添加小红点
//        UIViewController *viewController = tabBarController.viewControllers[0];
//        UIView *tabBadgePointView0 = [UIView cyl_tabBadgePointViewWithClolor:MEDRandomColor radius:4.5];
//        [viewController.tabBarItem.cyl_tabButton cyl_setTabBadgePointView:tabBadgePointView0];
//        [viewController cyl_showTabBadgePoint];
//
//        UIView *tabBadgePointView1 = [UIView cyl_tabBadgePointViewWithClolor:MEDRandomColor radius:4.5];
//        @try {
//            [tabBarController.viewControllers[1] cyl_setTabBadgePointView:tabBadgePointView1];
//            [tabBarController.viewControllers[1] cyl_showTabBadgePoint];
//
//            UIView *tabBadgePointView2 = [UIView cyl_tabBadgePointViewWithClolor:MEDRandomColor radius:4.5];
//            [tabBarController.viewControllers[2] cyl_setTabBadgePointView:tabBadgePointView2];
//            [tabBarController.viewControllers[2] cyl_showTabBadgePoint];
//
//            [tabBarController.viewControllers[3] cyl_showTabBadgePoint];
//
//            //添加提示动画，引导用户点击
//            [self addScaleAnimationOnView:tabBarController.viewControllers[3].cyl_tabButton.cyl_tabImageView repeatCount:20];
//        } @catch (NSException *exception) {}
}

// 设置Navigation
- (void)setNavBarAppearence
{
    //    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]}];
    //    [UINavigationBar appearance].tintColor = [UIColor yellowColor];
    //    [UINavigationBar appearance].barTintColor = [UIColor redColor];
    
    UIColor *MainNavBarColor = MEDCommonBlue;
    // 设置是 广泛使用WRNavigationBar，还是局部使用WRNavigationBar，目前默认是广泛使用
    [WRNavigationBar wr_widely];
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:MainNavBarColor];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}

@end
