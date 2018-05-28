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
/** 饮食Cell */
#import "MEDHomeFoodPlanCell.h"
#import "MEDFeedBackModel.h"
#import "MEDFoodDateFeedbackCell.h"
/** 方案Cell */
#import "MEDHomeHealthPlanCell.h"
/** 资讯Cell */

#import "TDTouchID.h"


@interface MEDHomePageController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *homeTableView;

@property (nonatomic, strong) NSDictionary *rankData; //排名数据
@property (nonatomic, assign) BOOL isWriteFoodDate; //是否填写过饮食日志
@property (nonatomic, strong) MEDFeedBackModel *feedModel;

@property (nonatomic, copy) void(^myblock)(void);

@property (nonatomic, strong) NSDate *now;

@end

@implementation MEDHomePageController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavigation];
    
    [self getUserInfo];
    
    [self configTableView];
    
}


- (void)kovBase {
    /*
     */
    
    
}


- (void)kovTest {
    _now = [NSDate date];
    [self addObserver:self forKeyPath:@"now" options:NSKeyValueObservingOptionNew context:nil];
    NSLog(@"1");
    [self willChangeValueForKey:@"now"]; // 手动触发self.now的KVO，必写
    NSLog(@"2");
    [self didChangeValueForKey:@"now"]; // 手动触发self.now的KVO，必写
    NSLog(@"4");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@-%@-%@",keyPath, object, change);
}

#pragma mark - 指纹测试
/**
 验证 TouchID
 */
- (void)touchVerification {
    
    TDTouchID *touchID = [[TDTouchID alloc] init];
    
    [touchID td_showTouchIDWithDescribe:nil BlockState:^(TDTouchIDState state, NSError *error) {
        
        if (state == TDTouchIDStateNotSupport) {    //不支持TouchID
            [MEDProgressHUD dismissHUDErrorTitle:@"当前设备不支持TouchID, 请输入密码"];
            
        } else if (state == TDTouchIDStateSuccess) {    //TouchID验证成功
            
            NSLog(@"jump");
            [MEDProgressHUD dismissHUDSuccessTitle:@"指纹验证成功"];
            
            
        } else if (state == TDTouchIDStateInputPassword) { //用户选择手动输入密码
            [MEDProgressHUD dismissHUDErrorTitle:@"当前设备不支持TouchID, 请输入密码"];

        }
        
        // ps:以上的状态处理并没有写完全!
        // 在使用中你需要根据回调的状态进行处理,需要处理什么就处理什么
    }];
    
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
//    NSLog(@"首页获取的用户信息为:%@", userModel);
    /**  获取排名信息*/
    [self getPersonalScoreRank];
    /** 是否填写饮食日志 */
    [self isWriteFoodDateRequest];
    
    
}

/** 获取排名分数信息 */
- (void)getPersonalScoreRank {
    NSMutableDictionary *param= [NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    [param setValue:userModel.uid forKey:@"uid"];
    
    [MEDDataRequest POST:MED_PersonalScoreRank params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSLog(@"首页饮食日志填写确认网络请求:%@", responseObject[@"data"]);
        
        if(NetStatusSuccessful(responseObject)){
            NSDictionary *dataDict = responseObject[@"data"];
            self.rankData = dataDict;
            [self.homeTableView reloadData];
        }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"获取Rank数据失败");
            [self.homeTableView reloadData];
    }];
}

/** 判断是否填写饮食日志 */
- (void)isWriteFoodDateRequest {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [param setValue:userModel.uid forKey:@"uid"];
    }
    NSString *dateStr = [MEDDateUtils dateyyyyMMddStrFromDate:[NSDate date]];
    [param setValue:dateStr forKey:@"date"];
    MEDWeakSelf(self);
    [MEDDataRequest POST:MEDFOODDATE_RESULT params:param success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"首页饮食日志填写确认网络请求:%@", responseObject[@"data"]);
        if (NetStatusSuccessful(responseObject)) {
            NSDictionary *dataDic = responseObject[@"data"];
            if (dataDic.count != 0) { //如果不为零说明填写过
                weakself.isWriteFoodDate = YES;
                
                MEDFeedBackModel *feedModel = [[MEDFeedBackModel alloc]init];
                [feedModel feedBackDataWithDict:responseObject];
                weakself.feedModel = feedModel;
                
            } else {
                weakself.isWriteFoodDate = NO;
            }

        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        //[MEDProgressHUD dismissHUDErrorTitle:@"请连接网络"];
//        NSLog(@"首页饮食日志请求判断失败：%@",error);
    }];
}

- (void)getHealthPlan {
    //NSString *url = @"Scheme/base/listlastone";
    //参数
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [parameter setObject:userModel.uid forKey:@"uid"];
    }
    [MEDDataRequest GET:MED_NEW_PROJECT params:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"首页健康方案请求获得的结果:%@", responseObject[@"data"]);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"首页获取健康方案失败：%@",error);
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
    }else if(indexPath.section == 2){
        
        if (_isWriteFoodDate == YES) {
            MEDFoodDateFeedbackCell *cell = [MEDFoodDateFeedbackCell feedbackCellWithTableView:tableView];
            cell.feedModel = self.feedModel;
            return cell;
            
        }else {
            MEDHomeFoodPlanCell *cell = [MEDHomeFoodPlanCell homeFoodPlanCellWithTableView:tableView];
            return cell;
        }
    }else if(indexPath.section == 3){
        MEDHomeHealthPlanCell *cell = [MEDHomeHealthPlanCell homeHealthPlanCellWithTableView:tableView];
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
    //NSLog(@"选中了第%zd", indexPath.section);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    
    switch (section) {
        case 0:
        {
            MEDCompanyRankingController *rankList = [[MEDCompanyRankingController alloc] init];
            [self.navigationController pushViewController:rankList animated:YES];
            NSLog(@"排名Cell");
        }
            break;
        case 1:
        {
            NSLog(@"监测Cell");
            /** 指纹验证测试 */
            [self touchVerification];
            
        }
            break;
        case 2:
        {
            NSLog(@"饮食日志Cell");
        }
            break;
        case 3:
        {
            NSLog(@"健康方案Cell");
        }
            break;
        case 4:
        {
            NSLog(@"健康资讯Cell");
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 140.0f; //分数排名
    }else if(indexPath.section == 1){
        return 188.0f; //健康监测
    }else if(indexPath.section == 2){
        return 120.0f; //饮食日志
    }else if(indexPath.section == 3){
        return 130.0f; //健康方案
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
