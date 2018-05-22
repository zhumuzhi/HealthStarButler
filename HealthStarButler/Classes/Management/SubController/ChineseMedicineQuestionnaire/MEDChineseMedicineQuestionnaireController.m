//
//  MEDChineseMedicineQuestionnaireController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/22.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDChineseMedicineQuestionnaireController.h"
#import <WebKit/WebKit.h>

#define CHINAQUESTION @"health/question/tcmQuestionnaire"

@interface MEDChineseMedicineQuestionnaireController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation MEDChineseMedicineQuestionnaireController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configNavigation];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
}

#pragma mark - configUI

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:SecondPageFrame];
        
        MEDUserModel *userModel = [MEDUserModel sharedUserModel];
        
        NSString *requestStr = [NSString stringWithFormat:@"%@%@?uid=%@&from=1",MED_DOMAIN_REQUEST,CHINAQUESTION, userModel.uid];
        NSLog(@"中医请求:%@", requestStr);
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestStr]];

        // WKWebView加载请求
        [_webView loadRequest:request];
    }
    return _webView;
}




/** 导航 */
- (void)configNavigation {
    self.navigationItem.title = @"中医体质问卷";
    
    UIButton *historyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [historyBtn setTitle:@"历史" forState:UIControlStateNormal];
    historyBtn.titleLabel.font = MEDSYSFont(17);
    historyBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [historyBtn addTarget:self action:@selector(historyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:historyBtn];
}



- (void)historyBtnClick {
    NSLog(@"点击了历史按钮");
}




@end
