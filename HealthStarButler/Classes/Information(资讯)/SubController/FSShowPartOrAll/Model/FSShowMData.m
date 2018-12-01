//
//  FSShowMData.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/11/30.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSShowMData.h"

@interface FSShowMData ()

@end

@implementation FSShowMData

- (FSShowMData *)creatAllShowMData  {
    NSArray *titles = @[@"展示标题1", @"展示标题2", @"展示标题3", @"展示标题4", @"展示标题5", @"展示标题6"];
    FSShowMData *showMData = [[FSShowMData alloc] init];
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger i = 0; i<titles.count; i++) {
        FSShowMData *item = [[FSShowMData alloc] init];
        item.title  = [titles by_ObjectAtIndex:i];
        [items addObject:item];
    }
    showMData.items = items;
    return showMData;
}

- (FSShowMData *)creatPartShowMData  {
    NSArray *titles = @[@"展示标题1", @"展示标题2", @"展示标题3", @"展示标题4", @"展示标题5", @"展示标题6"];
    FSShowMData *showMData = [[FSShowMData alloc] init];
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger i = 0; i<3; i++) {
        FSShowMData *item = [[FSShowMData alloc] init];
        item.title  = [titles by_ObjectAtIndex:i];
        [items addObject:item];
    }
    showMData.items = items;
    return showMData;
}


@end
