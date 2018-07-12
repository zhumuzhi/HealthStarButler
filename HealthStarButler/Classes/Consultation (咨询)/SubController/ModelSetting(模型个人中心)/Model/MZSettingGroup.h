//
//  MZSettingGroup.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/11.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZSettingGroup : NSObject

@property (nonatomic, copy) NSString *header; // 头部标题
@property (nonatomic, copy) NSString *footer; // 尾部标题
@property (nonatomic, strong) NSArray *items; // 每组cell数组

@property (nonatomic, assign) CGFloat headerHeight; // 头部标题高度
@property (nonatomic, assign) CGFloat footerHeight; // 尾部标题高度

@end
