//
//  FSPayTextField.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/9.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//
#import "FSPayTextField.h"

@implementation FSPayTextField

/** 禁止粘贴，选中，全选功能 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(paste:)) {//禁止粘贴
        return NO;
    }
    if (action == @selector(select:)) {//禁止选中
        return NO;
    }
    if (action == @selector(selectAll:)) {//禁止全选
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}


@end
