//
//  FSCountDownTestController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/28.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSCountDownTestController.h"
#import "OYSingleTableVC.h"

@interface FSCountDownTestController ()

@end

@implementation FSCountDownTestController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];
    [self configuration];
}

#pragma mark - ConfigUI
- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(150, 200, 100, 100)];
    [button setTitle:@"计时列表" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushToList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)pushToList {
    OYSingleTableVC * single = [[OYSingleTableVC alloc] init];
    [self.navigationController pushViewController:single animated:YES];
}


- (void)configuration {

}







@end
