//
//  MEDTestReportListController.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/4.
//  Copyright © 2017年 mmednet. All rights reserved.
//  检测报告

#import "MEDTestReportListController.h"
#import "MEDTestReportModel.h"
#import "MEDMedicalRecordCommonCell.h"
#import "MEDEditTestReportController.h"

@interface MEDTestReportListController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *testReportData;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MEDTestReportListController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self getTestReport]; //获取检测报告
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getTestReport];
}


//tableViewLazy
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = MEDCommonBgColor;
    }
    return _tableView;
}

#pragma mark - dataRequest
/**
 获取检测报告
 */
- (void)getTestReport {
    
    NSString *MEDQueryDetectionReportURL = @"medical/queryDetectionReport";
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",MED_DOMAIN_REQUEST,MEDQueryDetectionReportURL];
    
    NSString *uid = @"520";
    NSString *currPage = @"1";
    NSString *pageSize = @"15";
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:uid forKey:@"uid"];
    [param setValue:currPage forKey:@"currPage"];
    [param setValue:pageSize forKey:@"pageSize"];
    
    
    [MEDDataRequest POST:URL params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"staus"] integerValue] == 0) { //网络请求成功
            NSLog(@"获取数据成功:%@",responseObject[@"data"]);
            NSArray *dataArray = [self arrayWithJsonString:responseObject[@"data"]];
            NSLog(@"获取检测报告的网络请求数据:%@",dataArray);
            
            //测试Log
            NSDictionary *dict = [self dictionaryWithJsonString:responseObject[@"data"]];
            NSLog(@"获取检测报告的网络请求数据:%@",dict);
            NSString *str = [self dictionaryToJson:dict];
            NSLog(@"最终的Str为:%@", str);
            
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dict in dataArray) {
                MEDTestReportModel *testReport = [MEDTestReportModel testReportWithDict:dict];
                [tempArray addObject:testReport];
            }
            self.testReportData = tempArray;
            
            [self.tableView reloadData];

        }else {
            NSLog(@"获取数据失败");
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"网络请求失败为:%@",error);
    }];
    
}

static NSString * const TestReportID = @"TestReportID";

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.testReportData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MEDMedicalRecordCommonCell *cell = [MEDMedicalRecordCommonCell cellWithTableView:tableView Identifier:TestReportID];
    
    MEDTestReportModel *model = self.testReportData[indexPath.row];
    cell.TestReportModel = model;
    
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setSeparatorWithTarget:cell Inset:UIEdgeInsetsZero];
}

- (void)setSeparatorWithTarget:(id)target Inset:(UIEdgeInsets)inset {
    [target setSeparatorInset:inset];
    if ([target respondsToSelector:@selector(setLayoutMargins:)]) {
        [target setLayoutMargins:inset];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MEDEditTestReportController *editView = [[MEDEditTestReportController alloc] init];
   
    MEDTestReportModel *model = self.testReportData[indexPath.row];
    editView.testReportModel = model;
    
//    editView.testReportData = self.testReportData;
    [self.navigationController pushViewController:editView animated:YES];
}



#pragma mark - Lazy
//data
-(NSArray *)testReportData
{
    if (_testReportData == nil) {
        _testReportData = [NSArray array];
    }
    return _testReportData;
}


- (NSArray *)arrayWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                     options:NSJSONReadingMutableContainers
                                                       error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
