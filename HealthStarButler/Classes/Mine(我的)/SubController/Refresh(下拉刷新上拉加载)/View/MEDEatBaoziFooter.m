//
//  MEDEatBaoziFooter.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2017/12/12.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDEatBaoziFooter.h"

@implementation MEDEatBaoziFooter

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
