//
//  FSShowMData.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/11/30.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSBaseMData.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSShowMData : FSBaseMData

@property (nonatomic , assign) BOOL isExpand;

- (FSShowMData *)creatPartShowMData;
- (FSShowMData *)creatAllShowMData;
@end

NS_ASSUME_NONNULL_END
