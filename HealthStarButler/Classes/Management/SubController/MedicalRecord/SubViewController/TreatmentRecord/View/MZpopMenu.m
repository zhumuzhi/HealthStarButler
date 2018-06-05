//
//  MZpopMenu.m
//  Microblog
//
//  Created by 朱慕之 on 2016/10/8.
//  Copyright © 2016年 mmednet. All rights reserved.
//

#import "MZpopMenu.h"

@interface MZpopMenu ()

@property (nonatomic, weak) UIImageView *bgImageView;

@property (nonatomic, assign) UIView *positionView;

@end

@implementation MZpopMenu

- (instancetype)initWithCustomView:(UIView *)customView
{
    self = [super init];
    if (self) {
        //最后添加蒙版时，将设置popMenu尺寸的代码移到此处，因为考虑到设置View的尺寸应该在其初始化时设置
        self.size = [UIScreen mainScreen].bounds.size;
        [self addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
        //初始化小灰框
//        UIImageView *imageView = [[UIImageView alloc] init];
//        UIImage *image = [UIImage imageNamed:@"popover_background"];
//        imageView.image = image;
//        imageView.size = CGSizeMake(customView.width + 10, customView.height + 20);
//        //设置可以接收用户的点击事件
//        imageView.userInteractionEnabled = YES;
//        customView.x = 5;
//        customView.y = 12;
//        [imageView addSubview:customView];
//        self.bgImageView = imageView;
        
        self.positionView = customView;
        [self addSubview:customView];
        
    }
    return self;
}

//隐藏(移除)popMenu方法
- (void)hide:(UIButton *)btn {
    
    [self removeFromSuperview];
    
    //通过block把需要更改的titleBtn使用的图片传递过去
    if (self.imageBlock) {
        self.imageBlock(@"navigationbar_arrow_down");
    }
    
}
//显示方法
- (void)showWithView:(UIView *)targetView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 把坐标转换到屏幕坐标
    CGRect rect = [targetView convertRect:targetView.bounds toView:window];
    self.positionView.centerX = CGRectGetMidX(rect);
    self.positionView.y = CGRectGetMaxY(rect);
    
    [window addSubview:self];
}

@end


