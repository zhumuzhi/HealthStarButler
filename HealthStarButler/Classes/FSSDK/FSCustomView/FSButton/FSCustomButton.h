//
//  FSCustomButton.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/4.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 按钮图片位置枚举*/
typedef NS_ENUM(NSUInteger, FSCustomButtonImageType) {
    /* 图片在按钮左侧*/
    FSCustomButtonImageTypeLeft,
    /* 图片在右*/
    FSCustomButtonImageTypeRight,
    /* 图片在上*/
    FSCustomButtonImageTypeTop,
    /* 图片在下*/
    FSCustomButtonImageTypeDown
};


@interface FSCustomButton : UIButton

@property (nonatomic, assign, readwrite) FSCustomButtonImageType buttonStyle;

@end
