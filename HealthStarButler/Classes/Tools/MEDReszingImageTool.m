//
//  MEDReszingImageTool.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/28.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDReszingImageTool.h"

@implementation MEDReszingImageTool

+ (UIImage *)resizingImageWithName:(NSString *)name
{
    // 1.创建图片
    UIImage *image = [UIImage imageNamed:name];
    // 2.找到中间可以拉伸的区域
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    // 3.创建可以拉伸的图片
    UIImage *resizingImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH * 0.5, imageW * 0.5, imageH * 0.5 - 1, imageW * 0.5 - 1) resizingMode:UIImageResizingModeStretch];
    return resizingImage;
}

@end
