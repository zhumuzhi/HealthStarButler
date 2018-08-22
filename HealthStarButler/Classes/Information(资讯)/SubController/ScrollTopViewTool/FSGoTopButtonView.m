//
//  FSGoTopButtonView.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/21.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSGoTopButtonView.h"

@interface FSGoTopButtonView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *goTopButton;
@property (nonatomic, strong) UIScrollView *targetScrollView;

@end

@implementation FSGoTopButtonView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame targetScroll:(UIScrollView *)targetScrollView {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        [self configuration];
        self.targetScrollView = targetScrollView;
        self.targetScrollView.delegate = self;
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
    //NSLog(@"点击了返回顶部按钮");
    [self.targetScrollView setContentOffset:CGPointMake(0, 0) animated :YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"goTop-OffSet:%f", scrollView.contentOffset.y);
    if (scrollView == self.targetScrollView) {
        if (scrollView.contentOffset.y>kScreenHeight) {
            //NSLog(@"显示");
            self.hidden = NO;
        }else {
            //NSLog(@"隐藏");
            self.hidden = YES;
        }
    }
}

@end
