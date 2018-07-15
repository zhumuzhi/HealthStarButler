//
//  FSDebugButton.m
//  FangShengyun
//
//  Created by mac on 2018/7/13.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSDebugButton.h"
@interface FSDebugButton()
@property (nonatomic , copy) DebugCallBack callBack;
@end
@implementation FSDebugButton
+ (instancetype)sharedManager {
    static FSDebugButton *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)creatDebugButtonCallBack: (DebugCallBack)callBack addView: (UIView *)view {
    FSDebugButton *debugButton = [[FSDebugButton alloc]init];
    debugButton.frame = CGRectMake(100, kScreenHeight - 50 -kTabBarHeight - 50, 50, 50);
    debugButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"test_2"]];
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTap:)];
    [debugButton addGestureRecognizer:tap];
    self.callBack = callBack;
    [view addSubview:debugButton];
}
- (void)respondToTap:(UITapGestureRecognizer *)ges {
    if (self.callBack) {
        self.callBack();
    }
}

- (void)clickButton: (FSDebugButton *)button {
    
    if (self.callBack) {
        self.callBack();
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    /// 如果这个时候移动到了最右面
    if (self.x + self.width > kScreenWidth) {
        [UIView animateWithDuration:0.12 animations:^{
            self.x = kScreenWidth - self.width;
        }];
    }
    if (self.x < 0) {
        [UIView animateWithDuration:0.12 animations:^{
            self.x = 0;
        }];
    }
    if (self.y < kSafeAreaTopHeight) {
        [UIView animateWithDuration:0.123 animations:^{
            self.y = kSafeAreaTopHeight;
        }];
    }
    if (self.y + self.height >  kScreenHeight - kTabBarHeight) {
        [UIView animateWithDuration:0.123 animations:^{
            self.y = kScreenHeight - self.height -kTabBarHeight;
        }];
    }
        
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint current = [touch locationInView:self];
    CGPoint previous = [touch previousLocationInView:self];
    CGPoint center = self.center;
    CGPoint offset = CGPointMake(current.x - previous.x, current.y - previous.y);
    self.center = CGPointMake(center.x + offset.x, center.y + offset.y);
    
}
@end
