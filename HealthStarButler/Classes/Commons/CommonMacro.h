//
//  CommonMacro.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

#endif /* CommonMacro_h */

#pragma mark -------------------- Log --------------------

#ifdef DEBUG
#define NSLog(...) NSLog(@"%s(%d行)%@",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif


#ifdef DEBUG
#define NSLogFunc NSLog(@"=====Begin==========\n FILE: %@\n FUNC: %s\n LINE: %d\n", [NSString stringWithUTF8String:__FILE__].lastPathComponent, __PRETTY_FUNCTION__, __LINE__)

#else
#define NSLogFunc
#endif

#pragma mark -------------------- Frame --------------------

// 屏幕宽度
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
// 屏幕高度
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)

// iPhone X
#define  MED_iPhoneX        (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)

// 状态栏
#define StatusBarHeight     (MED_iPhoneX ? 44.f : 20.f )
// 导航栏
#define Navigation_Height   (StatusBarHeight + 44.f)
// TabBar距离底部
#define MED_TabbarSafeBottomMargin  (MED_iPhoneX ? 34.f : 0.0f)
// TabBar
#define TabBar_Height       (MED_TabbarSafeBottomMargin + 49.f)


#pragma mark -------------------- Color --------------------

#define MEDRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define MEDRGB(r, g, b)    MEDRGBA((r), (g), (b), 255)
#define MEDGrayColor(v)    MEDRGB((v), (v), (v))
#define MEDRandomColor     MEDRGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

#define MEDCommonBgColor   MEDGrayColor(206)      //待定
#define MEDCommonBlue      MEDRGB(28, 196, 225) //待定
#define MEDCommonBlack     MEDRGB(40, 40, 40)   //待定

#define MEDCommonGray      MEDGrayColor(102)      //待定 健康方案字体颜色
#define MEDCommonLightGray MEDGrayColor(170)      //待定 健康方案标题颜色


#pragma mark -------------------- Other --------------------

// weakSelf
#define MEDWeakSelf(type)  __weak typeof(type) weak##type = type;

// 是否是空对象
#define MEDIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


