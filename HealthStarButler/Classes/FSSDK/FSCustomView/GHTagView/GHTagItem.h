//
//  GHTagItem.h
//  QQtagView
//
//  Created by mac on 2018/7/8.
//  Copyright © 2018年 ZhangQun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSUInteger,GHTagItemType) {
    GHTagItemTypeSelected = 1,// 不可编辑的选中状态
    GHTagItemTypeNone,//不可编辑的无状态
    GHTagItemTypeEditNone ,//可编辑的无状态
    GHTagItemTypeEditSelected,// 可编辑的选中状态
};
@class GHTagItem;
@protocol GHTagItemDelegate <NSObject>
@end
@interface GHTagItem : UITextField<UITextFieldDelegate>
@property (nonatomic,assign) GHTagItemType tagItemType;
@property(nonatomic) UIEdgeInsets padding;

@end
