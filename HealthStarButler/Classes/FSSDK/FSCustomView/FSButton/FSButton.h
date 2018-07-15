//
//  FSButton.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/4.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 按钮图片位置枚举*/
typedef NS_ENUM(NSUInteger, FSButtonImageType) {
    /* 图片在按钮左侧*/
    FSButtonImaegTypeLeft,
    /* 图片在右*/
    FSButtonImaegTypeRight,
    /* 图片在上*/
    FSButtonImaegTypeTop,
    /* 图片在下*/
    FSButtonImaegTypeDown
};


@interface FSButton : UIButton

@property (nonatomic, assign, readwrite) FSButtonImageType buttonStyle;

@end
