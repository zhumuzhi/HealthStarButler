//
//  MEDTextField.h
//  BaseProject
//
//  Created by 朱慕之 on 2017/8/1.
//  Copyright © 2017年 mmednet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UITextField;
typedef void (^responseBlock)(NSString *responseObject);

@protocol MEDTextFieldDelegate <NSObject>
@optional
- (void)textField: (UITextField *)textField;
@end

@interface MEDTextField : UITextField
@property (nonatomic , weak) id <MEDTextFieldDelegate>textFieldDelegate;
@property (nonatomic , copy) responseBlock responseBlock;
@property (nonatomic , assign) NSInteger maxLength; //设置最大字数限制，目前写死为30
@end
