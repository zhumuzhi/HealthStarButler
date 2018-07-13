//
//  MZFormTextField.m
//  GHFrom
//
//  Created by GHome on 2018/1/26.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "MZFormTextField.h"
#import "GGSwitch.h"
@interface MZFormTextField()<GGSwitchDelegate>
@end
@implementation MZFormTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"*";
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor redColor];
        CGSize size = [self sizeWithText:label.text font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT)];
        label.frame = CGRectMake(0, 0, size.width, self.bounds.size.height);
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width + 5, self.bounds.size.height)];
        [leftView addSubview:label];
        self.leftView = leftView;

    }
    return self;
}

- (void)setIsSwitch:(bool)isSwitch {
    _isSwitch = isSwitch;
    if (isSwitch) {
       
        GGSwitch *rightSwitch = [[GGSwitch alloc]init];
        UIView *rightView = [[UIView alloc]init];
        rightSwitch.onText = @"男";
        rightSwitch.offText = @"女";
        [rightSwitch setSwitchSize:CGSizeMake(70, 30)];
        rightSwitch.delegate = self;
        rightView.frame = CGRectMake(0, 0, rightSwitch.frame.size.width , rightSwitch.frame.size.height);
        [rightView addSubview:rightSwitch];
        self.rightView = rightView;
        self.rightViewMode = UITextFieldViewModeAlways;   
    }
}
- (void)ggswitch:(GGSwitch *)ggswitch state:(BOOL)state {
    
    if (self.textFieldDelegate && [self.textFieldDelegate respondsToSelector:@selector(textField:state:)]) {
        [self.textFieldDelegate textField:self state:state];
    }
}
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    if (imageName.length > 0) {
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, image.size.width, image.size.height)];
        imageView.image = image;
        imageView.userInteractionEnabled = YES;
        UIView *rightView = [[UIView alloc]init];
        rightView.frame = CGRectMake(0, 0, image.size.width + 5, image.size.height);
        [rightView addSubview:imageView];
        self.rightView = rightView;
        self.rightViewMode = UITextFieldViewModeAlways;
        
        UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapGesture:)];
        [imageView addGestureRecognizer:tap];
    }
}

#pragma mark - 手势事件
- (void)respondToTapGesture:(UITapGestureRecognizer *)ges {
    if (self.imageCallBack) {
        self.imageCallBack();
    }
    UIImageView *imageView = (UIImageView *)ges.view;
  
    if (self.textFieldDelegate && [self.textFieldDelegate respondsToSelector:@selector(textField:image:)]) {
        [self.textFieldDelegate textField:self image:imageView.image];
    }
}

- (void)setIsShowStar:(bool)isShowStar {
    _isShowStar = isShowStar;
    if (isShowStar) {
        self.leftViewMode = UITextFieldViewModeAlways;
    } else {
        self.leftViewMode = UITextFieldViewModeWhileEditing;
    }
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}
@end
