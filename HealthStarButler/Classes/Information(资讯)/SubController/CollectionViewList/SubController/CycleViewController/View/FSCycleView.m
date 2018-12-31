//
//  FSCycleView.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/29.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSCycleView.h"
#import "FSCycleViewCell.h"
#import "FSPageControl.h"

// 轮播间隔
static CGFloat timeInterval = 3.0f;
static CGFloat controlHeight = 35.0f;

@interface FSCycleView ()

//UI相关
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) FSPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;
//数据
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) UIImage *placeholderImage;

@end

@implementation FSCycleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _autoCycleTimeInterval = timeInterval;
        _showPageControl = YES;
        _pageControlLocation = FSCyclePageContolLocationLeft;
        _pageControlStyle = FSCyclePageContolStyleNone;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.collectionView];
    if (self.showPageControl) {
        [self addSubview:self.pageControl];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(showNext) userInfo:nil repeats:YES];
}



@end
