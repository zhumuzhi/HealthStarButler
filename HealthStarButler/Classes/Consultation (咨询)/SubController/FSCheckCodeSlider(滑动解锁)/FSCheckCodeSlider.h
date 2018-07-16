//
//  FSCheckCodeSlider.h
//  FangShengyun
//
//  Created by 朱慕之 on 2018/7/16.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SliderWidth 240
#define SliderHeight 48
/* 标题颜色*/
#define SliderLabelTextColor [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1]
/* 边框颜色*/
#define SliderLabelBorderColor [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1].CGColor
// 最小颜色
#define SliderMinimumTrackTintColor [UIColor colorWithRed:125/255.0 green:163/255.0 blue:239/255.0 alpha:0.5]

#define SliderLabelText @"滑动解锁/获取验证码"
#define SliderLabelFont 14
#define ThumbImageWidth 48
#define ThumbImageHeight 48

@interface FSCheckCodeSlider : UISlider

@end
