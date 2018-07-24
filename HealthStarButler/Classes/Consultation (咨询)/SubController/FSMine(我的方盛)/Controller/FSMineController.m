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
#import "FSMineHeader.h"     // 账户Header
#import "FSMineOrderCell.h"  // 我的订单Cell
#import "FSMineNormalCell.h" // 优惠卷/地址/设置/客服电话/清除缓存Cell

#import "FSAccountSetController.h" // 账号设置

@interface FSMineController ()<UITableViewDataSource, UITableViewDelegate,
                            FSMineHeaderDelegate,    // 账号信息
                            FSMineOrderCellDelegate, // 我的订单
                            FSMineNormalCellDelegate // 其他Cell
                            >
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) FSMineHeader *mineHeader;

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
    self.tableView.tableHeaderView = self.mineHeader;
}

#pragma mark - configNavigation
- (void)configNavigation {
    // 设置背景色
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    // 一行代码搞定导航栏透明度
    [self wr_setNavBarBackgroundAlpha:0];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - RequestData
- (void)loadData {
    self.dataArray = [FSMineMData creatMineMData];

    /* FIXME:网络请求后为Header赋值*/
    FSMineMData *mineData = [[FSMineMData alloc] init];
    mineData.acountName = @"账号：MEID123";
    mineData.permission = @"权限: 下单 结算 审批";
    mineData.iconUrl = @"list_denglutouxiang";
    self.mineHeader.mineMData = mineData;
}

#pragma mark - CustomDelegate

#pragma mark 账户信息
- (void)mineHeader:(FSMineHeader *)mineHeader mineModel:(FSMineMData *)mineModel eventType:(FSMineHeaderType)eventType {
    NSLog(@"跳转到我的信息");
    FSAccountSetController *accountSet = [[FSAccountSetController alloc] init];
    [self.navigationController pushViewController:accountSet animated:YES];
}
#pragma mark 我的订单
- (void)mineOrderCell:(FSMineOrderCell *)mineOrderCell mineModel:(FSMineMData *)mineModel orderBtnType:(FSMineOrderCellBtnType)orderBtnType {
    if (orderBtnType == FSMineOrderCellBtnTypeAllOrder) {
        NSLog(@"跳转到全部订单页面");
    }else if (orderBtnType == FSMineOrderCellBtnTypeExamine) {
        NSLog(@"跳转到待审核");
    }else if (orderBtnType == FSMineOrderCellBtnTypePay) {
        NSLog(@"跳转到待付款");
    }else if (orderBtnType == FSMineOrderCellBtnTypeReceiv) {
        NSLog(@"跳转到待发货");
    }else if (orderBtnType == FSMineOrderCellBtnTypeSend) {
        NSLog(@"跳转到代收货");
    }

}
#pragma mark 优惠卷/地址/电话/清除缓存/设置
- (void)mineNormalCell:(FSMineNormalCell *)mineNormalCell mineModel:(FSMineMData *)mineModel cellType:(FSMineCellType)cellType {
    FSMineCellType type = cellType;
    if (type == FSMineCellTypeTicket) {
        NSLog(@"我的优惠卷");
    }else if (type == FSMineCellTypeAddress) {
        NSLog(@"我的地址");
    }else if (type == FSMineCellTypeServicePhone) {
        NSLog(@"弹出客服电话");
        [self makePhoneCall];
    }else if (type == FSMineCellTypeClearCache) {
        NSLog(@"清除缓存");
    }else if (type == FSMineCellTypeSetting) {
        NSLog(@"跳转至设置页面");
    }
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FSMineMData *sectionMData = [self.dataArray by_ObjectAtIndex:section];
    return sectionMData.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FSMineMData *sectionMData = [self.dataArray by_ObjectAtIndex:indexPath.section];
    FSMineMData *rowMData = [sectionMData.items by_ObjectAtIndex:indexPath.row];

    if (indexPath.section == 0) {  //订单cell
        FSMineOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:FSMineOrderCellID];
        cell.delegate = self;
        /* FIXME:订单类型调整*/
        cell.orderType = 1;
        FSMineMData *mineData = [[FSMineMData alloc] init];
        cell.mineMData = mineData;
        return cell;
    }else { //优惠卷/地址/设置/客服电话/清除缓存Cell
        FSMineNormalCell *cell = [[FSMineNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FSMineNormalCellID cellForRowAtIndexPath:indexPath withTable:tableView];
        cell.delegate = self;
        cell.mineMData = rowMData;
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    FSMineMData *sectionMData = [self.dataArray by_ObjectAtIndex:section];
    return sectionMData.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return 128;
    }else {
        return 50;
    }
}

#pragma mark - Private Methods
//*拨打客服电话*/
- (void)makePhoneCall {
    
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",@"4006809666"];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
    
    //    [MEDAlertMananger presentAlertWithTitle:@"客服电话" message:@"400-680-9666\n周一至周日:8:00~20:00" actionTitle:@[@"呼叫"] preferredStyle:UIAlertControllerStyleAlert handler:^(NSUInteger buttonIndex, NSString *buttonTitle) {
    //    [MEDAlertMananger presentAlertWithTitle:@"400-680-9666" message:@"周一至周日:8:00~20:00" actionTitle:@[@"呼叫"] preferredStyle:UIAlertControllerStyleAlert handler:^(NSUInteger buttonIndex, NSString *buttonTitle) {
    //
    //        if (buttonIndex == 1) {
    //        }
    //    }];
}

#pragma mark - LazyGet
static NSString *identify = @"cellIdentify";
static NSString *FSMineAcountCellID = @"FSMineAcountCellID";
static NSString *FSMineNormalCellID = @"FSMineNormalCellID";
static NSString *FSMineOrderCellID = @"FSMineOrderCellID";

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -kNavigationHeight, kScreenWidth, kScreenHeight-kTabbarSafeBottomMargin) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动隐藏键盘
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏自带分割线
        _tableView.showsHorizontalScrollIndicator = NO; //关闭水平指示条
        _tableView.layer.drawsAsynchronously = true;//异步绘制cell的layer

        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.1, 0.1, 0.1, 0.1)];  // tableFooterView设置
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.sectionFooterHeight = 0.01;
        [_tableView registerClass:[FSMineNormalCell class] forCellReuseIdentifier:FSMineNormalCellID];
        [_tableView registerClass:[FSMineOrderCell class] forCellReuseIdentifier:FSMineOrderCellID];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (FSMineHeader *)mineHeader {
    if (_mineHeader == nil) {
        CGFloat statusBarH = [[UIApplication sharedApplication] statusBarFrame].size.height;
        _mineHeader = [[FSMineHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kAutoWithSize(174 + statusBarH))];
        _mineHeader.delegate = self;
    }
    return _mineHeader;
}

@end
