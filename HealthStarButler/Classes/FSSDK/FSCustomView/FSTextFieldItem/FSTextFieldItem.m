//
//  FSTextFieldItem.m
//  FangShengyun
//
//  Created by mac on 2018/7/13.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSTextFieldItem.h"
@interface FSTextFieldItem()
@property (nonatomic , strong) FSButton *button;
@property (nonatomic , copy) NSString *normalImageName;
@property (nonatomic , copy) NSString *seletedImageName;

@end
@implementation FSTextFieldItem

+ (FSTextFieldItem *)creatTextFieldItemWithFrame:(CGRect)frame normalImageName: (NSString *)normalImageName seletedImageName: (NSString *)seletedImageName
                                        itemType: (FSTextFieldItemType)itemType {
    
    FSTextFieldItem *view = [[FSTextFieldItem alloc]initWithFrame:frame type:itemType normalImageName:normalImageName seletedImageName:(NSString *)seletedImageName];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame type:(FSTextFieldItemType)type normalImageName: (NSString *)normalImageName seletedImageName: (NSString *)seletedImageName {
    if (self == [super initWithFrame:frame]) {
        CGFloat margin = 0;
        CGFloat width = 0;

        if (type == FSTextFieldItemTypeLeft) {
            margin = 0;
            width = 10;
        } else if (type == FSTextFieldItemTypeRight) {
            margin = 5;
            width = 10;
        }
        FSButton *button = [[FSButton alloc]initWithFrame:CGRectMake(margin, 0, frame.size.width - width, frame.size.height)];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:seletedImageName] forState:UIControlStateSelected];
        [self addSubview:button];
    }
    return self;
}
- (void)clickButton: (FSButton *)button {
    button.selected = !button.selected;
}

@end
