//
//  MEDNetStatusManager.m
//  MEDThyroid
//
//  Created by Harry on 16/2/19.
//  Copyright © 2016年 Jayce. All rights reserved.
//

#import "MEDNetStatusManager.h"
#import "Reachability.h"

@interface MEDNetStatusManager ()
@property (nonatomic, strong) Reachability *conn;
@end
@implementation MEDNetStatusManager

+(MEDNetStatusManager *)share;
{
    static MEDNetStatusManager *netManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netManager = [[MEDNetStatusManager alloc]init];
    });
    return netManager;
}

+(void)monitor
{
    MEDNetStatusManager *netManager = [MEDNetStatusManager share];
    [netManager checkNetworkState];
    [[NSNotificationCenter defaultCenter] addObserver:netManager selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    netManager.conn = [Reachability reachabilityForInternetConnection];
    [netManager.conn startNotifier];

}

- (void)networkStateChange
{
    [self checkNetworkState];
}
- (void)checkNetworkState
{
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    
    if ([wifi currentReachabilityStatus] != NotReachable||[conn currentReachabilityStatus] != NotReachable)
    {
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
//        CGPoint point = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2+100 );
//        NSValue *value = [NSValue valueWithCGPoint:point];
        //[window makeToast:@"当前网络可使用" duration:2 position:value];
        
    }
    
    else
    {
        //[SVProgressHUD dismiss];
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
//        CGPoint point = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2+100 );
//        NSValue *value = [NSValue valueWithCGPoint:point];
        //[window makeToast:@"网络异常，请检查您的网络" duration:2 position:value];
    }
}

+(BOOL)isNetWork
{

    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    if ([wifi currentReachabilityStatus] != NotReachable ||[conn currentReachabilityStatus] != NotReachable)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

@end
