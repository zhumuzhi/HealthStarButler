//
//  MZSettingItem.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/11.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//  一个Item对应一个Cell
//  用来描述当前cell里面显示的内容，描述点击cell后做什么事情

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MZSettingItemType) {
    MZSettingItemTypeNone = 0,  // 什么也没有
    MZSettingItemTypeArrow,     // 箭头
    MZSettingItemTypeImage,     // 图片
    MZSettingItemTypeSwitch,    // 开关
    MZSettingItemTypeTextField  // 文本
};


@interface MZSettingItem : NSObject

/** 图片  */
@property (nonatomic, copy) UIImage *icon;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 描述 */
@property (nonatomic, copy) NSString *desc;
/** 占为文字 */
@property (nonatomic, copy) NSString *placeHolder;
/** 图片 */
@property (nonatomic, weak) UIImage *image;
/** 描述文字颜色 */
@property (nonatomic , strong) UIColor *detailLabelColor;
/** 类型 */
@property (nonatomic, assign) MZSettingItemType type;// Cell的样式
/** 点击Cell的操作 */
@property (nonatomic, copy) void (^operation)(void) ; // 点击cell后要执行的操作

/**
 *  初始化Cell
 */
+ (id)itemWithImage:(UIImage *)icon title:(NSString *)title type:(MZSettingItemType)type desc:(NSString *)desc;

/**
 *  初始化Cell（设置描述文字颜色）
 */
+ (id)itemWithImage:(UIImage *)icon title:(NSString *)title type:(MZSettingItemType)type desc:(NSString *)desc detailLabelColor:(UIColor *)detailLabelColor;

/**
 *  初始化Cell（设置描述文字颜色）
 */
+ (id)itemWithTitle:(NSString *)title type:(MZSettingItemType)type placeHolder:(NSString *)placeHolder;

/**
 *  初始化Cell
 */
+ (id)itemWithImage:(UIImage *)icon title:(NSString *)title type:(MZSettingItemType)type image:(UIImage *)image;

@end
