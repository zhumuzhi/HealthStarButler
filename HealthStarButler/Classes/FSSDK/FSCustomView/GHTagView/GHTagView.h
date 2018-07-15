//
//  GHTagView.h
//  QQtagView
//
//  Created by mac on 2018/7/8.
//  Copyright © 2018年 ZhangQun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHTagItem.h"

@class GHTagView;
@protocol GHTagViewDelegate <NSObject>
- (void)tagView: (GHTagView *)tagView frame: (CGRect)frame;
@end
@interface GHTagView : UIView
@property (nonatomic , weak) id <GHTagViewDelegate> delegate;

@property (nonatomic,assign) GHTagItemType style;
@property(nonatomic, assign) CGFloat tagSpace;// space between two tag, default is 10
@property(nonatomic, assign) CGFloat tagFontSize; // default is 12
@property(nonatomic) UIEdgeInsets padding; // container inner spacing, default is {10, 10, 10, 10}
@property(nonatomic) UIEdgeInsets tagTextPadding; // tag text inner spaces, default is {3, 5, 3, 5}
- (void)removeWithIndex: (NSInteger)index;
- (void)addTagWithText: (NSString *)text index: (NSInteger)index;
- (NSMutableArray *)data;
- (void)removeAllData;
@end
