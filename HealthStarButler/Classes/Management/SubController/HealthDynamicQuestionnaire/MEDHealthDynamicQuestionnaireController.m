//
//  MEDHealthDynamicQuestionnaireController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/5/23.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDHealthDynamicQuestionnaireController.h"

@interface MEDHealthDynamicQuestionnaireController ()

@end

@implementation MEDHealthDynamicQuestionnaireController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavigation];
    
    
}

#pragma mark - ConfigUI
- (void)configNavigation {
    
    self.navigationItem.title = @"健康动态问卷";
}



/**

 */


@end
