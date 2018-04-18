//
//  MEDBaseViewController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDBaseViewController.h"

@interface MEDBaseViewController ()

@end

@implementation MEDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MEDGrayColor(243);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)setupPersonNavigationItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"nav_mine"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"nav_mine"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton addTarget:self action:@selector(clickMineButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (void)clickMineButton {
    
    MEDMineController *mimeController = [[MEDMineController alloc] init];
    [self.navigationController pushViewController:mimeController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
