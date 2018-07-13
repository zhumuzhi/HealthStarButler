//
//  MZFormTextField.h
//  GHFrom
//
//  Created by GHome on 2018/1/26.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHTextField;
typedef void(^ImageCallBack)(void);
@protocol MZFormTextFieldDelegate <NSObject>
@optional
- (void)textField: (GHTextField *)textField image: (UIImage  *)image;
- (void)textField: (GHTextField *)textField state: (BOOL)state;
@end
@interface MZFormTextField : UITextField
@property (nonatomic , assign) bool isShowStar;
@property (nonatomic , assign) bool isSwitch;

@property (nonatomic , copy) NSString *imageName;
@property (nonatomic , copy)ImageCallBack imageCallBack;
@property (nonatomic , weak) id <MZFormTextFieldDelegate>textFieldDelegate;

@end
