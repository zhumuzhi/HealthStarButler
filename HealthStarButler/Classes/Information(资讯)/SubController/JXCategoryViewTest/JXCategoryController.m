//
//  JXCategoryController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/10/16.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "JXCategoryController.h"
#import "JXCategoryTitleView.h"

@interface JXCategoryController ()<JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) NSArray *titles;


@end

@implementation JXCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
//    [self configuration];
}

- (void)configUI {
    self.myCategoryView.titles = self.titles;
}

#pragma mark - Configuration
- (void)configuration {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"JXCategoryTitleView";
}

#pragma mark - Lazy
- (NSArray *)titles {
    if (_titles == nil) {
        _titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果", @"营养胡萝卜", @"葡萄", @"美味西瓜", @"香蕉", @"香甜菠萝", @"鸡肉", @"鱼", @"海星"];
    }
    return _titles;
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (NSUInteger)preferredListViewCount {
    return self.titles.count;
}

- (Class)preferredCategoryViewClass {
    return [JXCategoryTitleView class];
}

@end
