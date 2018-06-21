//
//  MEDInputAlertView.h
//  HealthNNN
//
//  Created by 朱慕之 on 2017/1/22.
//  Copyright © 2017年 mmednet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^removeCoverAndInputView)(NSString *inputContent);

@interface MEDInputAlertView : UIView

@property (nonatomic,copy) removeCoverAndInputView removeView;

/**
 *输入内容 界面布局 文字传播
 */
- (id) initWithFrame:(CGRect)frame andTitle:(NSString *)title andPlaceHolderTitle:(NSString *)palceContent;


@end
