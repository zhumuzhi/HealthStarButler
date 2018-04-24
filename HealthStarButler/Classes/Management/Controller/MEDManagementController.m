//
//  MEDManagementController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDManagementController.h"


@interface MEDManagementController ()

@end

@implementation MEDManagementController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigation];
    
}

#pragma mark - NetWork
- (void)getData
{
    
    
}



#pragma mark - UI
/** 设置Navigation */
- (void)setupNavigation {
    self.navigationItem.title = @"管理";
    [self setupPersonNavigationItem];
}



@end
