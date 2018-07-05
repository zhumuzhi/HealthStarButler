//
//  ShowDemoController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/6/21.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "ShowDemoController.h"

#import "MEDHealthKitListController.h"

@interface ShowDemoController ()<UITableViewDelegate , UITableViewDataSource>

/** 功能列表 */
@property (nonatomic , strong)NSArray *nameList;

@end

@implementation ShowDemoController

#pragma mark - Lazy
-(NSArray *)nameList{
    if (!_nameList) {
        _nameList = @[@"HealtKitDemo展示"];
    }
    return _nameList;
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"功能展示";

    [self navigationConfig];

    [self setupUI];
}

#pragma mark - configUI
/** Navigation */
- (void)navigationConfig
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake(0, 0, 60, 44);
    [rightButton setTitle:@"按钮" forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(clickQuitButton) forControlEvents:UIControlEventTouchUpInside];

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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.nameList[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 0) {
        MEDHealthKitListController *list = [[MEDHealthKitListController alloc] init];
        [self.navigationController pushViewController:list animated:YES];
    }
}

#pragma mark - Event


@end
