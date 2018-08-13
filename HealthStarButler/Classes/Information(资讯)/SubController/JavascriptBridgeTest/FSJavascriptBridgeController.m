//
//  FSJavascriptBridgeController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/11.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSJavascriptBridgeController.h"
#import "WebViewJavascriptBridge.h"
#import "FSPassWordController.h"

@interface FSJavascriptBridgeController ()

@property WebViewJavascriptBridge* bridge;

@end

@implementation FSJavascriptBridgeController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (_bridge) { return; }

    WKWebView* webView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.view.bounds];
    // webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [_bridge setWebViewDelegate:self];

    MEDWeakSelf(self);
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"OC返回的结果");
        [weakself.navigationController popViewControllerAnimated:YES];
    }];

    [_bridge registerHandler:@"pushButton" handler:^(id data, WVJBResponseCallback responseCallback) {
        //NSLog(@"pushButton called: %@", data);
        responseCallback(@"OC返回的结果");
        FSPassWordController *pass = [[FSPassWordController alloc] init];
        [weakself.navigationController pushViewController:pass animated:YES];
    }];

    [_bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];

    [self renderButtons:webView];
    [self loadExamplePage:webView];
}

#pragma mark - WKwebViewDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidStartLoad");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidFinishLoad");
}

#pragma mark - Event

- (void)callHandler:(id)sender {
    id data = @{ @"OC调用JS": @"你好, JS!" };
    [_bridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];
}

- (void)loadExamplePage:(WKWebView*)webView {
    //本地
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];

    //网络
    //http://192.168.65.123:8000
//    NSURL *baseURL = [NSURL URLWithString:@"http://192.168.65.123:8000"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
//    [webView loadRequest:request];
}

- (void)renderButtons:(WKWebView*)webView {
    UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];

    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    callbackButton.backgroundColor = [UIColor lightGrayColor];
    [callbackButton setTitle:@"Call handler" forState:UIControlStateNormal];
    [callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:callbackButton aboveSubview:webView];
    callbackButton.frame = CGRectMake(10, kScreenHeight-100, 100, 35);
    callbackButton.titleLabel.font = font;

    UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    reloadButton.backgroundColor = [UIColor lightGrayColor];
    [reloadButton setTitle:@"Reload webview" forState:UIControlStateNormal];
    [reloadButton addTarget:webView action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:reloadButton aboveSubview:webView];
    reloadButton.frame = CGRectMake(110, kScreenHeight-100, 100, 35);
    reloadButton.titleLabel.font = font;
}

@end
