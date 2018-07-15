//
//  GHTagView.m
//  QQtagView
//
//  Created by mac on 2018/7/8.
//  Copyright © 2018年 ZhangQun. All rights reserved.
//

#import "GHTagView.h"
@interface GHTagView()
@property (nonatomic , strong) NSMutableArray *data;
@end
@implementation GHTagView

- (instancetype)init {
    if (self = [super init]) {
        self.tagFontSize = 12;
        self.tagSpace = 10;
        self.padding = UIEdgeInsetsMake(10, 10, 10, 10);
        self.style = GHTagItemTypeNone;
        self.backgroundColor =[UIColor redColor];
    }
    return self;
}
- (void)removeAllData {
    for (GHTagItem *item in self.subviews) {
        [item removeFromSuperview];
    }
    [self.data removeAllObjects];
}

- (void)removeWithString: (NSString *)string {
    for (GHTagItem *item in self.subviews) {
        if([item.text isEqualToString:string]) {
            [item removeFromSuperview];
        }
    }
}

- (void)removeWithIndex:(NSInteger)index {
    for (GHTagItem *item in self.subviews) {
        if (item.tag == index) {
            [item removeFromSuperview];
        }
    }
}

- (void)remove:(NSInteger )tag {
    for (GHTagItem *item in self.subviews) {
        if(item.tag == tag) {
            [item removeFromSuperview];
        }
    }
}


- (void)buttonClick:(FSButton *)btn {
    
    [self remove:btn.tag];
    NSMutableArray *data = [NSMutableArray array];
    for (GHTagItem *item in self.subviews) {
        [data addObject:item.text];
    }
    self.data = data.mutableCopy;
}

- (void)addTagWithText: (NSString *)text index: (NSInteger)index { 
    CGRect frame = CGRectZero;
    if(self.subviews && self.subviews.count > 0) {
        frame = [self.subviews lastObject].frame;
        for (NSInteger index = 0; index < self.subviews.count; index++) {
            GHTagItem *item = [self.subviews by_ObjectAtIndex:index];
            if ([item.text isEqualToString:text]) {
                return;
            }
        }
    }
    GHTagItem *item = [[GHTagItem alloc]init];
    item.text = text;
    NSInteger count = self.subviews.count;
    item.tag = count;
    UIView *rightVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
    FSButton *button = [FSButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(4, 5, 16, 16);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = count;
    [rightVeiw addSubview:button];
    item.rightView = rightVeiw;
    item.rightViewMode = UITextFieldViewModeAlways;
    item.padding = UIEdgeInsetsMake(10, 10, 10, 26);//字体与控件的距离
 
    item.frame = CGRectMake(frame.origin.x, frame.origin.y, item.frame.size.width, item.frame.size.height);
    [item sizeToFit];
    [self addSubview:item];
    
    NSMutableArray *data = [NSMutableArray array];
    for (GHTagItem *item in self.subviews) {
        [data addObject:item.text];
    }
    self.data = data.mutableCopy;
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    [UIView beginAnimations:nil context:nil];
    CGFloat paddingRight = self.padding.right;
    CGFloat cellspace = 5;
    CGFloat y = self.padding.top;
    CGFloat x = self.padding.left;
    CGRect frame;
    for(UIView *tag in self.subviews) {
        frame = tag.frame;
        frame.origin.x = x;
        frame.origin.y = y;      
        if(frame.origin.x + frame.size.width + paddingRight > self.frame.size.width) {
            // 换行
            frame.origin.x = self.padding.left;
            frame.origin.y = frame.origin.y + frame.size.height + cellspace;
            
            y = frame.origin.y;
        }
        
        if(frame.origin.x + frame.size.width > self.frame.size.width - paddingRight) {
            frame.size.width = self.frame.size.width - paddingRight - frame.origin.x;
        }
        
        x = frame.origin.x + frame.size.width + cellspace;
        tag.frame = frame;
    }
    CGFloat containerHeight = frame.origin.y + frame.size.height + self.padding.bottom;
    CGRect containerFrame = self.frame;
    containerFrame.size.height = containerHeight;
    self.frame = containerFrame;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagView:frame:)]) {
        [self.delegate tagView:self frame:self.frame];
    }
    [UIView commitAnimations];
}
- (NSMutableArray *)data {
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}
@end
