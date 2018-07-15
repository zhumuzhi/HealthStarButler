//
//  GHHTTPManager.m
//  Field
//
//  Created by 赵治玮 on 2017/11/8.
//  Copyright © 2017年 赵治玮. All rights reserved.
//

#import "GHHTTPManager.h"
//#import "PPNetworkHelper.h"

@implementation GHHTTPManager
+ (instancetype)sharedManager {
    
    static GHHTTPManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = [NSURL URLWithString:kBaseUrl];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 10;
        [_instance.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        _instance = [[self alloc] initWithBaseURL:baseUrl sessionConfiguration:config];
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/plain", @"text/javascript", nil];
    });
    return _instance;
}


- (void)requstDataWithUrl: (NSString *)url parametes: (NSDictionary *)parametes finishedBlock: (FinishedBlock)finishedBlock {
    
//    NSString *cacheStr = [NSString stringWithFormat:@"%@%@",url,parametes.mj_JSONString];
    [[GHHTTPManager sharedManager] POST:url parameters:parametes progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finishedBlock(responseObject,nil);
//        [[CacheHelper sharedManager] saveJsonResponseToCacheFile:responseObject andURL:cacheStr];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
//        finishedBlock([[CacheHelper sharedManager] cacheJsonWithURL:cacheStr],error);
    }];
    
}

- (void)requstSearchDataWithUrl: (NSString *)url parametes: (NSDictionary *)parametes finishedBlock: (FinishedBlock)finishedBlock {
    NSString *cacheStr = [NSString stringWithFormat:@"%@%@",url,parametes.mj_JSONString];
    //UTF-8转码
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //把传进来的URL字符串变为URL地址
    NSURL *urlString = [NSURL URLWithString:urlStr];
    NSLog(@"urlString%@",urlString);
    //请求初始化
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlString cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];

    //解析请求参数，用NSDictionary来存参数，通过自定义的函数把它解析成post格式的字符串
    NSString *parseParam = parametes.mj_JSONString;
    NSLog(@"urlString%@",parametes.mj_JSONString);
    NSData *postData = [parseParam dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //将字符串转化成data数据
    //设置请求体
    [request setHTTPBody:postData];
    //设置请求方法
    [request setHTTPMethod:@"POST"];
    //创建一个新的队列
    NSOperationQueue *queue = [NSOperationQueue new];
    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//            [[CacheHelper sharedManager] saveJsonResponseToCacheFile:dictionary andURL:cacheStr];
            finishedBlock(dictionary,nil);
        } else {
            finishedBlock(nil,connectionError);
        }
    }];
//    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
//    manger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    manger.responseSerializer = [AFHTTPResponseSerializer  serializer];
//    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
//    NSMutableURLRequest *requst = [[AFJSONRequestSerializer serializer]requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
//    NSLog(@"url%@",url);
//    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/plain", @"text/javascript", nil];
//    [manger.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
//    NSError *parseError = nil;
//    if (parametes) {
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parametes options:NSJSONWritingPrettyPrinted error:&parseError];
//        [requst setHTTPBody:jsonData];
//    }
//
//    [manger dataTaskWithRequest:requst completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        NSLog(@"走了吗");
//
//        if (!error) {
//            id returnData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            finishedBlock(returnData,nil);
//
//        }
//        NSLog(@"%@",error);
//    }];
//    [manger tasks];
    
}


- (void)requstGoodDetailsWithUrl: (NSString *)url finishedBlock: (FinishedBlock)finishedBlock {
    
    NSString *cacheStr = [NSString stringWithFormat:@"%@",url];
    [[GHHTTPManager sharedManager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finishedBlock(responseObject,nil);
//        [[CacheHelper sharedManager] saveJsonResponseToCacheFile:responseObject andURL:cacheStr];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finishedBlock(nil,error);
    }];
}
@end
