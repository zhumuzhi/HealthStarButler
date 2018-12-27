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
    
    FSPromotionTagsView *tagsView = [[FSPromotionTagsView alloc] initWithFrame:CGRectMake(0, 300, kScreenWidth, 200)];
    [self.view addSubview:tagsView];
    tagsView.itemArry = [NSMutableArray arrayWithArray:@[@"满减", @"特价"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
