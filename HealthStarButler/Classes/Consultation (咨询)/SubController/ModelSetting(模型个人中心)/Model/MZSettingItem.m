//
//  MZSettingItem.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/11.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MZSettingItem.h"

@implementation MZSettingItem


/**
 *  初始化Cell 图片+标题+CellType
 *  @param icon  图片
 *  @param title 标题
 *  @param type  CellType
 */
+ (id)itemWithImage:(UIImage *)icon title:(NSString *)title type:(MZSettingItemType)type image:(UIImage *)image
{
    MZSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.type = type;
    item.image = image;
    return item;
}

/**
 *  初始化Cell 图片+标题+CellType+描述文字
 *  @param icon  图片
 *  @param title 标题
 *  @param type  CellType
 *  @param desc  描述文字
 */
+ (id)itemWithImage:(UIImage *)icon title:(NSString *)title type:(MZSettingItemType)type desc:(NSString *)desc
{
    MZSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.type = type;
    item.desc = desc;
    return item;
}

/**
 *  初始化Cell 图片+标题+CellType+描述文字+描述文字颜色
 *  @param icon             图片
 *  @param title            标题
 *  @param type             CellType
 *  @param desc             描述文字
 *  @param detailLabelColor 描述文字颜色
 */
+ (id)itemWithImage:(UIImage *)icon title:(NSString *)title type:(MZSettingItemType)type desc:(NSString *)desc detailLabelColor:(UIColor *)detailLabelColor
{
    MZSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.type = type;
    item.desc = desc;
    item.detailLabelColor = detailLabelColor;
    return item;
}

/**
 *  初始化Cell 标题+CellType+占位文字
 *  @param  title 标题
 *  @param  type  CellType
 *  @param  placeHolder 占位文字
 */
+ (id)itemWithTitle:(NSString *)title type:(MZSettingItemType)type placeHolder:(NSString *)placeHolder
{
    MZSettingItem *item = [[self alloc] init];
    item.title = title;
    item.type = type;
    item.placeHolder = placeHolder;
    return item;
}

@end
