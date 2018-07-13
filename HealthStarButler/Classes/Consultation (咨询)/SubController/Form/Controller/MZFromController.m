//
//  MZFromController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/13.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MZFromController.h"
#import "MZFromModel.h"
#import "MZFromCell.h"

@interface MZFromController ()<UITableViewDataSource, UITableViewDelegate, MZFromCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MZFromController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavigation];
    [self configUI];
    [self creatModeldata];
    
}

#pragma mark - Config_UI
- (void)configNavigation {
    self.navigationItem.title = @"个人中心";
}

- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - SetData
- (void)creatModeldata {
    MZFromModel *fromModel = [[MZFromModel alloc]init];
    self.dataArray = [fromModel creatFromMData];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MZFromCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MZFromCell"];
    cell.fromModel = self.dataArray [indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MZFromModel *fromModel = self.dataArray[indexPath.row];
    return fromModel.cellHeight;
}

#pragma mark - LazyGet

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:SecondPageFrame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[MZFromCell class] forCellReuseIdentifier:@"MZFromCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}






@end
