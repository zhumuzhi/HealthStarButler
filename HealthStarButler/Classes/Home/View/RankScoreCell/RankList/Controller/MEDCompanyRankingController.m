//
//  MEDCompanyRankingController.m
//  健康之星管家
//
//  Created by 朱慕之 on 2017/8/19.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDCompanyRankingController.h"
#import "MEDCompanyRankModel.h"
#import "MEDCompanyRankCell.h"
#import "MEDCompanyRankHeadView.h"

#define pageNum 20

@interface MEDCompanyRankingController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *rankingDataArray;
@property (nonatomic, strong) NSMutableArray *originalData;
@property (nonatomic, strong) NSMutableArray *headData;
@property (nonatomic, assign) BOOL remove;
@property (nonatomic, assign) NSInteger pn;  //标记页数属性

@end

@implementation MEDCompanyRankingController

static  NSString *cellIdentifier = @"CompanyRankingCell";
#pragma mark - Lazy

#pragma mark Data
-(NSMutableArray *)rankingDataArray {
    if (_rankingDataArray == nil) {
        _rankingDataArray = [NSMutableArray array];
    }
    return _rankingDataArray;
}
- (NSMutableArray *)originalData {
    if (_originalData == nil) {
        _originalData = [NSMutableArray array];
    }
    return _originalData;
}

- (NSMutableArray *)headData {
    if (_headData == nil) {
        _headData = [NSMutableArray array];
    }
    return _headData;
}

#pragma mark TabelView
-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.separatorColor = MEDRGB(231, 231, 231);
        [_tableView registerNib:[UINib nibWithNibName:@"MEDCompanyRankCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    }
    return _tableView;
}


#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"分数排名";

    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf=self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->_pn = 0;
        [weakSelf getListData];
        [weakSelf getPersonalRankingData];
    }];

    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getMoreData];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

#pragma mark - requestData

- (void)getPersonalRankingData {

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [param setValue:userModel.uid forKey:@"uid"];
    }
    
    [MEDDataRequest GET:MED_PersonalScoreRank baseURL:MED_BASE_REQUEST params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"获取个人分数排名:%@", responseObject[@"data"]);
        
        if ([responseObject[@"status"] integerValue] == 0) {
            NSDictionary *dataDict  = [responseObject objectForKey:@"data"];
            MEDCompanyRankModel *rankMoel = [MEDCompanyRankModel rankModelinitWithDictionary:dataDict];
            
            NSMutableArray *tempArray = [NSMutableArray array];
            [tempArray addObject:rankMoel];
            self.headData = tempArray;
            
            [self.tableView reloadData];
            
        }else {
            NSLog(@"排名数据获取失败");
            [MEDProgressHUD dismissHUDErrorTitle:@"个人排名数据获取失败"];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"排名数据网络请求失败:%@",error);
        [MEDProgressHUD dismissHUDErrorTitle:@"个人排名网络请求失败"];
    }];
}



- (void)getListData{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [param setValue:userModel.uid forKey:@"uid"];
//        [param setValue:@(41954) forKey:@"uid"];
    }
    [param setObject:@(pageNum) forKey:@"ps"];    //每页显示数量
    [param setObject:@(_pn) forKey:@"pn"];   //第几页
    
    //NSLog(@"获取排名列表的网络请求参数:%@", param);
    [MEDDataRequest GET:MED_HomeScoreRankingList baseURL:MED_BASE_REQUEST params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"获取排名列表数据:%@", responseObject[@"data"]);
        
        if ([responseObject[@"status"] integerValue] == 0) {
            NSArray *dataArray  = [responseObject objectForKey:@"data"];
            
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dict in dataArray) {
                MEDCompanyRankModel *rankMoel = [MEDCompanyRankModel rankModelinitWithDictionary:dict];
                [tempArray addObject:rankMoel];
            }
            
            self.rankingDataArray = tempArray;
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
        }else {
            NSLog(@"排名数据获取失败");
            [self.tableView.mj_header endRefreshing];
            [MEDProgressHUD dismissHUDErrorTitle:@"排名数据请求失败"];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"排名数据网络请求失败:%@",error);
        [self.tableView.mj_header endRefreshing];
        [MEDProgressHUD dismissHUDErrorTitle:@"排名数据网络请求失败"];
    }];
}


/** 获取更多数据 */
- (void)getMoreData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    if (userModel.uid != nil) {
        [param setValue:userModel.uid forKey:@"uid"];
//        [param setValue:@(41954) forKey:@"uid"];
    }
    
    _pn ++;
    
    [param setObject:@(pageNum) forKey:@"ps"];    //每页显示数量
    [param setObject:@(_pn) forKey:@"pn"];   //第几页
    
    //NSLog(@"获取更多排名列表数据参数:%@", param);
    
    [MEDDataRequest GET:MED_HomeScoreRankingList baseURL:MED_BASE_REQUEST params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"获取更多排名列表数据:%@", responseObject[@"data"]);
        
        if ([responseObject[@"status"] integerValue] == 0) {
            
            NSArray *dataArray  = [responseObject objectForKey:@"data"];
            NSLog(@"代表页数的参数为：%ld", (long)self->_pn);
            NSLog(@"获取更多数据拿到的数组:%@", dataArray);
            
            if (dataArray.count>0 ) {
                
            }else {
                [MEDProgressHUD dismissHUDWithTitle:@"没有更多数据"];
                [self.tableView.mj_footer endRefreshing];
                return;
            }
        
            for (NSDictionary *dict in dataArray) {
                MEDCompanyRankModel *rankMoel = [MEDCompanyRankModel rankModelinitWithDictionary:dict];
                [self.rankingDataArray addObject:rankMoel];
            }
            
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        }else {
            NSLog(@"排名数据获取失败");
            [self.tableView.mj_footer endRefreshing];
            [MEDProgressHUD dismissHUDErrorTitle:@"排名数据请求失败"];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"排名数据网络请求失败:%@",error);
        [self.tableView.mj_footer endRefreshing];
        [MEDProgressHUD dismissHUDErrorTitle:@"排名数据网络请求失败"];
    }];
}

#pragma mark - TableViewDataSoucre
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rankingDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MEDCompanyRankCell *cell = [MEDCompanyRankCell rankCellWithTableView:tableView];
    MEDCompanyRankModel *model = self.rankingDataArray[indexPath.row];
    /*本人高亮逻辑
    NSString *dataUid = [NSString stringWithFormat:@"%ld", (long)model.uid];
    MEDUserModel *userModel = [MEDUserModel sharedUserModel];
    NSString *userUid = userModel.uid;
    if ([userUid isEqualToString:dataUid] ) {
        cell.cellBackView.backgroundColor = MEDRGB(243, 243, 243);
    }
    */
    cell.rankModel = model;
    return cell;
}

#pragma mark - TabelViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MEDCompanyRankHeadView *headView = [MEDCompanyRankHeadView rankHeadView];
    headView.rankModel = [self.headData firstObject];
    return headView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - flaseData
//    NSArray *dataArray = @[
//                           @{
//                               @"compliance": @0.0,
//                               @"physiologicalIndexMonitoring": @"0.0",
//                               @"habitsAndCustoms": @0.0,
//                               @"personalTotalScore": @"20.0",
//                               @"currentUser": @"false",
//                               @"uid": @41954,
//                               @"name": @"刘德华",
//                               @"orgId": @975,
//                               @"orgName": @"山东省电力集团公司",
//                               @"createTime": @"",
//                               @"variationTrend": @0,
//                               @"ranking": @"1",
//                               @"icon": @"",
//                               @"month": @"",
//                               @"quarter": @"",
//                               @"year": @""
//                               }
//                           ];
//    for (int i = 0; i < dataArray.count; i ++) {
//        NSDictionary *dic = dataArray[i];
//        MEDRankingModel *rankMoel = [[MEDRankingModel alloc]init];
//        rankMoel.name = dic[@"name"];
//        rankMoel.orgName = dic[@"orgName"];
//        rankMoel.personalTotalScore = dic[@"personalTotalScore"];
//        rankMoel.ranking = dic[@"ranking"];
//        [self.rankingDataArray addObject:rankMoel];
//    }
//    [_MEDCRTableView reloadData];



@end
