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
#import "FSMineAcountCell.h" // 账户设置Cell
#import "FSMineOrderCell.h"  // 我的订单Cell
#import "FSMineNormalCell.h" // 设置/客服电话/清除缓存Cell

@interface FSMineController ()<UITableViewDataSource, UITableViewDelegate,
FSMineOrderCellDelegate //我的订单
>

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
    // 一行代码搞定导航栏透明度
    [self wr_setNavBarBackgroundAlpha:0];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - RequestData
- (void)loadData {
    self.dataArray = [FSMineMData creatMineMData];
}


#pragma mark - Event


#pragma mark - CustomDelegate
- (void)mineOrderCelldidClickAllOrder:(FSMineOrderCell *)mineOrderCell {
    NSLog(@"跳转到全部订单页面");
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
    
    if (indexPath.section == 0) {
        FSMineAcountCell *cell = [tableView dequeueReusableCellWithIdentifier:FSMineAcountCellID];
        cell.mineMData = rowMData;
        return cell;
    }else if (indexPath.section == 1) {
        FSMineOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:FSMineOrderCellID];
        cell.delegate = self;
        FSMineMData *mineData = [[FSMineMData alloc] init];
        cell.mineMData = mineData;
        return cell;
    }else {
        FSMineNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:FSMineNormalCellID];
        cell.mineMData = rowMData;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSLog(@"跳转至账号信息页面-待优化");
    } else if (indexPath.section == 2) {
        if (indexPath.row == 2) {
            NSLog(@"打电话弹窗");
            [self makePhoneCall];
        }else if( indexPath.row == 2) {
            
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    FSMineMData *sectionMData = [self.dataArray by_ObjectAtIndex:section];
    return sectionMData.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 174;
    }else if(indexPath.section == 1){
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
    
    ////    [MEDAlertMananger presentAlertWithTitle:@"客服电话" message:@"400-680-9666\n周一至周日:8:00~20:00" actionTitle:@[@"呼叫"] preferredStyle:UIAlertControllerStyleAlert handler:^(NSUInteger buttonIndex, NSString *buttonTitle) {
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
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.1, 0.1, 0.1, 0.1)];  // tableFooterView设置
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.sectionFooterHeight = 0.01;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏自带分割线
        _tableView.showsHorizontalScrollIndicator = NO; //关闭水平指示条
        // 指示线颜色
        _tableView.separatorColor = [UIColor colorWithHexString:@"#F5F5F5"];

        [_tableView registerClass:[FSMineAcountCell class] forCellReuseIdentifier:FSMineAcountCellID];
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

@end
