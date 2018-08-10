//
//  FSPayPasswordView.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/8.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FSInputPasswordCompletionBlock)(NSString *password);

@interface FSPayPasswordView : UIView
/** 数组完成block */
@property (nonatomic,copy)FSInputPasswordCompletionBlock completionBlock;

/** 更新输入框数据 */
- (void)updateLabelBoxWithText:(NSString *)text;

/** 抖动输入框 */
- (void)startShakeViewAnimation;

- (void)didInputPasswordError;


@end
