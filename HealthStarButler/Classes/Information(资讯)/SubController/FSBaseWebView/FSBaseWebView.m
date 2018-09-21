//
//  FSBaseWebView.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/9/21.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSBaseWebView.h"

#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"

@interface FSBaseWebView ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic) WebViewJavascriptBridge *bridge;

@end

@implementation FSBaseWebView

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self configuration];
}

#pragma mark - configUI
- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
}

#pragma mark - Configuration & EventMethod
- (void)configuration {
    [self.bridge setWebViewDelegate:self];
    
    #pragma mark - 多处使用
    [self.bridge registerHandler:kH5Method_goBack handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"goBack-返回-data: %@", data);

    }];
    
    
    [self.bridge registerHandler:kH5Method_toLogin handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"toLogin-去登陆-data: %@", data);
        
    }];
    
    [self.bridge registerHandler:kH5Method_passWordSucess handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"passWordSucess-修改密码成功-data: %@", data);
        
    }];
    
    [self.bridge registerHandler:kH5Method_goHomePage handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"goHomePage-去首页-data: %@", data);
        
    }];
    
    [self.bridge registerHandler:kH5Method_goodsDetaile handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"goodsDetaile-商品详情-data: %@", data);
        
    }];
    
    [self.bridge registerHandler:kH5Method_buyAgain handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"buyAgain-再次购买-data: %@", data);
        
    }];
    
    [self.bridge registerHandler:kH5Method_choseZone handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"choseZone-区域选择-data: %@", data);
        
    }];
    
    [self.bridge registerHandler:kH5Method_goPay handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"goPay-去支付-data: %@", data);
        
    }];
    
    [self.bridge registerHandler:kH5Method_goPayConfirm handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"goPayConfirm-去确认-data: %@", data);
        
    }];
    
    [self.bridge registerHandler:kH5Method_useCoupon handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"useCoupon-使用优惠券-data: %@", data);
        
    }];
    
    
    [self.bridge registerHandler:kH5Method_useCoupon handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"useCoupon-使用优惠券-data: %@", data);
        
    }];
    
    [self.bridge registerHandler:kH5Method_confirmdata handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"confirmdata-提交订单-data: %@", data);
        
    }];
    
    [self.bridge registerHandler:kH5Method_backMyfs handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"backMyfs-返回我的方盛-data: %@", data);
        
    }];
    

    
    [self.bridge registerHandler:kH5Method_contactService handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"contactService-客服-data: %@", data);
        
    }];
    
}

#pragma mark - RequestData
- (void)loadData {
    
    NSString *baseURL = kH5BaseURL;
    NSString *orderListURL = @"orderlist/index.html";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", baseURL , orderListURL];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.0];
    [self.webView loadRequest:request];
}


//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //    NSLog(@"%s", __func__);
    NSLog(@"页面加载完成-本次请求的URL：%@", webView.URL);
    
    //禁用长
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];
}

// 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    //    NSLog(@"%s", __func__);
}




#pragma mark - Lazy
- (WKWebView *)webView {
    if (_webView == nil) {
        CGFloat statusBarH = [[UIApplication sharedApplication] statusBarFrame].size.height;
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, statusBarH, kScreenWidth, kScreenHeight-statusBarH)];
        _webView.scrollView.bounces = NO;
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
    }
    return _webView;
}

- (WebViewJavascriptBridge *)bridge {
    if (_bridge == nil) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    }
    return _bridge;
}





@end
