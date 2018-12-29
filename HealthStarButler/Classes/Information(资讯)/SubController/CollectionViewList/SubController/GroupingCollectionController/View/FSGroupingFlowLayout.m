//
//  FSGroupingFlowLayout.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/28.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSGroupingFlowLayout.h"

@implementation FSGroupingFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        
        CGSize size = [[UIScreen mainScreen] bounds].size;
        CGFloat cellSpace = 3.0;
        CGFloat cellWith = (kScreenWidth - 20) / 3.0;
        
        // 每个Cell的宽高
        self.itemSize = CGSizeMake(cellWith, cellWith * 0.8);
        // 每个Cell之间的最小间距
        self.minimumInteritemSpacing = cellSpace;
        // 组之间的各方向内边距 top, left, bottom, right
        self.sectionInset = UIEdgeInsetsMake(cellSpace, cellSpace, cellSpace, cellSpace);
        
        self.accessibilityElementsHidden = cellSpace;
        self.headerReferenceSize = CGSizeMake(size.width, 40);
    }
    return self;
}


@end
