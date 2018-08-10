//
//  FSPayPasswordView.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/8.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSPayPasswordView.h"
//#import <objc/runtime.h>

#define kPasswordBoxWidth kAutoWithSize(50) //输入框宽度
#define kPasswordBoxSpace kAutoWithSize(-0.5) //输入框间距
#define kPasswordBoxNumber 6 //输入框个数
#define kPasswordBoxMargin kAutoWithSize((kScreenWidth-(kPasswordBoxWidth*kPasswordBoxNumber))/2) //输入框边Margin
@interface FSPayPasswordView ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray <UILabel*> *labelBoxArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *currentText;

@end

@implementation FSPayPasswordView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, kScreenWidth, kPasswordBoxWidth);
        [self addSubview:self.textField];
        [self.textField becomeFirstResponder];
        [self initData];
    }
    return self;
}

- (void)initData {
    self.currentText = @"";
    for (int i = 0; i < kPasswordBoxNumber; i ++) {
        CGFloat X = ((kScreenWidth-(kPasswordBoxWidth*kPasswordBoxNumber))/2);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(X + i * (kPasswordBoxWidth + kPasswordBoxSpace), 0, kPasswordBoxWidth, kPasswordBoxWidth)];
        label.textColor = [UIColor colorWithHexString:@"#444444"];
        label.layer.borderWidth = 0.5f;
        label.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
//      label.layer.cornerRadius = kAutoWithSize(2);
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:30] ;
        [self addSubview:label];
        [self.labelBoxArray addObject:label];
    }
}

- (void)startShakeViewAnimation {
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    shake.values = @[@0,@-10,@10,@-10,@0];
    shake.additive = YES;
    shake.duration = 0.25;
    [self.layer addAnimation:shake forKey:@"shake"];
}

- (void)textDidChanged:(UITextField *)textField {
    if (textField.text.length > kPasswordBoxNumber) {
        textField.text = [textField.text substringToIndex:kPasswordBoxNumber];
    }
    
    [self updateLabelBoxWithText:textField.text];
    if (textField.text.length == kPasswordBoxNumber) {
        if (self.completionBlock) {
            self.completionBlock(self.textField.text);
        }
    }
}

static NSString *symbol = @"•";       // ・ • ● • •
static CGFloat BaselineOffset = 0;

#pragma mark - Public
- (void)updateLabelBoxWithText:(NSString *)text {
    //输入时
    if (text.length > self.currentText.length) {
        for (int i = 0; i < kPasswordBoxNumber; i++) {
            UILabel *label = self.labelBoxArray[i];
            if (i < text.length - 1) {
                //特殊字符不居中显示，设置文本向下偏移
                NSAttributedString * att1 = [[NSAttributedString alloc] initWithString:symbol attributes:@{NSBaselineOffsetAttributeName:@(BaselineOffset)}];
                label.attributedText = att1;
            } else if (i == text.length - 1) {
                label.text = [text substringWithRange:NSMakeRange(i, 1)];
                [self animationShowTextInLabel: label];
            } else {
                label.text = @"";
            }
        }
    }
    //删除时
    else {
        for (int i = 0; i < kPasswordBoxNumber; i++) {
            UILabel *label = self.labelBoxArray[i];
            if (i < text.length) {
                //特殊字符不居中显示，设置文本向下偏移
                NSAttributedString * att1 = [[NSAttributedString alloc] initWithString:symbol attributes:@{NSBaselineOffsetAttributeName:@(BaselineOffset)}];
                label.attributedText = att1;
            } else {
                label.text = @"";
            }
        }
    }
    self.textField.text = text;
    self.currentText = text;
}

- (void)animationShowTextInLabel:(UILabel *)label {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //特殊字符不居中显示，设置文本向下偏移
        NSAttributedString * att1 = [[NSAttributedString alloc] initWithString:symbol attributes:@{NSBaselineOffsetAttributeName:@(BaselineOffset)}];
        label.attributedText = att1;
    });
}

- (void)didInputPasswordError {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startShakeViewAnimation]; //摇动动画
        self.textField.text = @"";
        [self updateAllLabelTextToNone];
    });
}

- (void)updateAllLabelTextToNone {
    for (int i = 0; i < kPasswordBoxNumber; i++) {
        UILabel *label = self.labelBoxArray[i];
        label.text = @"";
    }
}

- (void)transformTextInTextField:(UITextField *)textField {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        textField.text = symbol;
    });
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

#pragma mark - Getter/Setter
- (NSMutableArray *)labelBoxArray {
    if (!_labelBoxArray) {
        _labelBoxArray = [NSMutableArray array];
    }
    return _labelBoxArray;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        [_textField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
    }
    return _textField;
}

@end
