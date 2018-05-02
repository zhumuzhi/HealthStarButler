//
//  MEDHomePageController.m
//  HealthStarButler
//
//  Created by 朱慕之 on 2018/4/17.
//  Copyright © 2018年 zhumuzhi. All rights reserved.
//

#import "MEDHomePageController.h"

#import "MEDHomeRankScoreCell.h"
#import "MEDCompanyRankingController.h"  //健康管理公司排名
#import "MEDHomeComplianceController.h"  //依从性
#import "MEDHomePhysiologyController.h"  //生理指标
#import "MEDHomeLifeHabitController.h"   //生活习惯

@interface MEDHomePageController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *homeTableView;

@end

@implementation MEDHomePageController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavigation];
    
    [self getUserInfo];
    
    [self.view addSubview:self.homeTableView];

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
}

#pragma mark - UI Config
/** 配置Navigation */
- (void)configNavigation {
    self.navigationItem.title = @"首页";
    [self setupPersonNavigationItem];
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
    if (indexPath.section == 0) {
        MEDHomeRankScoreCell *cell = [MEDHomeRankScoreCell homerankScoreCellWithTableView:tableView];
        MEDWeakSelf(self);
        cell.rankBtnClicked = ^(UIButton *button) {
                NSInteger btnTag = button.tag;
            [weakself pushToRankControllerWihtTag:btnTag];
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
-(void)pushToRankControllerWihtTag:(NSInteger)btnTag
{
    if (btnTag == 0) {
        NSLog(@"依从性");
        MEDHomeComplianceController *compliance = [[MEDHomeComplianceController alloc] init];
        [self.navigationController pushViewController:compliance animated:YES];
        
    }else if(btnTag == 1){
        MEDHomePhysiologyController *physiology = [[MEDHomePhysiologyController alloc] init];
        [self.navigationController pushViewController:physiology animated:YES];
        NSLog(@"生理指标");
    }else if(btnTag == 2){
        MEDHomeLifeHabitController *habit = [[MEDHomeLifeHabitController alloc] init];
        [self.navigationController pushViewController:habit animated:YES];
    }
}

@end
