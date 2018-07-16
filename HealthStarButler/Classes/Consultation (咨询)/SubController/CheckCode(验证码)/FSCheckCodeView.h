//
//  FSCheckCodeView.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/16.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSCheckCodeView;
@protocol FSCheckCodeViewDelegate <NSObject>
@optional
/* 点击图形验证码 */
- (void)didTapFSCheckCodeView:(FSCheckCodeView *)checkCodeView;
@end

@interface FSCheckCodeView : UIView
/* 接收外部传的code*/
@property (nonatomic,strong) NSString *codeStr;
@property (nonatomic,assign) id<FSCheckCodeViewDelegate> delegate;

@end
