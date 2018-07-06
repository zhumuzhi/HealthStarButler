//
//  GHTextField.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/6.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHTextField : UITextField
/**
 初始化GHTextField
 @param imageName leftImageName
 @param placeholder 占位字符
 @param placeholderColor 占位符颜色
 @param placeholderFont 占位符字体大小
 @return GHTextField
 */
- (instancetype)initTextFieldWithLeftImageName: (NSString *)imageName
                                  placeholder : (NSString *)placeholder
                              placeholderColor: (UIColor *)placeholderColor
                               placeholderFont: (UIFont *)placeholderFont;
@end
