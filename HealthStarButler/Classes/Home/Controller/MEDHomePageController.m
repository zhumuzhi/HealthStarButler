//
//  MEDHomePageController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDHomePageController.h"

/** 排名Cell */
#import "MEDHomeRankScoreCell.h"
#import "MEDCompanyRankingController.h"  //健康管理公司排名
#import "MEDHomeComplianceController.h"  //依从性
#import "MEDHomePhysiologyController.h"  //生理指标
#import "MEDHomeLifeHabitController.h"   //生活习惯
/** 监测Cell */
#import "MEDHomeMonitorCell.h"

@interface MEDHomePageController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *homeTableView;

@property (nonatomic, strong) NSDictionary *rankData; //排名数据

@end

@implementation MEDHomePageController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavigation];
    
    [self getUserInfo];
    
    [self configTableView];
}

#pragma mark - NetWork
/** 获取用户信息 */
- (void)getUserInfo
{
    NSString *dataStr = [kUserDefaults objectForKey:UserInfo];
    //从UserDefaults 中获取用户信息
    NSDictionary *userInfoDict = [self dictionaryWithJsonString:dataStr];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    userModel = [MEDUserModel mj_objectWithKeyValues:userInfoDict];
    //NSLog(@"首页获取的用户信息为:%@", userModel);
    
    [self getPersonalScoreRank];
}

/** 获取排名分数信息 */
- (void)getPersonalScoreRank {
    NSMutableDictionary *param= [NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    [param setValue:userModel.uid forKey:@"uid"];
    
    [MEDDataRequest POST:MED_PersonalScoreRank params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if(StatusSuccessful(responseObject)){
            NSDictionary *dataDict = responseObject[@"data"];
            self.rankData = dataDict;
            [self.homeTableView reloadData];
        }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"获取Rank数据失败");
            [self.homeTableView reloadData];
    }];
    
}



#pragma mark - UI Config
/** 配置Navigation */
- (void)configNavigation {
    self.navigationItem.title = @"首页";
    [self setupPersonNavigationItem];
}

/** 配置tableView */
- (void)configTableView
{
    [self.view addSubview:self.homeTableView];
}

- (UITableView *)homeTableView
{
    if (!_homeTableView) {
        _homeTableView = [[UITableView alloc] initWithFrame:NormalFrame style:UITableViewStylePlain];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeTableView.tableFooterView = [UIView new];
    }
    return _homeTableView;
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MEDWeakSelf(self);
    
//    NSArray *cells = @[[MEDHomeRankScoreCell class], [MEDHomeMonitorCell class], [UITableViewCell class]];
    
    if (indexPath.section == 0) {
        MEDHomeRankScoreCell *cell = [MEDHomeRankScoreCell homeRankScoreCellWithTableView:tableView];
        cell.rankData = self.rankData;
        cell.rankBtnClicked = ^(UIButton *button) {
                NSInteger btnTag = button.tag;
            [weakself pushToRankControllerWihtTag:btnTag];
        };
        return cell;
    }else if(indexPath.section == 1){
        MEDHomeMonitorCell *cell = [MEDHomeMonitorCell homeMonitorCellWithTableView:tableView];
        cell.monitorBtnClicked = ^(UIButton *button) {
            NSInteger btnTag = button.tag;
            [weakself pushToMonitorControllerWihtTag:btnTag
             ];
        };
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeCell"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.section];
        return cell;
    }
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中了第%zd", indexPath.section);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    if (section == 0) {
        MEDCompanyRankingController *rankList = [[MEDCompanyRankingController alloc] init];
        [self.navigationController pushViewController:rankList animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 140.0f;
    }else if(indexPath.section == 1){
        return 188.0f;
    }else {
        return 44.0f;
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = MEDGrayColor(243);
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - Event
/** 跳转至排名cell相关Controller */
-(void)pushToRankControllerWihtTag:(NSInteger)btnTag
{
    NSArray *controllers = @[[MEDHomeComplianceController class], [MEDHomePhysiologyController class], [MEDHomeLifeHabitController class]];
    Class controller = controllers[btnTag];
    UIViewController *viewController = [[controller alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

/** 跳转至监测cell相关Controller */
-(void)pushToMonitorControllerWihtTag:(NSInteger)btnTag
{
    NSArray *controllers = @[[MEDCompanyRankingController class], [MEDCompanyRankingController class], [MEDCompanyRankingController class],  [MEDCompanyRankingController class], [MEDCompanyRankingController class], [MEDCompanyRankingController class], [MEDCompanyRankingController class], [MEDCompanyRankingController class]];
    Class controller = controllers[btnTag];
    UIViewController *viewController = [[controller alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
