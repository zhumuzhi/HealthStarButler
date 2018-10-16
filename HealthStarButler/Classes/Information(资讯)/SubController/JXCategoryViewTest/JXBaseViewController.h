//
//  JXBaseViewController.h
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/16.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryView.h"

#define WindowsSize [UIScreen mainScreen].bounds.size

@interface JXBaseViewController : UIViewController

@property (nonatomic, assign) BOOL isNeedIndicatorPositionChangeItem;

@property (nonatomic, strong) JXCategoryBaseView *categoryView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL shouldHandleScreenEdgeGesture;

- (Class)preferredCategoryViewClass;

- (NSUInteger)preferredListViewCount;

- (CGFloat)preferredCategoryViewHeight;

- (Class)preferredListViewControllerClass;

- (void)configListViewController:(UIViewController *)controller index:(NSUInteger)index;



@end


