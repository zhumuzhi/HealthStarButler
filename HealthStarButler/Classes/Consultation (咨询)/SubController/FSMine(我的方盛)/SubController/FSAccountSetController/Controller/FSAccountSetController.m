//
//  FSAccountSetController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/24.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//  账户设置

#import "FSAccountSetController.h"
#import "FSAccountSetMData.h"

@interface FSAccountSetController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FSAccountSetController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
    [self setupUI];
}

#pragma mark - configUI
- (void)setupUI {
    self.navigationItem.title = @"账号设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - RequestData
- (void)loadData {
    self.dataArray = [FSAccountSetMData creatAccountSetData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FSAccountSetMData *account = [self.dataArray by_ObjectAtIndex:indexPath.row];
    
    if (account.cellType == FSAcountSetTypeSpace) {
        FSSpaceCell *cell = [tableView dequeueReusableCellWithIdentifier:FSSpaceCellID];
        cell.backgroundColor = [UIColor lightGrayColor];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = account.title;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FSAccountSetMData *account = [self.dataArray by_ObjectAtIndex:indexPath.row];
    return account.cellHeight;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - CustomDelegate


#pragma mark - LazyGet
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

static NSString *FSSpaceCellID = @"FSSpaceCellID";
static NSString *identify = @"cellIdentify";
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动隐藏键盘
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏自带分割线
        _tableView.showsHorizontalScrollIndicator = NO;                 //关闭水平指示条
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.1f, 0.1f, 0.1f, 0.1f)];  // tableFooterView设置

        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identify];
        [_tableView registerClass:[FSSpaceCell class] forCellReuseIdentifier:FSSpaceCellID];

        // MJFooter设置
        //MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        //[footer setTitle:@"到底了" forState:MJRefreshStateNoMoreData];
        //_tableView.mj_footer = footer;
    }
    return _tableView;
}

#pragma mark - Event

#pragma mark - Private Methods

#pragma mark - Public Method

@end

