//
//  FSLoginViewController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/14.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//  FS登录

#import "FSLoginViewController.h"
// Model
#import "FSLoginNData.h"
#import "FSLoginMData.h"
// View
#import "FSLoginHeader.h"
#import "FSLoginCell.h"

@interface FSLoginViewController ()<UITableViewDataSource, UITableViewDelegate, FSLoginCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) FSLoginHeader *header;

@end

@implementation FSLoginViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self configuration];
    [self configUI];
}

#pragma mark - configUI
- (void)configUI {
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.header;
}

- (void)configuration {
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[FSLoginCell class] forCellReuseIdentifier:@"FSLoginCell"];
    self.tableView.frame = self.view.bounds;
    self.navigationController.navigationBarHidden = YES;
//    self.statusBar.hidden = YES;
}


#pragma mark - RequestData
- (void)loadData {
    FSLoginMData *loginMData = [[FSLoginMData alloc] init];
    self.dataArray = [loginMData creatLoginMData];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FSLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FSLoginCell"];
    cell.rowMData = [self.dataArray by_ObjectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - OtherDelegate
- (void)FSLoginCellDelegateDidClick:(FSLoginCell *)loginCell {
    
    if(loginCell.rowMData.loginCellType == FSLoginCellTypeUserAcount){

        [self.view hideAllToasts];
        CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
        style.horizontalPadding = 50.0;
        style.verticalPadding = 30.0;
        [self.view makeToast:@"验证码输入错误" duration:2.0 position:CSToastPositionCenter style:style];

    }else if (loginCell.rowMData.loginCellType == FSLoginCellTypePassword) {
        [self.view hideAllToasts];
        [self.view makeToast:@"用户名密码错误，请重新输入"
                    duration:2.0
                    position:CSToastPositionCenter];

    }else if (loginCell.rowMData.loginCellType == FSLoginCellTypeCode) {
        [self.view hideAllToasts];
        [self.view makeToast:@"两次密码不一样，请重新输入"
                    duration:2.0
                    position:CSToastPositionCenter];
    }
}



#pragma mark - LazyGet

- (FSLoginHeader *)header {
    if (_header == nil) {
        _header = [[FSLoginHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    }
    return _header;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动隐藏键盘
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.1f, 0.1f, 0.1f, 0.1f)];  // tableFooterView设置
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}






@end
