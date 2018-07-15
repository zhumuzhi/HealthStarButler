//
//  GHTagItem.m
//  QQtagView
//
//  Created by mac on 2018/7/8.
//  Copyright © 2018年 ZhangQun. All rights reserved.
//

#import "GHTagItem.h"

@implementation GHTagItem

- (instancetype)init {
    if (self = [super init]) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:15];
        self.padding = UIEdgeInsetsMake(10, 10, 10, 10);
        self.textAlignment = NSTextAlignmentCenter;
        self.delegate = self;
        self.tintColor = [UIColor clearColor];
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

-(void)textFieldDidBeginEditing:(UITextField*)textField {
    [textField resignFirstResponder];

    if (self.tagItemType == GHTagItemTypeNone) {
        self.backgroundColor = [UIColor blueColor];
        self.tagItemType = GHTagItemTypeSelected;
    }else if(self.tagItemType == GHTagItemTypeSelected){
        self.tagItemType = GHTagItemTypeNone;
    }else {
        
    }

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//设置文字的边距
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.padding.left,
                      bounds.origin.y + self.padding.top,
                      bounds.size.width - self.padding.right - self.padding.left,
                      bounds.size.height - self.padding.bottom - self.padding.bottom);
}
- (void)setPadding:(UIEdgeInsets)padding {
    _padding = padding;
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}
@end
