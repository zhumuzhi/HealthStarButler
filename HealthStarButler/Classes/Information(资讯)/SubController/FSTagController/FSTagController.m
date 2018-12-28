//
//  FSTagController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/12/27.
//  Copyright © 2018 zhumuzhi. All rights reserved.
//

#import "FSTagController.h"
#import "FSPromotionTagsView.h"

@interface FSTagController ()

@end

@implementation FSTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    FSPromotionTagsView *tagsView = [[FSPromotionTagsView alloc] initWithFrame:CGRectMake(0, 300, kScreenWidth, 30)];
    
    [self.view addSubview:tagsView];
    
    tagsView.itemArry = [NSMutableArray arrayWithArray:@[@"满减", @"特价", @"年终大促"]];
    
}

@end
