//
//  FSPayPopMenu.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/9.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSPayTextField.h"

@class FSPayPopMenu;
@protocol FSPayPopMenuDelegate <NSObject>
@optional
/** 忘记密码 */
- (void)payPopMenuClickedForgetPassWord:(FSPayPopMenu *)payPopMenu;
/** 重新输入密码 */
- (void)payPopMenuInputCorrect:(FSPayPopMenu *)payPopMenu;
/** 密码错误 */
- (void)payPopMenuWrongPassWord:(FSPayPopMenu *)payPopMenu;

@end

@interface FSPayPopMenu : UIView

@property (nonatomic, strong) FSPayTextField *payTextField;

@property (nonatomic,weak) id<FSPayPopMenuDelegate> delegate;

@end
