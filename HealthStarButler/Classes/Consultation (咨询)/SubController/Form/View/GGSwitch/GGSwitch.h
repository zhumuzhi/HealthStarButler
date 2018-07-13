//
//  GGSwitch.h
//  GGSwitch
//
//  Created by __无邪_ on 15/4/29.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GGSwitch;
@protocol GGSwitchDelegate <NSObject>
@optional

- (void)ggswitch: (GGSwitch *)ggswitch state: (BOOL)state;

@end
@interface GGSwitch : UIControl

@property (nonatomic, strong) UIColor *onTintColor;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *thumbTintColor;
@property (nonatomic, strong) NSString *onText;
@property (nonatomic, strong) NSString *offText;

@property (nonatomic, unsafe_unretained) CGSize switchSize;// 设置大小， 建议宽高比2：1左右


@property (nonatomic, strong, setter=actionBlock:) void(^tapBlock)(BOOL on);
@property(nonatomic,getter=isOn) BOOL on;
@property (nonatomic , weak) id <GGSwitchDelegate>delegate;



- (instancetype)initWithFrame:(CGRect)frame;    // This class enforces a size appropriate for the control. The frame size is ignored.

- (void)setOn:(BOOL)on animated:(BOOL)animated; // does not send action



@end
