//
//  GHTextField.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/6.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "GHTextField.h"

@implementation GHTextField

- (instancetype)initTextFieldWithLeftImageName: (NSString *)imageName
                                  placeholder : (NSString *)placeholder
                              placeholderColor: (UIColor *)placeholderColor
                               placeholderFont: (UIFont *)placeholderFont {
    GHTextField *textField = [[GHTextField alloc]init];

    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 14,18)];
    [leftView addSubview:imageView];
    imageView.image = [UIImage imageNamed:imageName];
    textField.leftView = leftView;

    if (placeholder.length) {
        NSMutableAttributedString *placeholderStr = [[NSMutableAttributedString alloc] initWithString:placeholder];
        [placeholderStr addAttribute:NSForegroundColorAttributeName
                               value:placeholderColor
                               range:NSMakeRange(0, placeholder.length)];
        [placeholderStr addAttribute:NSFontAttributeName
                               value:placeholderFont
                               range:NSMakeRange(0, placeholder.length)];
        textField.attributedPlaceholder = placeholderStr;
    }


    return textField;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {

    }
    return self;
}

@end
