//
//  FSGoTopTool.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/21.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSGoTopTool.h"

@interface FSGoTopTool ()

@property (nonatomic, strong) UIButton *goTopButton;
@property (nonatomic, strong) UIScrollView *targetScrollView;


@end

@implementation FSGoTopTool

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame addTarget:(nullable id)target action:(SEL)action targetScroll:(UIScrollView *)scrollView {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        [self configuration];
        [self.goTopButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        self.targetScrollView = scrollView;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame targetScroll:(UIScrollView *)targetScrollView {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        [self configuration];
        self.targetScrollView = targetScrollView;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame  {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        [self configuration];
    }
    return self;
}

#pragma mark - ConfigUI
- (void)configUI {
    [self addSubview:self.goTopButton];
    self.goTopButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

#pragma mark - Configuration
- (void)configuration {
//    scrollTopButton.frame = CGRectMake(kScreenWidth-160, kScreenHeight-kTabBarHeight-200, ButtonWH, ButtonWH);
//    [self.contentView addSubview:scrollTopButton];
//    [scrollTopButton addTarget:self action:@selector(scrollToTopBtnEvent) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - LazySet
- (UIButton *)goTopButton {
    if (_goTopButton == nil) {
        _goTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goTopButton setImage:[UIImage imageNamed:@"common_topping_normal"] forState:UIControlStateNormal];
        [_goTopButton setImage:[UIImage imageNamed:@"common_topping_selected"] forState:UIControlStateHighlighted];
        [_goTopButton addTarget:self action:@selector(clickGoTopButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goTopButton;
}

- (void)clickGoTopButton {
    NSLog(@"点击了返回顶部按钮");
    [self.targetScrollView setContentOffset:CGPointMake(0, 0) animated :YES];
}


#pragma mark - SetData

#pragma mark - Event

@end
