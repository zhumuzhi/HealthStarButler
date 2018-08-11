//
//  FSPayPopupView.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/8.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//  需要解决密文显示问题

#import <UIKit/UIKit.h>

@class FSPayPopupView;
@protocol FSPayPopupViewDelegate <NSObject>
@optional
/** 输入完成 */
- (void)payPopupViewPasswordInputFinished:(NSString *)password;
/** 点击忘密码 */
- (void)payPopupViewDidClickForgetPasswordButton:(FSPayPopupView *)payPopupView;
@end

@interface FSPayPopupView : UIView

@property (nonatomic, weak) id <FSPayPopupViewDelegate> delegate;
- (void)showPayPopView;
- (void)hidePayPopView;
- (void)didInputPayPasswordError;

@end
