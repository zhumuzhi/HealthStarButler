//
//  MEDTabBarMidButton.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2018/4/10.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import "MEDTabBarMidButton.h"
#import "MEDNavigationController.h"

#import "MEDHomePageController.h"

@interface MEDTabBarMidButton ()
{
    CGFloat _buttonImageHeight;
}
@end

@implementation MEDTabBarMidButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小,间距大小
    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 0.9;
    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth * 1.0;
    
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight) * 0.5;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdgeHeight  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

#pragma mark - CYLPlusButtonSubclassing Methods
/* Create a custom UIButton with title and add it to the center of our tab bar */
+ (id)plusButton {
    MEDTabBarMidButton *button = [[MEDTabBarMidButton alloc] init];
//    UIImage *buttonImage = [UIImage imageNamed:@"post_normal"];
//    [button setImage:buttonImage forState:UIControlStateNormal];
    
    UIImage *buttonImage = [UIImage imageNamed:@"tab_home"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"tab_home_selected"] forState:UIControlStateSelected];
    
    [button setTitle:@"首页" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitle:@"首页" forState:UIControlStateSelected];
    [button setTitleColor:MEDCommonBlue forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    button.imageView.frame = CGRectMake(0.0, 0.0, 120, 120);
    button.titleLabel.frame = CGRectMake(0, button.bottom-20, button.width, 10);
//    button.backgroundColor = [UIColor redColor]; //设置按钮背景
//[button sizeToFit]; //设置按钮frame
    button.frame = CGRectMake(0.0, 0.0, 60, 60);

    
// if you use `+plusChildViewController` , do not addTarget to plusButton.
//    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    
    /** 设置按钮默认选中 */
    [button setSelected:YES];
    return button;
}

//- (void)clickPublish {

//}

#pragma mark - CYLPlusButtonSubclassing

+ (UIViewController *)plusChildViewController {
    
    MEDHomePageController *homeController = [[MEDHomePageController alloc] init];
    UIViewController *thirdNavigationController = [[MEDNavigationController alloc] initWithRootViewController:homeController];
    
    return thirdNavigationController;
}

+ (NSUInteger)indexOfPlusButtonInTabBar {
    return 2;
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return  -10;
}

//+ (BOOL)shouldSelectPlusChildViewController {
//    BOOL isSelected = CYLExternPlusButton.selected;
//    if (isSelected) {
//        NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is selected");
//    } else {
//        NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is not selected");
//    }
//    return YES;
//}

//+ (NSString *)tabBarContext {
//    return NSStringFromClass([self class]);
//}

@end
