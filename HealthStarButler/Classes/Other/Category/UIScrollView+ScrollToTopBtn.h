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
 *  定制scrollToTop按钮,可以自定义样式,通常标题、分辨率或其他属性
 */
@property (nonatomic, strong, nullable) UIButton *scrollToTopBtn;

/**
 *  scrollToTop按钮的Frame,包括原点位置和大小。默认大小:44(side length)、间距12. f
 */
@property (nonatomic, assign) CGRect scrollToTopBtnFrame;

/**
 *  显示/隐藏scrollToTop按钮的offset，默认值为:[UIScreen mainScreen].bounds.size.height
 */
@property (nonatomic, assign) CGFloat scrollToTopBtnShowOffset;

@end

