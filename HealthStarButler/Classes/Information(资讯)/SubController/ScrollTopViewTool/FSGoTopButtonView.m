//
//  FSGoTopButtonView.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/21.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSGoTopButtonView.h"

@interface FSGoTopButtonView ()

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
        [self.targetScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];

    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        NSValue *newvalue = change[NSKeyValueChangeNewKey];
        CGFloat newoffset_y = newvalue.UIOffsetValue.vertical;
        if (newoffset_y > kScreenHeight) {
            self.hidden = NO; //NSLog(@"显示");
        }else {
            self.hidden = YES; //NSLog(@"隐藏");
        }
    }
}

- (void)dealloc {
    [self.targetScrollView removeObserver:self forKeyPath:@"contentOffset"];
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


@end
