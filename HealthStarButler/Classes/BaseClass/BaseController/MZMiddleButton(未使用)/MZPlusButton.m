//
//  MZPlusButton.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/20.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MZPlusButton.h"
#import "CYLTabBarController.h"
#import "UIViewController+CYLTabBarControllerExtention.h"

CGFloat MZPlusButtonWidth = 0.0f;
UIButton <MZPlusButtonSubclassing> *MZExternPlusButton = nil;
UIViewController *MZPlusChildViewController = nil;

@implementation MZPlusButton

#pragma mark - public Methods

/** 注册按钮 */
+ (void)registerPlusButton {
    //检查对象是否实现了指定协议类的方法, 未实现则返回
    if (![self conformsToProtocol:@protocol(MZPlusButtonSubclassing)]) {
        return;
    }
    Class<MZPlusButtonSubclassing> class = self;
    UIButton<MZPlusButtonSubclassing> *plusButton = [class plusButton];
    MZExternPlusButton = plusButton;
    MZPlusButtonWidth = plusButton.frame.size.width;
    //判断某个类/实例中是否包含某个方法
    //是否实现了点击PlusButton方法与点击其他TabBar按钮一样的效果，跳转到指定的UIViewController
    if ([[self class] respondsToSelector:@selector(plusChildViewController)]) {
        MZPlusChildViewController = [class plusChildViewController];
        //调用代理方法，拿到tabBarContext(String) 并set，如果拿不到从类中获取
        if ([[self class] respondsToSelector:@selector(tabBarContext)]) {
            NSString *tabBarContext = [class tabBarContext];
            if (tabBarContext && tabBarContext.length) {
                [MZPlusChildViewController cyl_setContext:tabBarContext];
            }
        } else {
            [MZPlusChildViewController cyl_setContext:NSStringFromClass([CYLTabBarController class])];
        }
        //添加选中的控制器
        [[self class] addSelectViewControllerTarget:plusButton];
        
        //设置设定自定义按钮的位置，不实现默认居中，不调用报错并同时原因
        if ([[self class] respondsToSelector:@selector(indexOfPlusButtonInTabBar)]) {
            CYLPlusButtonIndex = [[self class] indexOfPlusButtonInTabBar];
        } else {
            [NSException raise:NSStringFromClass([CYLTabBarController class]) format:@"If you want to add PlusChildViewController, you must realizse `+indexOfPlusButtonInTabBar` in your custom plusButton class.【Chinese】如果你想使用PlusChildViewController样式，你必须同时在你自定义的plusButton中实现 `+indexOfPlusButtonInTabBar`，来指定plusButton的位置"];
        }
    }
}

//点击了中间按钮
- (void)plusChildViewControllerButtonClicked:(UIButton<MZPlusButtonSubclassing> *)sender
{
    //不需要设置选中状态，返回
    BOOL notNeedConfigureSelectionStatus = [[self class] respondsToSelector:@selector(shouldSelectPlusChildViewController)] && ![[self class] shouldSelectPlusChildViewController];
    if (notNeedConfigureSelectionStatus) {
        return;
    }
    //如果按钮已经被选中，返回
    if (sender.selected) {
        return;
    }
    sender.selected = YES;
    CYLTabBarController *tabBarController = [sender cyl_tabBarController];
    NSInteger index = [tabBarController.viewControllers indexOfObject:MZPlusChildViewController];
    @try {
        [tabBarController setSelectedIndex:index];
    } @catch (NSException *exception) {
        NSLog(@"类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), exception);
    }
}

/** 添加选中的控制器 */
+ (void)addSelectViewControllerTarget:(UIButton<MZPlusButtonSubclassing>*)plusButton
{
    id target = self;
    NSArray <NSString *> *selectorNamesArray = [plusButton actionsForTarget:target forControlEvent:UIControlEventTouchUpInside];
    if (selectorNamesArray.count == 0) {
        target = plusButton;
        selectorNamesArray = [plusButton actionsForTarget:target forControlEvent:UIControlEventTouchUpInside];
    }
    [selectorNamesArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SEL selecor = NSSelectorFromString(obj);
        [plusButton removeTarget:target action:selecor forControlEvents:UIControlEventTouchUpInside];
        [plusButton addTarget:plusButton action:@selector(plusChildViewControllerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void)setHighlighted:(BOOL)highlighted { }

@end
