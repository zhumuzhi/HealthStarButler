//
//  FSBaseMData.h
//  FangShengyun
//
//  Created by mac on 2018/6/18.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FSBaseMData : NSObject
/** 占位字符串 */
@property (nonatomic , copy) NSString *placeholder;
/** 标题 */
@property (nonatomic , copy) NSString *title;
/** 内容 */
@property (nonatomic , copy) NSString *content;
/** 详情 */
@property (nonatomic , copy) NSString *details;
/** 记录indexPath */
@property (nonatomic , strong) NSIndexPath *indexPath;

/** cell高度 */
@property (nonatomic , assign) CGFloat cellHeight;
/** sectionHeader标题 */
@property (nonatomic , copy) NSString *sectionHeaderTitle;
/** sectionFooter标题 */
@property (nonatomic , copy) NSString *sectionFooterTitle;
/** sectionFooter高度 */
@property (nonatomic , assign) CGFloat sectionFooterHeight;
/** sectionHeader高度 */
@property (nonatomic , assign) CGFloat sectionHeaderHeight;
/** 控制器名称 */
@property (nonatomic , copy) NSString *vcName;
/** sectionHeader名称 */
@property (nonatomic , copy) NSString *sectionHeaderName;
/** sectionFooter名称 */
@property (nonatomic , copy) NSString *sectionFooterName;
/** 是否是最后一个 */
@property (nonatomic , assign) BOOL isLast;
/** 子数组 */
@property (nonatomic , strong) NSArray *items;
@property (nonatomic , assign) BOOL seleted;

@end
