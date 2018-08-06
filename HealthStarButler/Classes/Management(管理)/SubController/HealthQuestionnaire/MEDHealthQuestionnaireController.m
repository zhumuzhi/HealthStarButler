//
//  MEDHealthQuestionnaireController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/27.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDHealthQuestionnaireController.h"

@interface MEDHealthQuestionnaireController ()

@property (nonatomic, strong) UILabel *titleLab;


@end

@implementation MEDHealthQuestionnaireController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *str = @"<font color='red'>赫里斯</font> HELISI 架子工 <font color='red'>扳手</font>";
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

    [self.view addSubview:self.titleLab];
    self.titleLab.attributedText = attrStr;

//        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.centerX.equalTo(self);
//            make.width.equalTo(@(300));
//            make.height.equalTo(@(30));
//        }];

}

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        CGRect titleFrame = CGRectMake(50, 300, kScreenWidth-100, 30);
        _titleLab.frame = titleFrame;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - WKNavigationDelegate

// 1 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"1-------在发送请求之前，决定是否跳转  -->%@",navigationAction.request);
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 2 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"2-------页面开始加载时调用");
}

// 3 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    /// 在收到服务器的响应头，根据response相关信息，决定是否跳转。decisionHandler必须调用，来决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
    
    NSLog(@"3-------在收到响应后，决定是否跳转");
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 4 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"4-------当内容开始返回时调用");
}

// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"5-------页面加载完成之后调用");
}

// 6 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"6-------页面加载失败时调用");
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"-------接收到服务器跳转请求之后调用");
}

// 数据加载发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"----数据加载发生错误时调用");
}

// 需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    //用户身份信息
    
    NSLog(@"----需要响应身份验证时调用 同样在block中需要传入用户身份凭证");
    
    NSURLCredential *newCred = [NSURLCredential credentialWithUser:@""
                                                          password:@""
                                                       persistence:NSURLCredentialPersistenceNone];
    // 为 challenge 的发送方提供 credential
    [[challenge sender] useCredential:newCred forAuthenticationChallenge:challenge];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
}

// 进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"----------进程被终止时调用");
}





@end
