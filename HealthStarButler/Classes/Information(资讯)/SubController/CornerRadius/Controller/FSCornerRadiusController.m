//
//  FSCornerRadiusController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/8/6.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSCornerRadiusController.h"
#import "FSCornerRadiusCell.h"

@interface FSCornerRadiusController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FSCornerRadiusController

static NSString *FSCornerRadiusCellID = @"FSCornerRadiusCellID";

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];
}

#pragma mark - configUI
- (void)configUI {
    [self.view addSubview:self.tableView];
    [self configuration];
}
#pragma mark - configNavigation
- (void)configuration {
    self.navigationItem.title = @"圆角阴影";
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FSCornerRadiusCell *cell = [FSCornerRadiusCell cornerCellWithTableView:tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd-%zd", indexPath.section, indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

#pragma mark - LazyGet
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动隐藏键盘
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏自带分割线
        _tableView.showsHorizontalScrollIndicator = NO;                 //关闭水平指示条
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.1f, 0.1f, 0.1f, 0.1f)];  // tableFooterView设置
        [_tableView registerClass:[FSCornerRadiusCell class] forCellReuseIdentifier:FSCornerRadiusCellID];
    }
    return _tableView;
}

@end
