//
//  MEDGuideLayout.m
//  健康之星管家
//
//  Created by 朱慕之 on 2017/1/15.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDGuideLayout.h"

@implementation MEDGuideLayout

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for(int i = 0; i < [attributes count]; i++) {
        
        if (i==0) {
            UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = 5;
            currentLayoutAttributes.frame = frame;
            
            continue;
        }
        
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        
        NSInteger maximumSpacing = 5;
        
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        
        if(origin + maximumSpacing  + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }else{
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = 5;
            currentLayoutAttributes.frame = frame;
        }
    }
    return attributes;
}

@end
