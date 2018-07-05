//
//  MZPlusButton.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/20.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZPlusButton;

@protocol MZPlusButtonSubclassing
@required
+ (id)plusButton;
@optional
/** 自定义加号按钮在 TabBar 中的位置 */
+ (NSInteger)indexOfPlusButtonInTabBar;
/** 返回自定义按钮中心点Y轴 */
+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight;
/** 实现了该方法，但不实现+multiplierOfTabBarHeight:方法，会在预设逻辑的基础上进行偏移 */
+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight;
/** 指定 PlusButton 点击跳转的 UIViewController */
+ (UIViewController *)plusChildViewController;

+ (BOOL)shouldSelectPlusChildViewController;

+ (NSString *)tabBarContext;

@end


@interface MZPlusButton : UIButton

+ (void)registerPlusButton;

- (void)plusChildViewControllerButtonClicked:(UIButton<MZPlusButtonSubclassing>*)sender;


@end
