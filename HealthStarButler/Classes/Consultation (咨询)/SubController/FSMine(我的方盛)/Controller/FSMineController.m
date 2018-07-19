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
#import "FSMineNormalCell.h" // 设置/客服电话/清除缓存

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
//    FSMineMData *mineData = [[FSMineMData alloc] init];
//    self.dataArray = [NSMutableArray arrayWithArray:mineData.items];
    self.dataArray = [FSMineMData creatMineMData];
}

#pragma mark - Event



#pragma mark - LazyGet

static NSString *FSMineNormalCellID = @"FSMineNormalCellID";
static NSString *identify = @"cellIdentify";

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:SecondPageFrame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动隐藏键盘
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.1, 0.1, 0.1, 0.1)];  // tableFooterView设置
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.sectionFooterHeight = 0.01;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏自带分割线
        _tableView.showsHorizontalScrollIndicator = NO; //关闭水平指示条

        [_tableView registerClass:[FSMineNormalCell class] forCellReuseIdentifier:FSMineNormalCellID];

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

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        cell.textLabel.text = rowMData.title;
        return cell;
    }else {
        FSMineNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:FSMineNormalCellID];
        cell.mineMData = rowMData;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    FSMineMData *sectionMData = [self.dataArray by_ObjectAtIndex:section];
    return sectionMData.sectionHeaderHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            NSLog(@"打电话弹窗");
            [self makePhoneCall];
        }
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
//            NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",@"4006809666"];
//            if (@available(iOS 10.0, *)) {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
//            } else {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
//            }
//        }
//    }];
}





@end
