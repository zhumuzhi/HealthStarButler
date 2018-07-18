//
//  FSMineController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/18.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "FSMineController.h"

//Model
#import "FSMineMData.h"
//View
#import "FSMineCell.h"


@interface FSMineController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FSMineController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self configUI];
    
    
}

#pragma mark - configUI

- (void)configUI {
    [self configNavigation];
    [self.view addSubview:self.tableView];
}

#pragma mark - configNavigation
- (void)configNavigation {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的方盛";
}

#pragma mark - RequestData
- (void)loadData {
    self.dataArray = [FSMineMData creatMineMData];
}


#pragma mark - Event



#pragma mark - LazyGet
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:NormalFrame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动隐藏键盘
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.1, 0.1, 0.1, 0.1)];  // tableFooterView设置
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏自带分割线
        //_tableView.showsVerticalScrollIndicator = NO; //关闭垂直指示条
        _tableView.showsHorizontalScrollIndicator = NO; //关闭水平指示条
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
         _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    FSMineMData *mineData = self.dataArray[indexPath.row];
    
    cell.textLabel.text = mineData.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}





@end
