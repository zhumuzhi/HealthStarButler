//
//  MEDMineController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDMineController.h"
#import "AppDelegate.h"
#import "MEDMineHeadView.h"
#import "MEDClearCacheCell.h"

#import "MEDPersonalData.h" // 个人资料
#import "MEDShopingCartController.h" // 购物车测试


@interface MEDMineController ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic, weak) MEDMineHeadView *headView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

static NSString * const MEDClearCacheCellId = @"MEDClearCacheCellId";

@implementation MEDMineController

#pragma mark - Lazy

- (NSArray *)dataArray {
    if (!_dataArray) {
        NSArray *tempArr1 = @[@"个人资料"];
        NSArray *tempArr2 = @[@"我的设备"];
        NSArray *tempArr3 = @[@"重置密码"];
        NSArray *tempArr4 = @[@"清除缓存", @"意见反馈", @"关于"];
        _dataArray = @[tempArr1,tempArr2,tempArr3,tempArr4];
    }
    return _dataArray;
}


#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configNavigation];

    [self getUserInfon];

}

#pragma mark - configUI
/** Navigation */
- (void)configNavigation
{
    [self wr_setNavBarBackgroundAlpha:0];
}

- (void)configUIWithModel:(MEDUserModel *)model {

    // headView
    MEDMineHeadView *headView = [[MEDMineHeadView alloc] init];
    headView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight/3);
    headView.userModel = model;
    [self.view addSubview:headView];
    self.headView = headView;

    // tableView
    CGFloat tableVieH = CGRectGetMaxY(headView.frame);
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableVieH, kScreenWidth, kScreenHeight - tableVieH) style:UITableViewStylePlain];
    [tableView registerClass:[MEDClearCacheCell class] forCellReuseIdentifier:MEDClearCacheCellId];
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;

    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - CGRectGetMaxY(self.tableView.frame))];
    footerView.backgroundColor = MEDGrayColor(240);
    // 退出按钮
    UIButton *quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    quitButton.frame = CGRectMake(10, 20, kScreenWidth-20, 40);
    quitButton.layer.masksToBounds = YES;
    quitButton.layer.cornerRadius = 5;
    quitButton.backgroundColor = MEDRGB(254, 86, 101);
    quitButton.titleLabel.font = MEDSYSFont(18);
    [quitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [quitButton addTarget:self action:@selector(clickQuitButton) forControlEvents:UIControlEventTouchUpInside];

    [footerView addSubview:quitButton];

    tableView.tableFooterView = footerView;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark --UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rows = self.dataArray[section];
    return rows.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"minecell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"minecell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = MEDSYSFont(16);
    cell.textLabel.textColor = MEDGrayColor(40);
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    NSArray *rows = self.dataArray[indexPath.section];

    if (indexPath.section == 3) {
        if (indexPath.row == 0) { //缓存cell
            return [tableView dequeueReusableCellWithIdentifier:MEDClearCacheCellId];
        }else {

            cell.textLabel.text = rows[indexPath.row];
            return cell;
        }
    }else {
        cell.textLabel.text = rows[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        MEDPersonalData *personal = [[MEDPersonalData alloc] init];
        [self.navigationController pushViewController:personal animated:YES];
    }else {
        MEDShopingCartController *CarVC = [[MEDShopingCartController alloc] init];
        [self.navigationController pushViewController:CarVC animated:YES];
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headLine = [[UIView alloc] init];
    headLine.backgroundColor = MEDGrayColor(240);
    return headLine;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}


#pragma mark - 网络请求
- (void)getUserInfon    {
    NSMutableDictionary * params =[NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [params setValue:userModel.uid forKey:@"uid"];
    }
    NSLog(@"个人中心网络请求的参数:%@",params);
    [MEDDataRequest GET:MED_GET_USERINFO params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //MYLog(@"个人中心-GET个人信息-返回数据:%@",responseObject);
        if ([responseObject[@"status"] integerValue] == Status_OK) {
            NSDictionary *dict = responseObject[@"data"];
            MEDUserModel *userModel = [MEDUserModel mj_objectWithKeyValues:dict];
            [self configUIWithModel:userModel];
        }
        [MEDProgressHUD dismissHUD];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [MEDProgressHUD dismissHUD];
        NSLog(@"获取个人信息失败:%@",error);
    }];
}

#pragma mark - Event
/** 点击退出 */
- (void)clickQuitButton
{
    MEDWeakSelf(self);
    [MEDAlertMananger presentAlertWithTitle:@"退出" message:@"确认退出" actionTitle:@[@"确认"] preferredStyle:UIAlertControllerStyleAlert handler:^(NSUInteger buttonIndex, NSString *buttonTitle) {
        NSLog(@"@@~~ : %lu, %@", (unsigned long)buttonIndex, buttonTitle);
        
        if (buttonIndex==1) {
            [weakself.navigationController popViewControllerAnimated:NO];
            //保存登录信息
            [kUserDefaults setObject:LoginFailed forKey:Login];
            //切换打开程序后至登录页面(根据登录信息判断)
            [kAppDelegate mainTabBarSwitch];
        }
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"个人中心收到内存警告");
    
}

@end
