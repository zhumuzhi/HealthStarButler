//
//  UIScrollView+ScrollToTopBtn.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/3.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ScrollToTopBtn)

/**
 *  customization for scrollToTop button, you can custom its image、title、backgroundImage or other properties as usually
 */
@property (nonatomic, strong, nullable) UIButton *scrollToTopBtn;

/**
 *  frame for scrollToTop button, include the origin position and size. default size: 44.f(side length) and its margin 12.f
 */
@property (nonatomic, assign) CGRect scrollToTopBtnFrame;

/**
 *  offset for show/hidden the scrollToTop button, default value:[UIScreen mainScreen].bounds.size.height
 */
@property (nonatomic, assign) CGFloat scrollToTopBtnShowOffset;

@end

