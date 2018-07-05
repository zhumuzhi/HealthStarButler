//
//  MEDScoreProgressBar.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/27.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDScoreProgressBar.h"

@implementation MEDScoreProgressBar
{
    float _scorePercent;
}

- (void)setPercent:(float)percent
{
    _scorePercent = percent;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    backGroundView.backgroundColor = MEDGrayColor(232);
    backGroundView.layer.cornerRadius = 5.0;
    [backGroundView clipsToBounds];
    [self addSubview:backGroundView];

    if (_scorePercent != 0) {
        UIView *percentView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, rect.size.width*_scorePercent, rect.size.height-2)];
        percentView.backgroundColor = MEDRGB(45, 196, 223);

        percentView.layer.cornerRadius = 5.0;
        [percentView  clipsToBounds];
        [self addSubview:percentView];
    
    }
}

@end
