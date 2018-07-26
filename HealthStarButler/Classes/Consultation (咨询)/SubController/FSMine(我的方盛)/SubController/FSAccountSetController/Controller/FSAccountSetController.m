//
//  FSAccountSetController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/7/24.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//  账户设置

#import "FSAccountSetController.h"
#import "FSAccountSetMData.h"
#import "FSAccountSetHeadCell.h"
#import "FSAccountSetNormalCell.h"

@interface FSAccountSetController ()<UITableViewDataSource, UITableViewDelegate, FSAccountSetNormalCellDelegate>

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
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [self.view addSubview:self.tableView];
//    UIView *view = [UIView new];
//    view.height = 0.1;
//    self.tableView.tableFooterView = view;
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
    
    if (account.cellType == FSAcountSetTypeAcount) {
        FSAccountSetHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:FSAccountSetHeadCellID];
        FSAccountSetMData *accountData = [self.dataArray by_ObjectAtIndex:indexPath.row];
        cell.accountData = accountData;
        return cell;
    }else if (account.cellType == FSAcountSetTypeSpace){
        FSSpaceCell *cell = [tableView dequeueReusableCellWithIdentifier:FSSpaceCellID];
        cell.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        return cell;
    }else{
        FSAccountSetNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:FSAccountSetNormalCellID];
        cell.delegate = self;
        FSAccountSetMData *accoutSetMData = [self.dataArray by_ObjectAtIndex:indexPath.row];
        cell.accoutSetMData = accoutSetMData;
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
//FSAccountSetNormalCellDelegate
- (void)accountSetNormalCell:(FSAccountSetNormalCell *)accountCell dataModel:(FSAccountSetMData *)dataModel acountSetType:(FSAcountSetType)acountSetType {

    if (acountSetType == FSAcountSetTypeInfo) {
        NSLog(@"跳转到账号信息");
    }else if (acountSetType == FSAcountSetTypeAddress) {
        NSLog(@"跳转到账号地址");
    }else if (acountSetType == FSAcountSetTypeLoginWord) {
        NSLog(@"跳转到登录密码");
    }else if (acountSetType == FSAcountSetTypePayWord) {
        NSLog(@"跳转到支付密码");
    }else if (acountSetType == FSAcountSetTypeQuit) {
        NSLog(@"退出登录");
    }
}

#pragma mark - LazyGet
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

static NSString *FSAccountSetHeadCellID = @"FSAccountSetHeadCellID";
static NSString *FSSpaceCellID = @"FSSpaceCellID";
static NSString *FSAccountSetNormalCellID = @"FSAccountSetNormalCellID";

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight-kNavigationHeight-kTabbarSafeBottomMargin) style:UITableViewStylePlain];
        self.tableView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动隐藏键盘
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏自带分割线
        _tableView.showsHorizontalScrollIndicator = NO;                 //关闭水平指示条
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.01, 0.01, 0.01, 0.01)];  // tableFooterView设置
        [_tableView registerClass:[FSAccountSetHeadCell class] forCellReuseIdentifier:FSAccountSetHeadCellID];
        [_tableView registerClass:[FSSpaceCell class] forCellReuseIdentifier:FSSpaceCellID];
        [_tableView registerClass:[FSAccountSetNormalCell class] forCellReuseIdentifier:FSAccountSetNormalCellID];
    }
    return _tableView;
}

#pragma mark - Event

#pragma mark - Private Methods

#pragma mark - Public Method

@end

