//
//  FSSearchBarView.h
//  FangShengyun
//
//  Created by mac on 2018/6/18.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSLocationView.h"

typedef NS_ENUM (NSUInteger,FSSearchBarButtonType) {
    /** 定位按钮 */
    FSSearchBarButtonTypeLocation = 1,
    /** 返回按钮 */
    FSSearchBarButtonTypeBack,
    /** 搜索按钮 */
    FSSearchBarButtonTypeSearch,
    /** 清除搜索按钮 */
    FSSearchBarButtonTypeClearSearchString,
};
typedef NS_ENUM (NSUInteger,FSSearchBarType) {
    /** 首页 */
    FSSearchBarTypeHome = 1,
    /** 分类 */
    FSSearchBarTypeCategory,
    /** 商品页 */
    FSSearchBarTypeSubCategory,
    /** 搜索控制器 */
    FSSearchBarTypeSearch,
    /** 区域搜索 */
    FSSearchBarTypeZoneSearch,
};
@class FSSearchBarView;
@protocol FSSearchBarViewDelegate <NSObject>
@optional

- (void)searchBarViewDidClick: (FSSearchBarView *)searchBarView type: (FSSearchBarButtonType)type;

- (void)searchBarView:(FSSearchBarView *)searchBarView userInput: (NSString *)text;
@end
@interface FSSearchBarView : UIView
@property (nonatomic , assign) FSSearchBarType searchBarType ;
@property (nonatomic , weak) id <FSSearchBarViewDelegate> delegate;
/** searchBar背景色 */
@property (nonatomic , strong) UIColor *searchBarBackColor;
/** searchBar */
@property (nonatomic , strong) UITextField *searchBar;
/** searchBar透明度 */
@property (nonatomic , assign) CGFloat searchBarAlpha;
/** 用户搜索内容 */
@property (nonatomic , copy) NSString *searchString;
@property (nonatomic , strong) FSLocationView *locationView;

@end
