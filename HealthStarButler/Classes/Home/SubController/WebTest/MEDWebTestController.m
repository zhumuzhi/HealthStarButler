//
//  MEDWebTestController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/20.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDWebTestController.h"

@interface MEDWebTestController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation MEDWebTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    NSURL *url = [NSURL URLWithString:@"http://m.xianhua.com.cn"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)configUI {
    self.navigationItem.title = @"网页测试";
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, Navigation_Height, SCREEN_WIDTH, SCREEN_HEIGHT-Navigation_Height)];
    self.webView = webView;
    webView.delegate = self;
    [self.view addSubview:webView];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 移除鲜花网的下部标签
    NSString *jsRemoveBtn = @"document.getElementsByClassName('detail_btns2')[0].remove()";
    
    [self.webView stringByEvaluatingJavaScriptFromString:jsRemoveBtn];
    
    NSString *jsChangeTitle = @"document.getElementById('header').getElementsByTagName('h1')[0].innerText='朱慕之的鲜花网'";
    [self.webView stringByEvaluatingJavaScriptFromString:jsChangeTitle];
}






@end
