//
//  FSPageView.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/24.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSPageView.h"

@interface FSPageView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation FSPageView

+ (instancetype) pageViewWithFrame:(CGRect)Frame {
    return [[FSPageView alloc] initWithFrame:Frame];
}

#pragma mark - SetData
- (void)setImageDatas:(NSMutableArray *)imageDatas {
    _imageDatas = imageDatas;
    
}

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
    }
    return self;
}

#pragma mark - LazyGet
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        
        
        
    }
    return _pageControl;
}

#pragma mark - configUI

#pragma mark - configration

#pragma mark - Event



@end
