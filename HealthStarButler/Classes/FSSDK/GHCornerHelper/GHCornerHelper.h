//
//  GHCornerHelper.h
//  GHStudy
//
//  Created by 赵治玮 on 2017/11/14.
//  Copyright © 2017年 赵治玮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHCornerHelper : NSObject

/*设置一个圆角
 适用于label imageView view
 [EncapsulationClass viewBeizerRect:imageView.bounds view:imageView corner:UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
 */
+(void)viewBeizerRect:(CGRect)rect view:(UIView *)view corner:(UIRectCorner)corner cornerRadii:(CGSize)radii;

/*设置一个圆角
 适用于button
 */
+(void)ControlBeizerRect:(CGRect)rect Control:(UIControl *)Control  corner:(UIRectCorner)corner cornerRadii:(CGSize)radii;
@end
