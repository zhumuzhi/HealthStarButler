//
//  MEDInformationController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDInformationController.h"

@interface MEDInformationController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation MEDInformationController

#pragma mark - Lazy
//- (UIScrollView *)scrollView {
//    if(!_scrollView){
//        _scrollView = [[UIScrollView alloc] init];
//    }
//    return _scrollView;
//}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigation];
    [self configScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ConfigUI

- (void)setupNavigation {
    self.navigationItem.title = @"资讯";
    [self setupPersonNavigationItem];
}

- (UIButton *)creatButtonWithTitle:(NSString *)title action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [self.view addSubview:button];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = MEDBlue;
    return button;
}

- (void)configScrollView {
    
    // 1.创建ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, (SCREEN_HEIGHT-Navigation_Height)/4, SCREEN_WIDTH/2, (SCREEN_HEIGHT-Navigation_Height)/2)];
    self.scrollView = scrollView;
    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.scrollView];
    
    // scrollV.clipsToBounds = YES; // scrollView默人设置了裁剪属性为YES
    //设置内容图片
    UIImage *image = [UIImage imageNamed:@"onePiece1612"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.scrollView addSubview:imageView];
    
    // 2.设置scrllView的内容尺寸，决定了滚动范围
    // 可滚动的尺寸：contentSize的尺寸，减去scrollView的尺寸
    // 注意点：如果scontentSize的尺寸小于或者等于scrollView的尺寸则不能滚动
    self.scrollView.contentSize = imageView.size;
//    self.scrollView.bounces = YES;
    self.scrollView.delegate = self;
    
    // 3.操作按钮
    
    CGFloat btnH = 22;
    
    //左上
    UIButton *topLeftBtn = [self creatButtonWithTitle:@"左上" action:@selector(topLeftClick)];
    [topLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(scrollView.mas_top);
        make.right.equalTo(scrollView.mas_left);
        make.height.mas_equalTo(btnH);
    }];
    // 上
    UIButton *topBtn = [self creatButtonWithTitle:@"上" action:@selector(topClick)];
    [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(scrollView.mas_top);
        make.centerX.equalTo(scrollView.mas_centerX);
        make.height.mas_equalTo(btnH);
    }];
    
    // 右上
    UIButton *topRigthBtn = [self creatButtonWithTitle:@"右上" action:@selector(topRightClick)];
    [topRigthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(scrollView.mas_top);
        make.left.equalTo(scrollView.mas_right);
        make.height.mas_equalTo(btnH);
    }];
    
    // 左
    UIButton *leftBtn = [self creatButtonWithTitle:@"左" action:@selector(leftClick)];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(scrollView.mas_centerY);
        make.right.equalTo(scrollView.mas_left);
        make.height.mas_equalTo(btnH);
    }];
    
    // 右
    UIButton *rigthBtn = [self creatButtonWithTitle:@"右" action:@selector(rightClick)];
    [rigthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(scrollView.mas_centerY);
        make.left.equalTo(scrollView.mas_right);
        make.height.mas_equalTo(btnH);
    }];
    
    // 下
    UIButton *bottomBtn = [self creatButtonWithTitle:@"下" action:@selector(bottomClick)];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView.mas_bottom);
        make.centerX.equalTo(scrollView.mas_centerX);
        make.height.mas_equalTo(btnH);
    }];
    
    // 左下
    UIButton *bottomLeftBtn = [self creatButtonWithTitle:@"左下" action:@selector(bottomLeftClick)];
    [bottomLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(scrollView.mas_left);
        make.top.equalTo(scrollView.mas_bottom);
        make.height.mas_equalTo(btnH);
    }];
    
    // 右下
    UIButton *bottomRightBtn = [self creatButtonWithTitle:@"右下" action:@selector(bottomRightClick)];
    [bottomRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView.mas_right);
        make.top.equalTo(scrollView.mas_bottom);
        make.height.mas_equalTo(btnH);
    }];
    
}

#pragma mark - Event

CGFloat stepW = 100.0;

- (void)topClick {
    CGFloat offsetX = self.scrollView.contentOffset.x;
    CGFloat offsetY = self.scrollView.contentOffset.y - stepW;
    if (offsetY<0) {
        offsetY = 0;
    }
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.scrollView setContentOffset:offset animated:YES];
}


- (void)leftClick {
    CGFloat offsetX = self.scrollView.contentOffset.x - stepW;
    CGFloat offsetY = self.scrollView.contentOffset.y;
    if (offsetY<0) {
        offsetY = 0;
    }
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)rightClick {
    CGFloat offsetX = self.scrollView.contentOffset.x + stepW;
    CGFloat offsetY = self.scrollView.contentOffset.y;
    CGFloat rightLimit = self.scrollView.contentSize.width - self.scrollView.width;
    if (offsetX>rightLimit) {
        offsetX = rightLimit;
    }
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)bottomClick {
    CGFloat offsetX = self.scrollView.contentOffset.x;
    CGFloat offsetY = self.scrollView.contentOffset.y + stepW;
    CGFloat bottomLimit = self.scrollView.contentSize.height - self.scrollView.height;
    if (offsetY>bottomLimit) {
        offsetY = bottomLimit;
    }
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)topLeftClick {
    CGFloat offsetX = self.scrollView.contentOffset.x - stepW;
    CGFloat offsetY = self.scrollView.contentOffset.y - stepW;
    
    CGFloat topLeftLimit = 0;
    if (offsetX<topLeftLimit) {
        offsetX=topLeftLimit;
    }
    if (offsetY<topLeftLimit) {
        offsetY = topLeftLimit;
    }
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)topRightClick {
    CGFloat offsetX = self.scrollView.contentOffset.x + stepW;
    CGFloat offsetY = self.scrollView.contentOffset.y - stepW;
    
    CGFloat topLimit = 0;
    CGFloat rightLimit =  self.scrollView.contentSize.width - self.scrollView.width;
    if (offsetX>rightLimit) {
        offsetX=rightLimit;
    }
    if (offsetY<topLimit) {
        offsetY = topLimit;
    }
    
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)bottomLeftClick {
    CGFloat offsetX = self.scrollView.contentOffset.x - stepW;
    CGFloat offsetY = self.scrollView.contentOffset.y + stepW;
    CGFloat leftLimit = 0;
    CGFloat bottomLimit =  self.scrollView.contentSize.height - self.scrollView.height;
    
    if (offsetX<leftLimit) {
        offsetX=leftLimit;
    }
    if (offsetY>bottomLimit) {
        offsetY = bottomLimit;
    }
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)bottomRightClick {
    CGFloat offsetX = self.scrollView.contentOffset.x + stepW;
    CGFloat offsetY = self.scrollView.contentOffset.y + stepW;
    CGFloat rightLimit = self.scrollView.contentSize.width - self.scrollView.width;
    CGFloat bottomLimit =  self.scrollView.contentSize.height - self.scrollView.height;
    
    if (offsetX>rightLimit) {
        offsetX=rightLimit;
    }
    if (offsetY>bottomLimit) {
        offsetY = bottomLimit;
    }
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"contentSize:%@", NSStringFromCGSize(scrollView.contentSize));
    NSLog(@"contentOffset:%@", NSStringFromCGPoint(scrollView.contentOffset));
}

@end
