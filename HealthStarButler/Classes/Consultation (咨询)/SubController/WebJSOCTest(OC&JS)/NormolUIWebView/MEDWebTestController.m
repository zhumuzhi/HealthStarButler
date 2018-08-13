//
//  MEDWebTestController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/20.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDWebTestController.h"

#import <JavaScriptCore/JSContext.h>      // JS调用OC
#import <JavaScriptCore/JavaScriptCore.h> // OC调用JS

//typedef NS_ENUM(NSInteger, MZSettingItemType) {
//    MZSettingItemTypeNone = 0,  // 什么也没有
//    MZSettingItemTypeArrow,     // 箭头
//    MZSettingItemTypeImage,     // 图片
//    MZSettingItemTypeSwitch,    // 开关
//    MZSettingItemTypeTextField  // 文本
//};

typedef NS_ENUM(NSInteger, MZWebCallType) {
    MZWebCallTypeOCCallJS = 0, //OC调用JS
    MZWebCallTypeJSCallOC      //JS调用OC
};

@interface MEDWebTestController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;
@property(nonatomic,strong)JSContext *context;
@property (nonatomic, assign) MZWebCallType type;

@end

@implementation MEDWebTestController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.type = MZWebCallTypeOCCallJS;

    [self configNavigaton];

    [self configUI];
    [self loadData];
}

#pragma mark - congfigUI
- (void)configNavigaton
{
    UIBarButtonItem *rOne = [[UIBarButtonItem alloc]initWithTitle:@"切换" style:UIBarButtonItemStyleDone target:self action:@selector(changeWebType)];
    UIBarButtonItem *rTwo = [[UIBarButtonItem alloc]initWithTitle:@"改变" style:UIBarButtonItemStyleDone target:self action:@selector(changetitleOCCallJS)];
    self.navigationItem.rightBarButtonItems = @[rOne, rTwo];
}

- (void)changetitleOCCallJS {
    JSValue *labelAction = self.context[@"labelAction"];
    [labelAction callWithArguments:@[@"你好,JS世界!"]];
}

// OC>JS & JS>OC 切换
- (void)changeWebType {

    if (self.type == MZWebCallTypeJSCallOC) {
        self.type = MZWebCallTypeOCCallJS;
    }else {
        self.type = MZWebCallTypeJSCallOC;
    }

    if (self.type == MZWebCallTypeJSCallOC) {
        NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"index.html"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
        [self.webView loadRequest:request];

    }else if(self.type == MZWebCallTypeOCCallJS){
        NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"ocCallJS.html"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
        [self.webView loadRequest: request];

    }
}

- (void)configUI {

    self.navigationItem.title = @"WebView网页测试";
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight-kNavigationHeight)];
    self.webView = webView;
    webView.delegate = self;
    [self.view addSubview:webView];
}

- (void)loadData
{
//===== 网络数据 =====
//  NSURL *url = [NSURL URLWithString:@"https://kefu.huayunworld.com/H5/index.html#/chat?skillGroupld=1&ecterpriseld=1"];
    NSURL *url = [NSURL URLWithString:@"https://kefu.huayunworld.com/H5/index.html#/chat?skillGroupId=43&enterpriseId=9"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//===== 网络数据 =====

//===== 本地数据 =====
//    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"index.html"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
//===== 本地数据 =====

    [self.webView loadRequest:request];
}



#pragma mark - UIWebDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {

    if (self.type == MZWebCallTypeJSCallOC) {
        self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue)
        {
            context.exception = exceptionValue;
        };

        //    __weak typeof(self)temp = self;

        MEDWeakSelf(self);
        // 点击返回上一页执行的方法
        self.context[@"myAction"] = ^(){
            [weakself.navigationController popViewControllerAnimated:YES];
        };

        // 打印输入的信息
        self.context[@"log"] = ^(NSString *string){
            NSLog(@"%@",string);
        };
        // 调用方法
        self.context[@"native"] = self;
    }else if (self.type == MZWebCallTypeOCCallJS) {
        self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];

        self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue)
        {
            context.exception = exceptionValue;
        };
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSLog(@"获取的值为:%@",request.URL);
    return YES;
}

- (void)myOCLog :(NSString *)string{
    NSLog(@"你好,世界!");
}


@end
