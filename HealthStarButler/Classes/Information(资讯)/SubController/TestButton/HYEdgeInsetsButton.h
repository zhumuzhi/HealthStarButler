//
//  HYEdgeInsetsButton.h
//  
//
//  Created by 韩保玉 on 15/6/28.
//  Copyright (c) 2015年 韩保玉. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, HYButtonEdgeInsetsStyle) {
    HYButtonEdgeInsetsStyleImageLeft,
    HYButtonEdgeInsetsStyleImageRight,
    HYButtonEdgeInsetsStyleImageTop,
    HYButtonEdgeInsetsStyleImageBottom
};

IB_DESIGNABLE
@interface HYEdgeInsetsButton : UIButton

#if TARGET_INTERFACE_BUILDER
@property (nonatomic) IBInspectable NSUInteger edgeInsetsStyle;
#else
@property (nonatomic) HYButtonEdgeInsetsStyle edgeInsetsStyle;
#endif

/* 图片与标题的间距*/
@property (nonatomic) IBInspectable CGFloat imageTitleSpace;


@property (nonatomic, assign) BOOL scaleClose;

@end
