//
//  FSToastTool.h
//  FangShengyun
//
//  Created by 朱慕之 on 2018/7/18.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Toast.h"

@interface FSToastTool : NSObject

+ (void)makeToast:(NSString *)message targetView:(UIView *)targetView;

+ (void)makeToast:(NSString *)message targetView:(UIView *)targetView completion:(void(^)(BOOL didTap))completion;

+ (void)hideToast:(UIView *)targetView;

@end
