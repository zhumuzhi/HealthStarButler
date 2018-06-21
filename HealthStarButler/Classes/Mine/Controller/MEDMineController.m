//
//  MEDMineController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDMineController.h"
#import "AppDelegate.h"

@interface MEDMineController ()<UITableViewDelegate , UITableViewDataSource>

@end

@implementation MEDMineController

#pragma mark - Lazy

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    
    [self navigationConfig];
    
    [self setupUI];
}

#pragma mark - configUI
/** Navigation */
- (void)navigationConfig
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake(0, 0, 60, 44);
    [rightButton setTitle:@"退出" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickQuitButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    tableView.frame = self.view.frame;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
}



#pragma mark --UITableViewDelegate
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
////    cell.textLabel.text = self.nameList[indexPath.row];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    return cell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//}

#pragma mark - Event
/** 点击退出 */
- (void)clickQuitButton
{
    MEDWeakSelf(self);
    [MEDAlertMananger presentAlertWithTitle:@"退出" message:@"确认退出" actionTitle:@[@"确认"] preferredStyle:UIAlertControllerStyleAlert handler:^(NSUInteger buttonIndex, NSString *buttonTitle) {
        NSLog(@"@@~~ : %lu, %@", (unsigned long)buttonIndex, buttonTitle);
        
        if (buttonIndex==1) {
            [weakself.navigationController popViewControllerAnimated:NO];
            //保存登录信息
            [kUserDefaults setObject:LoginFailed forKey:Login];
            //切换打开程序后至登录页面(根据登录信息判断)
            [kAppDelegate mainTabBarSwitch];
        }
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    NSLog(@"个人中心收到内存警告");
    
}


@end
