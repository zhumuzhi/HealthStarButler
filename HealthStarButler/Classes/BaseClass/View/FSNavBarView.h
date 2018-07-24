//
//  FXMNavBarView.h
//  FXMOnLineAPP
//
//  Created by GHome on 2017/12/18.
//  Copyright © 2017年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    /** 左 */
    FSNavBarViewButtonStyleTypeLeft = 1,
    /** 右 */
    FSNavBarViewButtonStyleTypeRight,
} FSNavBarViewButtonStyleType;
@class UIButton;
@interface FSNavBarView : UIView
/** nav标题颜色 */
@property (nonatomic , strong) UIColor *titleColor;
/** nav标题字号 */
@property (nonatomic , strong) UIFont *titleFont;
/** nav标题 */
@property (nonatomic , copy) NSString *navTitle;
/** 是否显示titleView */
@property (nonatomic , assign) BOOL isShowTitleView;
/** 是否显示底部的线 */
@property (nonatomic , assign) BOOL isShowBottomLine;

@property (nonatomic , strong) FSButton *leftButton;
@property (nonatomic , strong) UIButton *rightButton;
@property (nonatomic , strong) UIView *titleView;
@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) UIView *leftView;
@property (nonatomic , strong) UIView *rightView;
@property (nonatomic , strong) UIView *line;
- (void)setupUI;
@end
