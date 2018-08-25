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

    [_bridge registerHandler:@"comment" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"传递参数: %@", data);
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
    // -------- 本地 --------
//    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
//    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
//    [webView loadHTMLString:appHtml baseURL:baseURL];
    // -------- 本地 --------

    // -------- 网络 --------
    //http://192.168.65.123:8000
//    NSURL *baseURL = [NSURL URLWithString:@"http://192.168.65.123:8000"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
//    [webView loadRequest:request];

//    NSString *login_account = @"xian0002";
//    NSString *member_id = @"10301";
//    NSString *token = @"eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJqd3QiLCJpYXQiOjE1MzQzODU5MDMsInN1YiI6IntcImxvZ2luQWNjb3VudFwiOlwieGlhbjAwMDJcIixcImxvZ2luRmxhZ1wiOnRydWUsXCJtZW1iZXJJZFwiOlwiMTAzMDFcIn0iLCJleHAiOjE1MzQzODk1MDN9.pBq0ozzxs-lIqwlzJmcF5i2h1JG3LX_2p9BqZrAcm34";
//    NSString *tab_order_status = @"";
//    NSString *mark = @"true";

//    NSString *urlStr = [NSString stringWithFormat:@"http://192.168.65.123:8000?login_account=%@&member_id=%@&token=%@&tab_order_status=%@&mark=%@",login_account, member_id, token, tab_order_status, mark];

    NSDictionary *dictData = @{
                               @"token":@"eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJqd3QiLCJpYXQiOjE1MzQzMDMxNTcsInN1YiI6IntcImxvZ2luQWNjb3VudFwiOlwieGlhbjAwMDJcIixcImxvZ2luRmxhZ1wiOnRydWUsXCJtZW1iZXJJZFwiOlwiMTAzMDFcIn0iLCJleHAiOjE1MzQzMDY3NTd9.bp3A-gnk0-w7nQmJXSYEWkxDUAv0b-ITUadhGNvXnOI",
                               @"customerId":@"CN00000388",
                            @"warehouseId":@1,
                               @"memberId":@10301,
                               @"timeSort":@1,
                               @"catSort":@0,
                               @"platformType":@1,
                               @"cityId":@1,
                               @"currentPage":@1
                               };

//    NSString *dataStr = [self jsonStringWithDict:dictData];
//    NSString *urlStr = [NSString stringWithFormat:@"http://192.168.65.123:8000?data=%@]", dataStr];

//    http://192.168.65.54:3000/order-detail/orderdel-index.html
//    http://192.168.65.123:8000/upMember.html  升级会员介绍
    NSString *urlStr = [NSString stringWithFormat:@"http://192.168.65.54:3000/order-detail/orderdel-index.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
        // -------- 网络 --------
}

- (NSString *)jsonStringWithDict:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

//===== 参数 =====
/*
 全部 ""
 待审批 9
 待付款 10
 待发货 50
 待收货 60
 已收货待结算 70
 订单成功 80
 取消 100
 订单关闭 110
 */
//===== 参数 =====


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
