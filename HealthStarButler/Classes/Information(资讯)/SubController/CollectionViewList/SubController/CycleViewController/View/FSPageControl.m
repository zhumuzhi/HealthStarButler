//
//  FSPageControl.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/29.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSPageControl.h"

@interface FSPageControl ()

@end

@implementation FSPageControl

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    [super setCurrentPage:currentPage];
    
    for (int i = 0; i < [self.subviews count]; i++) {
        UIView *point = [self.subviews objectAtIndex:i];
        [point setFrame:CGRectMake(point.frame.origin.x, point.frame.origin.y, self.pointSize.width, self.pointSize.height)];
        if ([point.subviews count] == 0) {
            UIImageView *view = [[UIImageView alloc]initWithFrame:point.bounds];
            [point addSubview:view];
        };
        UIImageView *view = point.subviews[0];
        if (i == self.currentPage) {
            if (self.currentImage) {
                view.image = self.currentImage;
                point.backgroundColor = [UIColor clearColor];
            }else {
                view.image = nil;
                point.backgroundColor = self.currentPageIndicatorTintColor;
            }
        }else if (self.pageImage) {
            view.image = self.pageImage;
            point.backgroundColor = [UIColor clearColor];
        }else {
            view.image = nil;
            point.backgroundColor = self.pageIndicatorTintColor;
        }
    }
}

@end
