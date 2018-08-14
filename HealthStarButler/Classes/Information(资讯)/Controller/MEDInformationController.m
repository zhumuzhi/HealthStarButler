//
//  MEDInformationController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDInformationController.h"

#import "FSCornerRadiusController.h"     // 圆角阴影
#import "FSWKWebJSController.h"          // WKWeb_JS交互
#import "FSAliPayController.h"           // 支付宝测试
#import "FSPassWordController.h"         // 支付弹窗
#import "FSJavascriptBridgeController.h" // JSBridge框架
#import "FSChoseZoneViewController.h"    // 地址选择


@interface MEDInformationController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *datasArray;


@end

@implementation MEDInformationController

#pragma mark - Lazy
- (NSMutableArray *)datasArray
{
    if (_datasArray == nil) {
        _datasArray = [NSMutableArray arrayWithArray:@[
                                                       @{@"name":@"圆角阴影", @"className":@"FSCornerRadiusController"},
                                                       @{@"name":@"WKWeb-JS", @"className":@"FSWKWebJSController"},
                                                       @{@"name":@"支付宝测试", @"className":@"FSAliPayController"},
                                                       @{@"name":@"支付弹窗", @"className":@"FSPassWordController"},
                                                       @{@"name":@"JSBridge测试", @"className":@"FSJavascriptBridgeController"},
                                                       @{@"name":@"地址选择", @"className":@"FSChoseZoneViewController"}
                                                       ]
                       ];
    }// FSChoseZoneViewController
    return _datasArray;
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigation];
    
//    [self configTestScrollView]; // 测试的ScrollView
    
    //UIScrollView+ScrollToTopBtn
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"go_top"] forState:UIControlStateNormal];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.scrollToTopBtnFrame = CGRectMake(kScreenWidth - 100, kScreenHeight - 100 - kNavigationHeight, 100, 100);
    self.tableView.scrollToTopBtnShowOffset = 0.f;
    self.tableView.scrollToTopBtn = btn;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"id%zi", indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        NSDictionary *dict = self.datasArray[indexPath.row];
        cell.textLabel.text = dict[@"name"];
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.datasArray[indexPath.row];
    Class controller = NSClassFromString(dict[@"className"]);
    UIViewController *viewController = [[controller alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
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

- (void)configTestScrollView {
    
    // 1.创建ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWidth/4, (kScreenHeight-kNavigationHeight)/4, kScreenWidth/2, (kScreenHeight-kNavigationHeight)/2)];
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
