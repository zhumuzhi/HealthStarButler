//
//  FSTableView.h
//  FangShengyun
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSTableView : UITableView<UIGestureRecognizerDelegate>
/** 是否隐藏线 */
@property (nonatomic , assign) BOOL isHiddenLine;
@property (nonatomic , strong) NSMutableArray *dataArray;

- (void)addHeaderWithTarget:(id)target action:(SEL)action;
- (void)addFooterWithTarget:(id)target action:(SEL)action;
- (void)headerBeginRefreshing;
- (void)headerEndRefreshing;
- (void)footerBeginRefreshing;
- (void)footerEndRefreshing;
@end
