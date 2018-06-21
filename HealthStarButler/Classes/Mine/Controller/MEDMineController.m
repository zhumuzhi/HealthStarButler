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
        _dataArray = @[@"个人资料",@"我的设备",@"重置密码",@"清除缓存",@"意见反馈",@"关于"];
    }
    return _dataArray;
}


#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self navigationConfig];

    [self getUserInfon];

}

#pragma mark - configUI
/** Navigation */
- (void)navigationConfig
{

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake(0, 0, 60, 44);
    [rightButton setTitle:@"退出" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickQuitButton) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;

    // 隐藏导航栏
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];//清空导航条的阴影线
}

- (void)configUIWithModel:(MEDUserModel *)model {

    // headView
    MEDMineHeadView *headView = [[MEDMineHeadView alloc] init];
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3);
    headView.userModel = model;
    [self.view addSubview:headView];
    self.headView = headView;

    // tableView
    CGFloat tableVieH = CGRectGetMaxY(headView.frame);
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableVieH, SCREEN_WIDTH, SCREEN_HEIGHT - tableVieH) style:UITableViewStylePlain];
    [tableView registerClass:[MEDClearCacheCell class] forCellReuseIdentifier:MEDClearCacheCellId];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}



#pragma mark --UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 3) {
        return [tableView dequeueReusableCellWithIdentifier:MEDClearCacheCellId];
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"minecell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"minecell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = MEDSYSFont(16);
        cell.textLabel.textColor = MEDGrayColor(40);
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.text = self.dataArray[indexPath.row];

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

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
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
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
