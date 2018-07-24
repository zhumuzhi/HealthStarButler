//
//  FSVIew.m
//  FangShengyun
//
//  Created by mac on 2018/7/1.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSView.h"

@implementation FSView
- (void)addRounderCornerWithRadius:(CGFloat)radius size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(cxt, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(cxt, [UIColor redColor].CGColor);
    
    CGContextMoveToPoint(cxt, size.width, size.height-radius);
    CGContextAddArcToPoint(cxt, size.width, size.height, size.width-radius, size.height, radius);//右下角
    CGContextAddArcToPoint(cxt, 0, size.height, 0, size.height-radius, radius);//左下角
    CGContextAddArcToPoint(cxt, 0, 0, radius, 0, radius);//左上角
    CGContextAddArcToPoint(cxt, size.width, 0, size.width, radius, radius);//右上角
    CGContextClosePath(cxt);
    CGContextDrawPath(cxt, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [imageView setImage:image];
    [self insertSubview:imageView atIndex:0];
}

@end
