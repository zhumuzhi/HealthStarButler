//
//  FSButton.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/4.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageStyle){
    imageTop,       // 图片上 标题下
    imageLeft,      // 图片左 标题右
    imageBottom,    // 图片下 标题上
    imageRight      // 图片右 标题左
};

@interface FSButton : UIButton

@property (nonatomic, assign, readwrite) ImageStyle buttonStyle;

@end
