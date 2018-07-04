//
//  MEDConsultationController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDConsultationController.h"
#import "FSButton.h"

@interface MEDConsultationController ()

@end

@implementation MEDConsultationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigation];
}

- (void)setupNavigation {
    
    self.navigationItem.title = @"咨询";
    [self setupPersonNavigationItem];

    FSButton *button = [[FSButton alloc] initWithFrame:CGRectMake(50, Navigation_Height+50, 100, 50)];
    button.buttonStyle = imageLeft;
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [button setTitle:@"测试按钮" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"点评_icon_评论"] forState:UIControlStateNormal];

    [self.view addSubview:button];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
