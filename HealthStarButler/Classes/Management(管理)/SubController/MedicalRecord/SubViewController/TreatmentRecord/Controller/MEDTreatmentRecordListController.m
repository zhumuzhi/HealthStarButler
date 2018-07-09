//
//  MEDTreatmentRecordListController.m
//  BaseProject
//
//  Created by 朱慕之 on 2017/7/4.
//  Copyright © 2017年 mmednet. All rights reserved.
//  诊疗记录

#import "MEDTreatmentRecordListController.h"
#import "MEDTreatmentRecordModel.h"
#import "MEDMedicalRecordCommonCell.h"

#import "MEDAddTreatmentRecordController.h"

@interface MEDTreatmentRecordListController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *treatmentData;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MEDTreatmentRecordListController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self getTreatmentRecord];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getTreatmentRecord];
    NSLog(@"每次进入页面刷新对应吗模块列表, 或者增加标记，只有从添加或者保存页面返回才刷新");
}


//tableView
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _tableView.contentInset = UIEdgeInsetsMake(64 , 0, 0, 0);
        
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
 获取诊疗记录列表
 */
- (void)getTreatmentRecord {
    
    NSString *QueryDiagnosisTreatRecord= @"medical/queryDiagnosisTreatRecord";
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",MED_DOMAIN_REQUEST,QueryDiagnosisTreatRecord];
    
    NSString *uid = @"676";
    NSString *currPage = @"1";
    NSString *pageSize = @"15";
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:uid forKey:@"uid"];
    [param setValue:currPage forKey:@"currPage"];
    [param setValue:pageSize forKey:@"pageSize"];
    
    
    [MEDDataRequest POST:URL params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"staus"] integerValue] == 0) { //网络请求成功
            NSLog(@"获取数据成功:%@",responseObject[@"data"]);
            
            NSArray *dataArray = responseObject[@"data"];
            
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dict in dataArray ) {
                MEDTreatmentRecordModel *treatment = [MEDTreatmentRecordModel treatmentRecordWithDictionary:dict];
                [tempArray addObject:treatment];
            }
            self.treatmentData = tempArray;
            
            [self.tableView reloadData];
            
        }else {
            NSLog(@"获取数据失败");
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"网络请求失败为:%@",error);
    }];
}

#pragma mark - TableViewDataSource

static NSString * const treatmentID = @"treatmentCell";

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.treatmentData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MEDMedicalRecordCommonCell *cell = [MEDMedicalRecordCommonCell cellWithTableView:tableView Identifier:treatmentID];
        MEDTreatmentRecordModel *model = self.treatmentData[indexPath.row];
    cell.TreatmentRecordModel = model;
    
    return cell;
}

#pragma mark - TableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MEDAddTreatmentRecordController *addVC = [MEDAddTreatmentRecordController alloc];
    addVC.treatmentModel = self.treatmentData[indexPath.row];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setSeparatorWithTarget:cell Inset:UIEdgeInsetsZero];
}

- (void)setSeparatorWithTarget:(id)target Inset:(UIEdgeInsets)inset {
    [target setSeparatorInset:inset];
    if ([target respondsToSelector:@selector(setLayoutMargins:)]) {
        [target setLayoutMargins:inset];
    }
}

#pragma mark - Lazy
//data
- (NSArray *)treatmentData
{
    if (_treatmentData == nil) {
        _treatmentData = [NSArray array];
    }
    return _treatmentData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
