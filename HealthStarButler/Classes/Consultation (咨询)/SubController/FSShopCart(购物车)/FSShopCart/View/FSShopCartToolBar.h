//
//  FSShopCartToolBar.h
//  FangShengyun
//
//  Created by 朱慕之 on 2018/7/27.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSShopCartToolBar;
@protocol FSShopCartToolBarDelegate <NSObject>
@optional
- (void)shopCartToolBarSelectedAllClick;
- (void)shopCartToolBarClearingClick;
@end

@interface FSShopCartToolBar : UIView

/** 全选按钮 */
@property (nonatomic, strong) UIButton *allClickBtn;
/** 价格 */
@property (nonatomic, strong) UILabel *price;
/** 操作按钮-结算/删除 */
@property (nonatomic, strong) UIButton *operationBtn;
/** 运费 */
@property (nonatomic, strong) UILabel *freight;
/** 选中标记 */
@property (nonatomic, assign) BOOL isSelected;

@property(nonatomic, weak) id<FSShopCartToolBarDelegate> delegate;

@end
