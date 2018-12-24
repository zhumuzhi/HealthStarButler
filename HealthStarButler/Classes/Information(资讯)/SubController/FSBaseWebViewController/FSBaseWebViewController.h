//
//  FSBaseWebViewController.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/21.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger,FSBaseWebViewType) {
    /** WebView类型 */
    FSBaseWebViewTypeWebView = 1,
    /** WKWebView类型 */
    FSBaseWebViewTypeWKWebView
};

NS_ASSUME_NONNULL_BEGIN

@interface FSBaseWebViewController : UIViewController

@property (nonatomic, assign) FSBaseWebViewType webViewType;

@property (nonatomic, copy) NSString *url;

@end

NS_ASSUME_NONNULL_END
