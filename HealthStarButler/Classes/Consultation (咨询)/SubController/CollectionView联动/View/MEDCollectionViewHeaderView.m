//
//  MEDCollectionViewHeaderView.m
//  HealthButlerDoctor
//
//  Created by 朱慕之 on 2018/3/21.
//  Copyright © 2018年 Meridian. All rights reserved.
//

#import "MEDCollectionViewHeaderView.h"

@implementation MEDCollectionViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = MEDRGBA(240, 240, 240, 0.8);
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth-80, 20)];
        self.title.font = [UIFont systemFontOfSize:14];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.title];
    }
    return self;
}

@end
