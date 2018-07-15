//
//  FSDebugButton.h
//  FangShengyun
//
//  Created by mac on 2018/7/13.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DebugCallBack)(void);
@interface FSDebugButton : UIView
+ (instancetype)sharedManager;
- (void)creatDebugButtonCallBack: (DebugCallBack)callBack addView: (UIView *)view;
@end
