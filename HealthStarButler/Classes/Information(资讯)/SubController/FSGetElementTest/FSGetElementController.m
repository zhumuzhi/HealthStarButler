//
//  FSGetElementController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/9/19.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSGetElementController.h"
#import "WebViewJavascriptBridge.h"

@interface FSGetElementController()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic) WebViewJavascriptBridge *bridge;

@end


@implementation FSGetElementController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadRequest];
    [self configuration];
    [self configUI];
    
    
//    NSString *fitHeight = [self.webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];

    //document.getElementsByClassName(msgHeader).height
    //document.getElementsByName(Name) //获得指定Name值的对象
    
//    NSString *jsStr = [NSString stringWithFormat:@"document.getElementsByClassName(msgHeader).height"];
    NSString *jsStr = [NSString stringWithFormat:@"document.getElementsByName(msgHeader).height"];
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"我调用完了-result:%@", result);
    }];
}

#pragma mark - LoadRequest
- (void)loadRequest {
    NSString *urlStr = @"https://kefu.huayunworld.com/H5/index.html#/chat?skillGroupId=43&enterpriseId=9";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.0];
    [self.webView loadRequest:request];
}

#pragma mark - Configuration
- (void)configuration {
    self.navigationItem.title = @"客户服务";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - ConfigUI
- (void)configUI {
    [self.view addSubview:self.webView];
    self.webView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}

#pragma mark - LazyGet
- (WebViewJavascriptBridge *)bridge {
    if (_bridge == nil) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
        [_bridge setWebViewDelegate:self];
    }
    return _bridge;
}

- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc]init];
        _webView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
    // 禁用选中效果
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];
    
    NSString *jsStr = [NSString stringWithFormat:@"document.getElementsByName(msgHeader).height"];
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"我调用完了-result:%@", result);
    }];

    
    //获取内容实际高度（像素）@"document.getElementById(\"content\").offsetHeight;"
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result,NSError * _Nullable error) {
        // 此处js字符串采用scrollHeight而不是offsetHeight是因为后者并获取不到高度，看参考资料说是对于加载html字符串的情况下使用后者可以(@"document.getElementById(\"content\").offsetHeight;")，但如果是和我一样直接加载原站内容使用前者更合适
        //获取页面高度，并重置webview的frame
        double webViewHeight = [result doubleValue];
        webView.height = webViewHeight;
//        _mainScrollView.contentSize = CGSizeMake(Screen_Width, webView.top + webViewHeight + 10);
        NSLog(@"%f",webViewHeight);
    }];

    
    //获取内容实际高度（像素）@"document.getElementById(\"content\").offsetHeight;"
    [webView evaluateJavaScript:@"document.msgHeader.height" completionHandler:^(id _Nullable result,NSError * _Nullable error) {
        // 此处js字符串采用scrollHeight而不是offsetHeight是因为后者并获取不到高度，看参考资料说是对于加载html字符串的情况下使用后者可以(@"document.getElementById(\"content\").offsetHeight;")，但如果是和我一样直接加载原站内容使用前者更合适
        //获取页面高度，并重置webview的frame
        double webViewHeight = [result doubleValue];
        webView.height = webViewHeight;
        //        _mainScrollView.contentSize = CGSizeMake(Screen_Width, webView.top + webViewHeight + 10);
        NSLog(@"msgHeader-%f",webViewHeight);
    }];
}

- (void)dealloc {
    self.bridge = nil;
}

@end
