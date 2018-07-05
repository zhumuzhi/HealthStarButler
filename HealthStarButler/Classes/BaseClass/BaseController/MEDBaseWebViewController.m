//
//  MEDBaseWebViewController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/27.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDBaseWebViewController.h"

@interface MEDBaseWebViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation MEDBaseWebViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置导航内容
    [self congfigNavigation];
    //设置webView
    [self congfigWebView];
    
}

#pragma mark - UI Config

- (void)congfigNavigation
{
    if (kStringIsEmpty(self.navigationTitle)) {
        self.navigationTitle = @"网络页面";
    }
    self.navigationItem.title = self.navigationTitle;
}

- (void)congfigWebView
{
    WKWebView *webView = [[WKWebView alloc] initWithFrame:SecondPageFrame];
    self.webView = webView;
    self.webView.navigationDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://developer.apple.com/reference/webkit"]]];
    [self.view addSubview:self.webView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"MEDBaseWebC收到内存警告");
}




#pragma mark - LazyLoad

#pragma mark - System Method

#pragma mark - Custom Method


/** 配置子视图、子控件 */
- (void)configSubViews {
    
}

#pragma mark - Stter and Getter 属性设置获取



#pragma mark - NetWork 网络请求
/** 请求数据 */
- (void)transData {
    
}

#pragma mark - Action 响应事件


@end
