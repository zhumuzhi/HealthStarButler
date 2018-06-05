//
//  MZpopMenu.h
//  Microblog
//
//  Created by 朱慕之 on 2016/10/8.
//  Copyright © 2016年 mmednet. All rights reserved.
//
//***//
//typedef void (^ValueBlock)(NSString *value);

#import <UIKit/UIKit.h>

typedef void(^ImageBlock)(NSString *imageName);

@interface MZpopMenu : UIButton
//改变首页的TitleBtn图片使用的block属性
@property (nonatomic, copy) ImageBlock imageBlock;
/**
 通过传入一个自定义View去显示一个pop菜单
 @param customView 自定义View
 */
- (instancetype)initWithCustomView:(UIView *)customView;

/**
 显示在某个控件之下
 @param targetView 某个控件
 */
- (void)showWithView:(UIView *)targetView;

/**怎么能用方法代替block属性？？？*/
//- (void)changeTitleImageUseBlock:(ImageBlock)imageBlock;
@end
