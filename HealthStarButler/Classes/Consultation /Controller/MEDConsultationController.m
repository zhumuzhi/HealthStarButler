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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configButton];
}

- (void)configButton {
    
    FSButton *leftButton = [[FSButton alloc] init];
    [self.view addSubview:leftButton];
    
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(Navigation_Height+50);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    leftButton.buttonStyle = FSButtonImaegTypeLeft;
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [leftButton setTitle:@"北京" forState:UIControlStateNormal];
    //    [button setBackgroundColor:[UIColor lightGrayColor]];
    [leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"区域"] forState:UIControlStateNormal];
    
    FSButton *rightButton = [[FSButton alloc] init];
    [self.view addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftButton.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    rightButton.buttonStyle = FSButtonImaegTypeRight;
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [rightButton setTitle:@"收起" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"展开"] forState:UIControlStateNormal];
    
    FSButton *homeButton = [[FSButton alloc] init];
    [self.view addSubview:homeButton];
    [homeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightButton.mas_bottom).offset(50);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@50);
        make.width.equalTo(self.view).multipliedBy(0.5);
    }];
    homeButton.buttonStyle = FSButtonImaegTypeLeft;
    homeButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [homeButton setTitle:@"首页" forState:UIControlStateNormal];
    [homeButton setBackgroundColor:[UIColor whiteColor]];
    [homeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [homeButton setImage:[UIImage imageNamed:@"首页-2"] forState:UIControlStateNormal];
    
    FSButton *serviceButton = [[FSButton alloc] init];
    [self.view addSubview:serviceButton];
    [serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightButton.mas_bottom).offset(50);
        make.left.equalTo(homeButton.mas_right);
        make.height.equalTo(@50);
        make.width.equalTo(self.view).multipliedBy(0.5);
    }];
    serviceButton.buttonStyle = FSButtonImaegTypeLeft;
    serviceButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [serviceButton setTitle:@"联系客服" forState:UIControlStateNormal];
    [serviceButton setBackgroundColor:[UIColor orangeColor]];
    [serviceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [serviceButton setImage:[UIImage imageNamed:@"首页-2hei"] forState:UIControlStateNormal];
    
    
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
